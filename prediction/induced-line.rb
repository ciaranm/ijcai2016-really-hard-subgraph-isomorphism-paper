#!/usr/bin/ruby
# vim: set sw=4 sts=4 et tw=80 :

require 'bigdecimal'

ps = ARGV[0].to_i
ts = ARGV[1].to_i
flip = (ARGV[2] == "true")

0.step(500, 10) do | x |
    pdresult = [0, 0]
    tdresult = [0, 0]
    expsols = [0, 0]
    pd, td = 0, 0

    [0, 1].each do | pass |

        if flip then
            if 0 == pass
                lower = 250
                upper = 500
            else
                lower = 0
                upper = 250
            end
        else
            if 0 == pass then
                upper = x + 10
                lower = 0
            else
                upper = 500
                lower = x + 10
            end
        end

        0.upto(100) do
            if flip then
                td = BigDecimal.new(x) / 500;
                pd = BigDecimal.new(upper + lower) / 1000;
            else
                pd = BigDecimal.new(x) / 500;
                td = BigDecimal.new(upper + lower) / 1000;
            end

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

            expsols[pass] = nstates * solprob;

            if ((expsols[pass] < 1) ^ (pass == 1))
                lower = (upper + lower) / 2
            elsif ((expsols[pass] > 1) ^ (pass == 1))
                upper = (upper + lower) / 2
            else
                break
            end
        end

        if flip then
            pdresult[pass] = (upper + lower) / 1000.0
            tdresult[pass] = td
        else
            pdresult[pass] = pd
            tdresult[pass] = (upper + lower) / 1000.0
        end
    end

    puts(pdresult[0].to_f.to_s + " " + tdresult[0].to_f.to_s + " " + expsols[0].to_f.to_s + " " +
         pdresult[1].to_f.to_s + " " + tdresult[1].to_f.to_s + " " + expsols[1].to_f.to_s + " ")
end
