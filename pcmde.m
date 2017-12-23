function seq = pcmde(signal)
% input  signal: the signal that need to decode
% output seq   : the decoded signal
% 13-segment A-law PCM decoder

segment  = zeros(1,length(signal)/8);
position = zeros(1,length(signal)/8);
ssign    = ones(1,length(signal)/8);
seq        = zeros(1,length(signal)/8);

for n=1:(length(signal)/8)
    part = signal(((n-1)*8+1):n*8);
 
    segment(n)  = part(2)*4 + part(3)*2 + part(4) + 1;
    position(n) = part(5)*8 + part(6)*4 + part(7)*2 + part(8);
    ssign(n)    = part(1);
    
    seg = [0,16,32,64,128,256,512,1024];
    interval = [16,16,32,64,128,256,512,1024];
    seq(n) = seg(segment(n)) + interval(segment(n))/16*position(n);
    seq(n) = seq(n) * (ssign(n)*2-1);
end

end
