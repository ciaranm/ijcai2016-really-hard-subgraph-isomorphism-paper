/* vim: set sw=4 sts=4 et foldmethod=syntax : */

#include <boost/program_options.hpp>

#include <iostream>
#include <exception>
#include <cstdlib>
#include <vector>

namespace po = boost::program_options;

auto create_random_graph(int size, double density, int seed) -> std::vector<std::vector<uint8_t>>
{
    std::mt19937 rand;
    rand.seed(seed);
    std::uniform_real_distribution<double> dist(0.0, 1.0);

    std::vector<std::vector<uint8_t>> result(size, std::vector<uint8_t>(size, 0));

    for (int e = 0 ; e < size ; ++e) {
        for (int f = e + 1 ; f < size ; ++f) {
            if (dist(rand) <= density) {
                result[e][f] = 1;
                result[f][e] = 1;
            }
        }
    }

    return result;
}

auto var(int a, int b, int target_size) -> int
{
    return a * target_size + b + 1;
}

auto main(int argc, char * argv[]) -> int
{
    try {
        po::options_description display_options{ "Program options" };
        display_options.add_options()
            ("help",                                  "Display help information")
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

        bool induced = options_vars.count("induced");

        /* Create graphs */
        auto graphs = std::make_pair(
                create_random_graph(options_vars["pattern-size"].as<int>(), options_vars["pattern-density"].as<double>(), options_vars["pattern-seed"].as<int>()),
                create_random_graph(options_vars["target-size"].as<int>(), options_vars["target-density"].as<double>(), options_vars["target-seed"].as<int>()));

        int n_vars = graphs.first.size() * graphs.second.size();
        int n_clauses = 0;

        for (int pass = 1 ; pass <= 2 ; ++pass) {
            if (2 == pass)
                std::cout << "p cnf " << n_vars << " " << n_clauses << std::endl;

            if (2 == pass)
                std::cout << "c at least one value per variable" << std::endl;

            for (unsigned v = 0 ; v < graphs.first.size() ; ++v) {
                for (unsigned w = 0 ; w < graphs.second.size() ; ++w)
                    if (2 == pass)
                        std::cout << var(v, w, graphs.second.size()) << " ";
                if (2 == pass)
                    std::cout << 0 << std::endl;
                else
                    ++n_clauses;
            }

            if (2 == pass)
                std::cout << "c at most one value per variable" << std::endl;

            for (unsigned v = 0 ; v < graphs.first.size() ; ++v)
                for (unsigned w1 = 0 ; w1 < graphs.second.size() ; ++w1)
                    for (unsigned w2 = 0 ; w2 < graphs.second.size() ; ++w2)
                        if (w1 != w2) {
                            if (2 == pass)
                                std::cout
                                    << -var(v, w1, graphs.second.size()) << " "
                                    << -var(v, w2, graphs.second.size()) << " " << 0 << std::endl;
                            else
                                ++n_clauses;
                        }

            if (2 == pass)
                std::cout << "c injectivity" << std::endl;

            for (unsigned w = 0 ; w < graphs.second.size() ; ++w)
                for (unsigned v1 = 0 ; v1 < graphs.first.size() ; ++v1)
                    for (unsigned v2 = 0 ; v2 < graphs.first.size() ; ++v2)
                        if (v1 != v2) {
                            if (2 == pass)
                                std::cout
                                    << -var(v1, w, graphs.second.size()) << " "
                                    << -var(v2, w, graphs.second.size()) << " " << 0 << std::endl;
                            else
                                ++n_clauses;
                        }

            if (2 == pass)
                std::cout << "c edges cannot be mapped to non-edges" << std::endl;

            for (unsigned v1 = 0 ; v1 < graphs.first.size() ; ++v1) {
                for (unsigned v2 = 0 ; v2 < graphs.first.size() ; ++v2) {
                    if (v1 != v2 && graphs.first[v1][v2]) {
                        for (unsigned w1 = 0 ; w1 < graphs.second.size() ; ++w1) {
                            for (unsigned w2 = 0 ; w2 < graphs.second.size() ; ++w2) {
                                if (w1 != w2 && ! graphs.second[w1][w2]) {
                                    if (2 == pass)
                                        std::cout
                                            << -var(v1, w1, graphs.second.size()) << " "
                                            << -var(v2, w2, graphs.second.size()) << " " << 0 << std::endl;
                                    else
                                        ++n_clauses;
                                }
                            }
                        }
                    }
                }
            }

            if (induced) {
                if (2 == pass)
                    std::cout << "c non-edges cannot be mapped to edges" << std::endl;

                for (unsigned v1 = 0 ; v1 < graphs.first.size() ; ++v1) {
                    for (unsigned v2 = 0 ; v2 < graphs.first.size() ; ++v2) {
                        if (v1 != v2 && ! graphs.first[v1][v2]) {
                            for (unsigned w1 = 0 ; w1 < graphs.second.size() ; ++w1) {
                                for (unsigned w2 = 0 ; w2 < graphs.second.size() ; ++w2) {
                                    if (w1 != w2 && graphs.second[w1][w2]) {
                                        if (2 == pass)
                                            std::cout
                                                << -var(v1, w1, graphs.second.size()) << " "
                                                << -var(v2, w2, graphs.second.size()) << " " << 0 << std::endl;
                                        else
                                            ++n_clauses;
                                    }
                                }
                            }
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


