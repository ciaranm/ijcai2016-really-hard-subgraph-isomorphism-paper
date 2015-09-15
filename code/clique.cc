/* vim: set sw=4 sts=4 et foldmethod=syntax : */

#include "clique.hh"
#include "bit_graph.hh"
#include "template_voodoo.hh"
#include "degree_sort.hh"

#include <algorithm>
#include <limits>

namespace
{
    auto modular_product(const Graph & g1, const Graph & g2) -> Graph
    {
        Graph result(g1.size() * g2.size());

        for (int v1 = 0 ; v1 < g1.size() ; ++v1)
            for (int v2 = 0 ; v2 < g2.size() ; ++v2)
                for (int w1 = 0 ; w1 < g1.size() ; ++w1)
                    for (int w2 = 0 ; w2 < g2.size() ; ++w2) {
                        unsigned p1 = v2 * g1.size() + v1;
                        unsigned p2 = w2 * g1.size() + w1;
                        if (p1 != p2 && v1 != w1 && v2 != w2 && (g1.adjacent(v1, w1) == g2.adjacent(v2, w2))) {
                            result.add_edge(p1, p2);
                        }
                    }
        return result;
    }

    auto noninduced_modular_product(const Graph & g1, const Graph & g2) -> Graph
    {
        Graph result(g1.size() * g2.size());

        for (int v1 = 0 ; v1 < g1.size() ; ++v1)
            for (int v2 = 0 ; v2 < g2.size() ; ++v2)
                for (int w1 = 0 ; w1 < g1.size() ; ++w1)
                    for (int w2 = 0 ; w2 < g2.size() ; ++w2) {
                        unsigned p1 = v2 * g1.size() + v1;
                        unsigned p2 = w2 * g1.size() + w1;
                        if (p1 != p2 && v1 != w1 && v2 != w2 && ((! g1.adjacent(v1, w1)) || g2.adjacent(v2, w2))) {
                            result.add_edge(p1, p2);
                        }
                    }

        return result;
    }

    auto unproduct(const Graph & g1, const Graph &, int v) -> std::pair<int, int>
    {
        return std::make_pair(v % g1.size(), v / g1.size());
    }

    template <unsigned n_words_>
    struct CliqueSubgraphIsomorphism
    {
        const Params & params;
        const Graph & pattern;
        const Graph & target;

        FixedBitGraph<n_words_> graph;
        std::vector<int> order;
        Result result;
        unsigned goal;
        bool success;

        CliqueSubgraphIsomorphism(const Graph & g, const Params & q, const Graph & p, const Graph & t) :
            params(q),
            pattern(p),
            target(t),
            order(g.size()),
            goal(p.size()),
            success(false)
        {
            // populate our order with every vertex initially
            std::iota(order.begin(), order.end(), 0);
            dynexdegree_sort(g, order, false);

            // re-encode graph as a bit graph
            graph.resize(g.size());

            for (int i = 0 ; i < g.size() ; ++i)
                for (int j = 0 ; j < g.size() ; ++j)
                    if (g.adjacent(order[i], order[j]))
                        graph.add_edge(i, j);
        }

        auto colour_class_order(
                const FixedBitSet<n_words_> & p,
                std::array<unsigned, n_words_ * bits_per_word> & p_order,
                std::array<unsigned, n_words_ * bits_per_word> & p_bounds) -> void
        {
            FixedBitSet<n_words_> p_left = p; // not coloured yet
            unsigned colour = 0;         // current colour
            unsigned i = 0;              // position in p_bounds

            // while we've things left to colour
            while (! p_left.empty()) {
                // next colour
                ++colour;
                // things that can still be given this colour
                FixedBitSet<n_words_> q = p_left;

                // while we can still give something this colour
                while (! q.empty()) {
                    // first thing we can colour
                    int v = q.first_set_bit();
                    p_left.unset(v);
                    q.unset(v);

                    // can't give anything adjacent to this the same colour
                    graph.intersect_with_row_complement(v, q);

                    // record in result
                    p_bounds[i] = colour;
                    p_order[i] = v;
                    ++i;
                }
            }
        }

        auto expand(
                std::vector<unsigned> & c,
                FixedBitSet<n_words_> & p
                ) -> void
        {
            ++result.nodes;

            // initial colouring
            std::array<unsigned, n_words_ * bits_per_word> p_order;
            std::array<unsigned, n_words_ * bits_per_word> p_bounds;
            colour_class_order(p, p_order, p_bounds);

            // for each v in p... (v comes later)
            for (int n = p.popcount() - 1 ; n >= 0 ; --n) {
                // bound, timeout or early exit?
                if (c.size() + p_bounds[n] < goal || success || params.abort->load())
                    return;

                auto v = p_order[n];

                // consider taking v
                c.push_back(v);

                // filter p to contain vertices adjacent to v
                FixedBitSet<n_words_> new_p = p;
                graph.intersect_with_row(v, new_p);

                if (new_p.empty()) {
                    if (c.size() == goal) {
                        for (auto & v : c)
                            result.isomorphism.insert(unproduct(pattern, target, order[v]));

                        success = true;
                    }
                }
                else
                    expand(c, new_p);

                // now consider not taking v
                c.pop_back();
                p.unset(v);
            }
        }

        auto run() -> Result
        {
            std::vector<unsigned> c;
            c.reserve(graph.size());

            FixedBitSet<n_words_> p;
            p.set_up_to(graph.size());

            // go!
            expand(c, p);

            return result;
        }
    };

    template <template <unsigned> class SGI_>
    struct Apply
    {
        template <unsigned size_, typename> using Type = SGI_<size_>;
    };
}

auto clique_subgraph_isomorphism(const std::pair<Graph, Graph> & graphs, const Params & params) -> Result
{
    auto product = (params.induced ?
            modular_product(graphs.first, graphs.second) :
            noninduced_modular_product(graphs.first, graphs.second));

    return select_graph_size<Apply<CliqueSubgraphIsomorphism>::template Type, Result>(AllProductGraphSizes(),
            product, params, graphs.first, graphs.second);
}

