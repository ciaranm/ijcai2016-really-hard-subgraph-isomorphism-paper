TARGET := solve_subgraph_isomorphism

SOURCES := \
    solve_subgraph_isomorphism.cc

TGT_LDLIBS := $(boost_ldlibs) -lsubgraph_isomorphism
TGT_LDFLAGS := -L${TARGET_DIR}
TGT_PREREQS := libsubgraph_isomorphism.a

