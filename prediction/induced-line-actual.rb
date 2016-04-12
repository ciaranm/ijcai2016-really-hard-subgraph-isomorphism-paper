#!/usr/bin/ruby
# vim: set sw=4 sts=4 et tw=80 :

require 'bigdecimal'

ps = ARGV[0].to_i
ts = ARGV[1].to_i
flip = (ARGV[2] == "true")

measured = []

File.open(ARGV[3], "r") do | f |
    f.each_line do | line |
       measured << line.split
    end
end

0.step(500, 10) do | x |
    pdresult = [0, 0]
    tdresult = [0, 0]
    pdround = [0, 0]
    tdround = [0, 0]
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

        pdround[pass] = (pdresult[pass] * 100.0).to_i
        tdround[pass] = (tdresult[pass] * 100.0).to_i

        while tdround[pass] < 49 and tdround[pass] > 1 and measured[pdround[pass]][tdround[pass]].to_f < 0.5 do
            tdround[pass] += (pass == 0 ? 1 : -1)
        end
    end

    puts(pdround[0].to_s + " " + tdround[0].to_s + " " + measured[pdround[0]][tdround[0]].to_s + " " +
         pdround[1].to_s + " " + tdround[1].to_s + " " + measured[pdround[1]][tdround[1]].to_s + " ")
end
