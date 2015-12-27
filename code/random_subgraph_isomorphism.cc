/* vim: set sw=4 sts=4 et foldmethod=syntax : */

#include "sequential.hh"
#include "clique.hh"

#include <boost/program_options.hpp>

#include <iostream>
#include <exception>
#include <cstdlib>
#include <chrono>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <algorithm>

namespace po = boost::program_options;

using std::chrono::steady_clock;
using std::chrono::duration_cast;
using std::chrono::milliseconds;

auto create_random_graph(int size, double density, int seed, bool edgemodel) -> Graph
{
    std::mt19937 rand;
    rand.seed(seed);

    Graph result;
    result.resize(size);

    if (edgemodel) {
        std::vector<std::pair<int, int> > edges;
        for (int e = 0 ; e < size ; ++e)
            for (int f = e + 1 ; f < size ; ++f)
                edges.emplace_back(e, f);

        std::shuffle(edges.begin(), edges.end(), rand);

        for (int i = 0 ; i < (size * (size - 1) * density / 2) ; ++i)
            result.add_edge(edges.at(i).first, edges.at(i).second);
    }
    else {
        std::uniform_real_distribution<double> dist(0.0, 1.0);
        for (int e = 0 ; e < size ; ++e) {
            for (int f = e + 1 ; f < size ; ++f) {
                if (dist(rand) <= density)
                    result.add_edge(e, f);
            }
        }
    }

    return result;
}

/* Helper: return a function that runs the specified algorithm, dealing
 * with timing information and timeouts. */
template <typename Result_, typename Params_, typename Data_>
auto run_this_wrapped(const std::function<Result_ (const Data_ &, const Params_ &)> & func)
    -> std::function<Result_ (const Data_ &, Params_ &, bool &, int)>
{
    return [func] (const Data_ & data, Params_ & params, bool & aborted, int timeout) -> Result_ {
        /* For a timeout, we use a thread and a timed CV. We also wake the
         * CV up if we're done, so the timeout thread can terminate. */
        std::thread timeout_thread;
        std::mutex timeout_mutex;
        std::condition_variable timeout_cv;
        std::atomic<bool> abort;
        abort.store(false);
        params.abort = &abort;
        if (0 != timeout) {
            timeout_thread = std::thread([&] {
                    auto abort_time = std::chrono::steady_clock::now() + std::chrono::seconds(timeout);
                    {
                        /* Sleep until either we've reached the time limit,
                         * or we've finished all the work. */
                        std::unique_lock<std::mutex> guard(timeout_mutex);
                        while (! abort.load()) {
                            if (std::cv_status::timeout == timeout_cv.wait_until(guard, abort_time)) {
                                /* We've woken up, and it's due to a timeout. */
                                aborted = true;
                                break;
                            }
                        }
                    }
                    abort.store(true);
                    });
        }

        /* Start the clock */
        params.start_time = std::chrono::steady_clock::now();
        auto result = func(data, params);

        /* Clean up the timeout thread */
        if (timeout_thread.joinable()) {
            {
                std::unique_lock<std::mutex> guard(timeout_mutex);
                abort.store(true);
                timeout_cv.notify_all();
            }
            timeout_thread.join();
        }

        return result;
    };
}

/* Helper: return a function that runs the specified algorithm, dealing
 * with timing information and timeouts. */
template <typename Result_, typename Params_, typename Data_>
auto run_this(Result_ func(const Data_ &, const Params_ &)) -> std::function<Result_ (const Data_ &, Params_ &, bool &, int)>
{
    return run_this_wrapped(std::function<Result_ (const Data_ &, const Params_ &)>(func));
}

auto main(int argc, char * argv[]) -> int
{
    try {
        po::options_description display_options{ "Program options" };
        display_options.add_options()
            ("help",                                  "Display help information")
            ("timeout",            po::value<int>(),  "Abort after this many seconds")
            ("induced",                               "Induced version")
            ("supplemental-induced",                  "Use supplemental graphs on the compement")
            ("clique",                                "Use clique algorithm")
            ("density",                               "Generate using density instead of probability")
            ("invert-pattern-order",                  "Use reverse order for pattern degree value ordering")
            ("invert-target-order",                   "Use reverse order for target degree value ordering")
            ("no-backjumping",                        "Disable backjumping")
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

        /* Figure out what our options should be. */
        Params params;

        params.induced = options_vars.count("induced");
        params.supplemental_induced = options_vars.count("supplemental-induced");
        params.no_backjumping = options_vars.count("no-backjumping");

        params.invert_pattern_order = options_vars.count("invert-pattern-order");
        params.invert_target_order = options_vars.count("invert-target-order");

        /* Create graphs */
        auto graphs = std::make_pair(
                create_random_graph(options_vars["pattern-size"].as<int>(), options_vars["pattern-density"].as<double>(), options_vars["pattern-seed"].as<int>(),
                    options_vars.count("density")),
                create_random_graph(options_vars["target-size"].as<int>(), options_vars["target-density"].as<double>(), options_vars["target-seed"].as<int>(),
                    options_vars.count("density")));

        /* Do the actual run. */
        bool aborted = false;
        Result result;

        if (options_vars.count("clique"))
            result = run_this(clique_subgraph_isomorphism)(
                    graphs,
                    params,
                    aborted,
                    options_vars.count("timeout") ? options_vars["timeout"].as<int>() : 0);
        else
            result = run_this(sequential_subgraph_isomorphism)(
                    graphs,
                    params,
                    aborted,
                    options_vars.count("timeout") ? options_vars["timeout"].as<int>() : 0);

        /* Stop the clock. */
        auto overall_time = duration_cast<milliseconds>(steady_clock::now() - params.start_time);

        /* Display the results. */
        std::cout << std::boolalpha << ! result.isomorphism.empty() << " " << result.nodes;

        if (aborted)
            std::cout << " aborted";
        std::cout << std::endl;

        for (auto v : result.isomorphism)
            std::cout << "(" << v.first << " -> " << v.second << ") ";
        std::cout << std::endl;

        std::cout << overall_time.count();
        if (! result.times.empty()) {
            for (auto t : result.times)
                std::cout << " " << t.count();
        }
        std::cout << std::endl;

        if (! result.isomorphism.empty()) {
            for (int i = 0 ; i < graphs.first.size() ; ++i) {
                for (int j = 0 ; j < graphs.first.size() ; ++j) {
                    if (graphs.first.adjacent(i, j)) {
                        if (! graphs.second.adjacent(result.isomorphism.find(i)->second, result.isomorphism.find(j)->second)) {
                            std::cerr << "Oops! not an isomorphism" << std::endl;
                            return EXIT_FAILURE;
                        }
                    }
                }
            }
        }

        return EXIT_SUCCESS;
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

