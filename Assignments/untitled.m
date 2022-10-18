x = load('hw10.txt');
Xmat = x;
waug = [-3 ; -3 ; 18];
zbyW = Xmat*waug
z2p = @(u) 1./(1 + exp(-u));
pbyW = z2p(zbyW)
s= []
for idx = 1:8
    x = pbyW(idx,:)*pbyW(idx,:)
    s = [s x]
end

disp(s)