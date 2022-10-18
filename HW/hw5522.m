%HW5 continued
%q2
A = [1 , 1 ; 3 , 3];
[U,S,V] = svd(A);
u1 = U(:,1)
v1 = V(:,1)
n1 = V(:,2)
disp(null(A))
c1 = U(:,2)

%Q5
A = [1 , 2 ; 3 , 6]
[U,S,V] = svd(A)
u1 = U(:,1)
v1 = V(:,1)
n1 = V(:,2)
c1 = U(:,2)
disp(diag(S))

%q6
A = [1 , 2 ; 3 , 6]
[U,S,V] = svd(A)
Q = U*V'
B = V*S*V'
disp(Q*B)

%Q7
A = [-414 480 180 228 ; -300 528 198 162 ; 562 -1516 -1068 -1264 ; -225 729 648 843]
[U,S,V] = svd(A)
Q = U*V'
B = V*S*V'
disp(round(Q*B))
