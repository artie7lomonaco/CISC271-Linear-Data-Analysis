% %q1
% b = [1 ; 1];
% a1 = [1 ; 0];
% a2 = [1 ; 2];
% p1 = ((a1'*b)/(a1'*a1))*a1;
% p2 = ((a2'*b)/(a2'*a2))*a2;
% p12 = p1 + p2;
% 
% %q2
% A = [a1 , a2];
% AtA = A'*A;
% w = inv(AtA)*A'*b;
% P = A*inv(AtA)*A';
% C = A*w;
% C = P*b;

%q3
%a)
% A = [1 , 1 ; 0 , 1 ; 0 , 0];
% b = [2 ; 3 ; 4];
% 
% w = (A'*A)\(A'*b);
% p = A*w;
% P = A*inv(A'*A)*A';
% e = b - p;
%b
% A = [1 , 1 ; 1 , 1 ; 0 , 1];
% b = [4 ; 4 ; 6];
% 
% w = (A'*A)\(A'*b)
% p = A*w
% P = A*inv(A'*A)
% e = b - p

%4
M = [1 , -1 , -2];
A = null(M, 'r')
disp(M*A);
P = A*inv(A'*A)*(A')
c = P*M'

