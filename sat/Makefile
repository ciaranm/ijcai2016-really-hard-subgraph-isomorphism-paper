all : sat_random_subgraph_isomorphism

override CXXFLAGS += -O3 -march=native -std=c++14 -I./ -W -Wall -g -ggdb3 -pthread

sat_random_subgraph_isomorphism : sat_random_subgraph_isomorphism.cc
	$(CXX) $(CXXFLAGS) -o $@ sat_random_subgraph_isomorphism.cc $(LDFLAGS) \
	    -lboost_regex -lboost_thread -lboost_system -lboost_program_options

