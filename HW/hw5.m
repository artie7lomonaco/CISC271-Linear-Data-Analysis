%homework 5
%q1
%load data separate into A and C
data = load('hw05.txt')
m = size(data, 2)
A = [data(1,:)' , ones(m,1)]
c = data(2,:)'

% full regression and error
w = A\c
c - A*w
Av = A(1,:)
cv = c(1,:)
At = A(2:end,:)
ct = c(2:end,:)
wt = At\ct
ev = cv - Av*wt

%second observation
Av = A(2,:)
cv = c(2,:)
At = A([1 3:end],:)
ct = c([1 3:end],:)
wt = At\ct
cv - Av*wt

%repeat #1 with indexing
ix = 1;
Av = A(ix,:)
cv = c(ix,:)
1:(ix - 1)
(ix + 1):m
[1:(ix - 1) (ix + 1):m]
%indexing for IX=2
ix=2;
[1:(ix - 1) (ix + 1):m]

%loop through first 4 observations
elist = zeros(4,1);
for ix=1:4
    At = A([1:(ix - 1) (ix + 1):m], :);
    ct = c([1:(ix - 1) (ix + 1):m], :);
    Av = A(ix, :);
    cv = c(ix, :);
    %train on data
    wt = At\ct;
    %put test error in a list
    elist(ix) = cv - Av*wt;
end
disp(elist)
%square errors, mean square, RMS
disp(elist.^2)
sum(elist.^2)
sum(elist.^2)/length(elist)
sqrt(sum(elist.^2)/length(elist))
rms(elist)

%train on m-2, test on 2; use index list
ilist=1:m
ix=1;
kx=[ix:(ix + 1)]
tx=setdiff(ilist,kx)
At=A(tx,:)
ct=c(tx,:)
Av=A(kx,:)
cv=c(kx,:)
wt=At\ct
cv - Av*wt
rms(cv - Av*wt)


