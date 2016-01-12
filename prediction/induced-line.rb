#!/usr/bin/ruby
# vim: set sw=4 sts=4 et tw=80 :

require 'bigdecimal'

ps = ARGV[0].to_i
ts = ARGV[1].to_i
flip = ARGV[2].to_i == "true"

0.step(500, 1) do | x |
    pd = BigDecimal.new(x) / 500;

    results = [0, 0]
    expsols = [0, 0]

    [0, 1].each do | pass |

        if 0 == pass
            tdupper = x + 10
            tdlower = 0
        else
            tdupper = 500
            tdlower = x + 10
        end

        0.upto(100) do
            td = BigDecimal.new(tdupper + tdlower) / 1000;

            if flip then pd, td = td, pd end

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
                tdlower = (tdupper + tdlower) / 2
            elsif ((expsols[pass] > 1) ^ (pass == 1))
                tdupper = (tdupper + tdlower) / 2
            else
                break
            end
        end
        results[pass] = (tdupper + tdlower) / 1000.0
    end

    puts(pd.to_f.to_s + " " + results[0].to_s + " " + expsols[0].to_f.to_s + " " + results[1].to_s + " " + expsols[1].to_f.to_s + " " + (x + 10).to_s)
end
