/* vim: set sw=4 sts=4 et foldmethod=syntax : */

#ifndef CODE_GUARD_CLIQUE_HH
#define CODE_GUARD_CLIQUE_HH 1

#include "params.hh"
#include "result.hh"
#include "graph.hh"

auto clique_subgraph_isomorphism(const std::pair<Graph, Graph> & graphs, const Params & params) -> Result;

#endif
