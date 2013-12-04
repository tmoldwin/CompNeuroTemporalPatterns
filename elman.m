%Simulation of an Elman network on the XOR function

len = 3000;
P = zeros(1,len);
n = 1;
while(n < len)
    randy = rand(1);
    seq = zeros(1,3);
    if randy <=0.25
        seq = [1 0 1];
    elseif randy <= 0.5
        seq = [0 0 0];
    elseif randy <= 0.75
        seq = [0 1 1];
    elseif randy <= 1
        seq = [1 1 0];
    end
    P(n:n+2) = seq;
    n = n + 3;
end
T = [P(2:len) 0];

%      We would like the network to recognize whenever two 1's
%      occur in a row.  First we arrange these values as sequences.
%
Pseq = con2seq(P);
Tseq = con2seq(T);
%
%      Here we create a network with one hidden layer of 10 neurons.

net = newelm(P,T,10);


net = train(net,Pseq,Tseq);


len = 3000;
P = zeros(1,len);
n = 1;
while(n < len)
    randy = rand(1);
    seq = zeros(1,3);
    if randy <=0.25
        seq = [1 0 1];
    elseif randy <= 0.5
        seq = [0 0 0];
    elseif randy <= 0.75
        seq = [0 1 1];
    elseif randy <= 1
        seq = [1 1 0];
    end
    P(n:n+2) = seq;
    n = n + 3;
end
T = [P(2:len) 0];
[Y,Pf,Af,E,perf] = sim(net, P);

error = abs(Y - T)
lplot(error)

PositionError = [0 0 0];
n = 1;
while(n<len)
    errVal = abs(error(n));
    PositionError(1) =  errVal + PositionError(1);
    n = n + 1;
    errVal = abs(error(n));
    PositionError(2) =  errVal + PositionError(2);
    n = n + 1;
    errVal = abs(error(n));
    PositionError(3) =  errVal + PositionError(3);
    n = n + 1;
end

PositionError
