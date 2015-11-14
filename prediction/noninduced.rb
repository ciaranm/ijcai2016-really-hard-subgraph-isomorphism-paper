#!/usr/bin/ruby
# vim: set sw=4 sts=4 et tw=80 :

require 'bigdecimal'

ps = ARGV[0].to_i
ts = ARGV[1].to_i

0.upto(50) do | y |
    0.upto(50) do | x |
        pd = BigDecimal.new(x) / 50;
        td = BigDecimal.new(y) / 50;

        cliqueedges = BigDecimal.new(ps * (ps - 1) / 2);
        nedges = pd * cliqueedges;

        edgesokprob = td ** nedges;

        solprob = edgesokprob;

        nstates = BigDecimal.new(1);
        1.upto(ps) do | n |
            nstates *= (ts - n + 1);
        end

        expsols = nstates * solprob;

        if (expsols < 1)
            expsols = 0
        elsif (expsols > 1)
            expsols = 1
        else
            expsols = 0.5;
        end

        print expsols.to_s + " "
    end
    puts
end
