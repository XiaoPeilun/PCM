function seq = pcm(signal)
% input  signal: the signal that need to encode
% output swq   : the encoded signal
% 13-segment A-law PCM encoder

z = sign(signal);       % record the sign 
mx = max(abs(signal));  % get maximum values
s = abs(signal/mx);     % normalization
q = 2048*s;
y = zeros(length(s),8);
seq = zeros(1,length(s)*8);

for m=1:length(s)
    if (q(m)>=128 && q(m)<2048)
        y(m,2) = 1;
    end
    if (q(m)>=32 && q(m)<128) || (q(m)>=512 && q(m)<2048)
        y(m,3) = 1;
    end
    if (q(m)>=16 && q(m)<32) || (q(m)>=64 && q(m)<128) || (q(m)>=256 && q(m)<512) || (q(m)>=1024 && q(m)<2048)      
        y(m,4) = 1;           
    end
    
    level = 0;
    
    if (q(m)<16)
        level = floor(q(m)/1);
    elseif (q(m)<32)
        level = floor((q(m)-16)/1);
    elseif (q(m)<64)     
        level = floor((q(m)-32)/2);
    elseif (q(m)<128)    
        level = floor((q(m)-64)/4);
    elseif (q(m)<256)       
        level = floor((q(m)-128)/8);
    elseif (q(m)<512)           
        level = floor((q(m)-256)/16);
    elseif (q(m)<1024)   
        level = floor((q(m)-512)/32);
    elseif (q(m)<2048) 
        level = floor((q(m)-1024)/64);
    end
    
    k  = dec2bin(level,4);
    y(m,5) = str2num(k(1));
    y(m,6) = str2num(k(2));
    y(m,7) = str2num(k(3));
    y(m,8) = str2num(k(4));
    
    if (q(m)==2048)
        y(m,:) = [0 1 1 1 1 1 1 1];
    end
    
    if (z(m)>0)
        y(m,1) = 1;
    end
end
        
for i = 1:length(s)
    for j = 1:8
        seq(1,(i-1)*8+j) = y(i,j);
    end
end
end   
        
        
        
        
        
        
        
        
        
