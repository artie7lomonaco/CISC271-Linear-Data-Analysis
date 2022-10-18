%homework 1

A = load('19al63.txt')
lraw = eig(A)
lvec = round(lraw)

prod(lvec);
det(A);

sum(lvec);
sum(diag(A));

x1 = null(A);
norm(A*x1);
round(norm(A*x1));
x2 = null(A,"r");
norm(A*x2);

[Emat,lraw] = eig(A,"vector");
evec1 = Emat(:,1);

A*evec1;
lraw(1)*evec1;

nvec1 = null(A - lraw(1) * eye(4));
[evec1 nvec1];
c = [];
for ix = 1 : 4
    nvec = null(A - lraw(ix)*eye(4));
    evec = Emat(:,ix);
    c = [c;nvec evec];
end
c;

evec1/evec1(1) ;
ivec1 = 2*evec1/evec1(1);
round([A*ivec1 lvec(1)*ivec1]);
C=A*A;
lraw2=eig(A);
find(lvec == 60)