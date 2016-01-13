BUILD_DIR := intermediate
TARGET_DIR := ./
SUBMAKEFILES := random.mk file.mk

boost_ldlibs := -lboost_regex -lboost_thread -lboost_system -lboost_program_options

override CXXFLAGS += -O3 -march=native -std=c++14 -I./ -W -Wall -g -ggdb3 -pthread
override LDFLAGS += -pthread

TARGET := libsubgraph_isomorphism.a

SOURCES := \
    sequential.cc \
    clique.cc \
    bit_graph.cc \
    degree_sort.cc \
    graph.cc

TGT_LDLIBS := $(boost_ldlibs)

