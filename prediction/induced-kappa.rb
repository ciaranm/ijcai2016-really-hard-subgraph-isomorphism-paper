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
        nnonedges = (1 - pd) * cliqueedges;

        edgesokprob = td ** nedges;
        nonedgesokprob = (1 - td) ** nnonedges;

        solprob = edgesokprob * nonedgesokprob;

        nstates = BigDecimal.new(1);
        1.upto(ps) do | n |
            nstates *= (ts - n + 1);
        end

        expsols = nstates * solprob;

        kappa = if 0 == expsols then 10 else 1 - ((BigMath.log(expsols, 50)) / BigMath.log(nstates, 50)) end

        print kappa.to_f.to_s + " "
    end
    puts
end
