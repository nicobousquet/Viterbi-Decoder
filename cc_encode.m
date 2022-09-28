function [c, s_f] = cc_encode(u, trellis, s_i, closed)
mem = s_i;
c  = [];
for k=1:length(u)
    for i = 0:trellis.numOutputSymbols-1
        if (trellis.outputs(mem+1,u(k)+1) == i)
            c_tmp = dec2bin(i,log2(trellis.numOutputSymbols));
            for j = 1:strlength(c_tmp)
                c_tmp_bis = str2double(c_tmp(j));
                c = [c c_tmp_bis];
            end
        end
    end
    mem = trellis.nextStates(mem+1,u(k)+1);
end
s_f  = mem;
if (closed == 1)
    for k = 1:log2(trellis.numStates)
        if(trellis.nextStates(mem+1,1)<=(trellis.nextStates(mem+1,2)))
            c_tmp = dec2bin(trellis.outputs(mem+1,1),log2(trellis.numOutputSymbols));
            for j = 1:strlength(c_tmp)
                c_tmp_bis = str2double(c_tmp(j));
                c = [c c_tmp_bis];
            end
            mem = trellis.nextStates(mem+1,1);
        else
            c_tmp = dec2bin(trellis.outputs(mem+1,2),log2(trellis.numOutputSymbols));
            for j = 1:strlength(c_tmp)
                c_tmp_bis = str2double(c_tmp(j));
                c = [c c_tmp_bis];
            end
            mem = trellis.nextStates(mem+1,2);
        end
    end
end

end

