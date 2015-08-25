To build, type 'make'. You will need a C++14 compiler (we use GCC 4.9) and
Boost (built with threads enabled).

To run:

    ./random_subgraph_isomorphism [ --induced ] \
        pattern-size pattern-density pattern-seed \
        target-size target-density target-seed

This code has been ripped out of a larger project, which includes other
variations, support for different file formats, various other algorithms, etc.
If you're looking for the most up-to-date code, rather than to reproduce the
paper, you may prefer this:

    https://github.com/ciaranm/parasols
