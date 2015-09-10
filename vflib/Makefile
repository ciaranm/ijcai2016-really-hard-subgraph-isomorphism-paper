all : vf_random_subgraph_isomorphism

override CXXFLAGS += -O3 -march=native -std=c++14 -I./ -W -Wall -g -ggdb3 -pthread

vf_random_subgraph_isomorphism : vf_random_subgraph_isomorphism.cc
	$(CXX) $(CXXFLAGS) -o $@ -I vflib-2.0.6/include/ $< -L vflib-2.0.6/lib/ -lvf \
	    -lboost_regex -lboost_thread -lboost_system -lboost_program_options

