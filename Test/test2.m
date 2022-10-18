A=load('19al63.txt');
%q1
% rng('shuffle');
% C = randi(10,5,4)*A;
% [U,S,V] = svd(C);
% u = U(:,1)
% v = V(:,1)

%q2
% A = readmatrix("A1.csv");
% A(:,1) = [];
% A(1,:)=[]
% n = size(A,1);
% m = size(A,2);
% rmsvars = zeros(m,1)
%     for ix = 1:m
%         cvec = A(:, ix);
%         Xmat = A;
%         Xmat(:, ix) = [];
%         wvec = Xmat\cvec;
%         evec = cvec-Xmat*wvec; % or rms(evec);
%     end
% [~, lowndx] = min(rmsvars);
% 
%     Xmat = A(:, [1:lowndx-1 , lowndx+1:end]);
%     cvec = A(:, lowndx);
%     wvec = Xmat\cvec;
% M = size(Xmat, 1);
% 
% if nargin >= 3 & ~isempty(k_in)
%     k = max(min(round(k_in), M-1), 2);
% else
%     k = 5
% end
% 
% rmstrain = zeros(1, k);
% rmstest = zeros(1, k);
% 
% perm = randperm(M);
% Xmat = Xmat(perm, :);
% yvec = yvec(perm);
% 
% fold_size = floor(M/k);
% for ix = 1:k
%     start_ix = (ix-1)*fold_size + 1;
%     end_ix = ix*fold_size;
% 
% 
%     %testing data
%     Xmat_test = Xmat(start_ix:end_ix, :);
%     yvec_test = yvec(start_ix:end_ix);
% 
%     %training data
%     Xmat_train = Xmat([1:start_ix-1, end_ix+1:end], :);
%     yvec_train = yvec([1:start_ix-1, end_ix+1:end]);
% 
% 
%     wvec = Xmat_train\yvec_train;
% 
%     %error vectors
%     evec_train = yvec_train - Xmat_train*wvec;
%     evec_test = yvec_test - Xmat_test*wvec;
% 
%     %RMS errors
%     rmstrain(ix) = rms(evec_train);
%     rmstest(ix) = rms(evec_test);
% end
% disp(rms_test)
% disp(rms_train)

%q3
% A=readmatrix("A5.csv");
% A(:,1) = [];
% A(1,:)=[];
%   n = size(A,1);
%     m = size(A,2);
%     rmsvars = zeros(m,1);
%     for ix = 1:m
%         cvec = A(:, ix);
%         Xmat = A;
%         Xmat(:, ix) = [];
%         wvec = Xmat\cvec;
%         evec = cvec-Xmat*wvec; % or rms(evec)
%         rmsvars(ix) = norm(evec)/sqrt(n);
%     end
% 
%     disp(rmsvars)
%     [~, lowndx] = min(rmsvars);
%     disp(lowndx)

%Q4
A=load("19al63.txt")
[U,S,V] = svd(A);
Q = U*V';
B = V*S*V';
disp(round(Q*B))
