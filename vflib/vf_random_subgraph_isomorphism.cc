/* vim: set sw=4 sts=4 et foldmethod=syntax : */

#include "argraph.h"
#include "argedit.h"
#include "argloader.h"
#include "match.h"
#include "vf2_mono_state.h"
#include "vf2_sub_state.h"

#include <fstream>
#include <iostream>
#include <thread>
#include <condition_variable>
#include <mutex>
#include <atomic>
#include <cstdlib>
#include <chrono>
#include <vector>

#include <boost/program_options.hpp>

namespace po = boost::program_options;

using std::chrono::milliseconds;
using std::chrono::steady_clock;
using std::chrono::duration_cast;

namespace
{
    auto create_random_graph(int size, double density, int seed, ARGEdit & ed, std::vector<int> & loops) -> void
    {
        std::mt19937 rand;
        rand.seed(seed);
        std::uniform_real_distribution<double> dist(0.0, 1.0);

        loops.resize(size);
        for (int i = 0 ; i < size ; ++i)
            ed.InsertNode(&loops[i]);

        for (int e = 0 ; e < size ; ++e) {
            for (int f = e + 1 ; f < size ; ++f) {
                if (dist(rand) <= density)
                    ed.InsertEdge(e, f, NULL);
            }
        }
    }

    struct OurComparator : AttrComparator
    {
        virtual bool compatible(void *attr1, void *attr2)
        {
            return *static_cast<int *>(attr1) == *static_cast<int *>(attr2);
        }
    };
}

int main(int argc, char * argv[])
{
    try {
        po::options_description display_options{ "Program options" };
        display_options.add_options()
            ("help",                                  "Display help information")
            ("timeout",            po::value<int>(),  "Abort after this many seconds")
            ("induced",                               "Induced version")
            ;

        po::options_description all_options{ "All options" };
        all_options.add_options()
            ("pattern-size",    po::value<int>(),     "Number of pattern vertices")
            ("pattern-density", po::value<double>(),  "Pattern density")
            ("pattern-seed",    po::value<int>(),     "Pattern seed")
            ("target-size",     po::value<int>(),     "Number of target vertices")
            ("target-density",  po::value<double>(),  "Target density")
            ("target-seed",     po::value<int>(),     "Target seed")
            ;

        all_options.add(display_options);

        po::positional_options_description positional_options;
        positional_options
            .add("pattern-size", 1)
            .add("pattern-density", 1)
            .add("pattern-seed", 1)
            .add("target-size", 1)
            .add("target-density", 1)
            .add("target-seed", 1)
            ;

        po::variables_map options_vars;
        po::store(po::command_line_parser(argc, argv)
                .options(all_options)
                .positional(positional_options)
                .run(), options_vars);
        po::notify(options_vars);

        /* --help? Show a message, and exit. */
        if (options_vars.count("help")) {
            std::cout << "Usage: " << argv[0] << " [options] pattern-size pattern-density pattern-seed target-size target-density target-seed" << std::endl;
            std::cout << std::endl;
            std::cout << display_options << std::endl;
            return EXIT_SUCCESS;
        }

        /* No algorithm or no input file specified? Show a message and exit. */
        if (! options_vars.count("pattern-size") || ! options_vars.count("pattern-density") || ! options_vars.count("pattern-seed") ||
                ! options_vars.count("target-size") || ! options_vars.count("target-density") || ! options_vars.count("target-seed")) {
            std::cout << "Usage: " << argv[0] << " [options] pattern-size pattern-density pattern-seed target-size target-density target-seed" << std::endl;
            return EXIT_FAILURE;
        }

        ARGEdit pattern_ed, target_ed;
        std::vector<int> pattern_loops, target_loops;

        create_random_graph(options_vars["pattern-size"].as<int>(),
                options_vars["pattern-density"].as<double>(),
                options_vars["pattern-seed"].as<int>(),
                pattern_ed, pattern_loops);

        create_random_graph(options_vars["target-size"].as<int>(),
                options_vars["target-density"].as<double>(),
                options_vars["target-seed"].as<int>(),
                target_ed, target_loops);

        int n;
        node_id ni1[8000], ni2[8000];

        std::thread timeout_thread;
        std::mutex timeout_mutex;
        std::condition_variable timeout_cv;

        std::atomic<int> state;
        state.store(0);

        /* Start the clock */
        auto start_time = steady_clock::now();

        auto timeout = options_vars.count("timeout") ? options_vars["timeout"].as<int>() : 100;

        timeout_thread = std::thread([&] {
            auto abort_time = steady_clock::now() + std::chrono::seconds(timeout);
            {
                /* Sleep until either we've reached the time limit,
                 * or we've finished all the work. */
                std::unique_lock<std::mutex> guard(timeout_mutex);
                while (0 == state.load()) {
                    if (std::cv_status::timeout == timeout_cv.wait_until(guard, abort_time)) {
                        /* We've woken up, and it's due to a timeout. */
                        int exp = 0;
                        if (state.compare_exchange_strong(exp, 2)) {
                            auto overall_time = duration_cast<milliseconds>(steady_clock::now() - start_time);
                            std::cout << "aborted" << std::endl;
                            std::cout << std::endl;
                            std::cout << overall_time.count() << std::endl;
                            exit(EXIT_SUCCESS);
                        }
                        break;
                    }
                }
            }
        });

        Graph pattern_g(&pattern_ed), target_g(&target_ed);

        pattern_g.SetNodeComparator(new OurComparator);
        target_g.SetNodeComparator(new OurComparator);

        bool result;

        if (options_vars.count("induced")) {
            VF2SubState s0(&pattern_g, &target_g);
            result = match(&s0, &n, ni1, ni2);
        }
        else {
            VF2MonoState s0(&pattern_g, &target_g);
            result = match(&s0, &n, ni1, ni2);
        }

        auto overall_time = duration_cast<milliseconds>(steady_clock::now() - start_time);

        int exp = 0;
        if (state.compare_exchange_strong(exp, 1)) {
            if (! result) {
                std::cout << "false" << std::endl;
                std::cout << std::endl;
                std::cout << overall_time.count() << std::endl;
            }
            else {
                std::cout << "true" << std::endl;
                for (int i = 0 ; i < n ; i++)
                    std::cout << "(" << ni1[i] << "=" << ni2[i] << ") ";
                std::cout << std::endl;
                std::cout << overall_time.count() << std::endl;
            }

            /* Clean up the timeout thread */
            if (timeout_thread.joinable()) {
                {
                    std::unique_lock<std::mutex> guard(timeout_mutex);
                    timeout_cv.notify_all();
                }
                timeout_thread.join();
            }

            return EXIT_SUCCESS;
        }

        return EXIT_FAILURE;
    }
    catch (const po::error & e) {
        std::cerr << "Error: " << e.what() << std::endl;
        std::cerr << "Try " << argv[0] << " --help" << std::endl;
        return EXIT_FAILURE;
    }
    catch (const std::exception & e) {
        std::cerr << "Error: " << e.what() << std::endl;
        return EXIT_FAILURE;
    }
}

