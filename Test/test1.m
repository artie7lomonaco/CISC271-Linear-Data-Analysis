% A = load('19al63.txt');
% 
% lraw = eig(A);
% 
% lvec = round(lraw);
% 
% c = max(lraw);
% 
% [Emat,lraw] = eig(A,"vector")
% 
% idx = find(lvec==60);
% 
% evec1 = Emat(:,idx)
% 
% W = round(evec1)

%first part
A1 = [1 5 ; 0 1];
[U1,S1,V1] = svd(A1);

A2 = [1 -1 ; -1 1];
[U2,S2,V2] = svd(A2);

%second part
A3 = [1 -1 ; -1 1 ; 2 0];
[U3,S3,V3] = svd(A3);


A4 = [1 -1 2 ; -1 1 -2];
[U4,S4,V4] = svd(A4);

A5 = [1 -1 ; -1 1 ; 2 -2.02]

[U5,S5,V5] = svd(A5)

S5(1,1)/S5(2,2)

%     errorList = [];
%     for ix=1:dataSize
%         A=data;
%         cvec = A(:,ix);
%         w = A\cvec;
%         rmsvars = rms(A*w - cvec);
%         errorList = [errorList rmsvars];
%     end
%     rmsvars = errorList(:);
%     [M,I] = min(errorList);
%     lowndx = [I];
% 
% 
%     % Find the regression on your choice of standardized
%     % or unstandardized variables
%     % %
%     % % STUDENT CODE GOES HERE: REMOVE THIS COMMENT
%     % % THEN PERFORM THE COMPUTATIONS
%     % %
%     A = data;
%     cvec = A(:, lowndx);
%     A(:,lowndx) = [];
%     mdi = linsolve(A , cvec);
%     plot(mdi);

% %     data = csvread(filename,1,1);
% %     dataSize = size(data,2);
% %     
% %     Create Xmat and yvec from the data and the input parameter,
% %     accounting for no standardization of data
% %     %
% %     % STUDENT CODE GOES HERE: REMOVE THIS COMMENT
% %     % THEN ASSIGN THE VARIABLES FROM THE DATASET
% %     %
% %     Xmat = data;
% %     yvec = data(:,lowndx);
% %     Xmat(:,lowndx) = [];
% %     
% %     Xmat_train1 = Xmat(1:23,15);
% %     yvec_train1 = data(1:23,15);
% % 
% %     Xmat_test1 = Xmat(1:23, 15);
% %     yvec_test1 = data(1:23, 15);
% % 
% %     wvec = linsolve(Xmat_test1,yvec_test1);
% %     
% %     Xmat_train2 = Xmat(24:47,15);
% %     yvec_train2 = data(24:47,15);
% % 
% %     Xmat_test2 = Xmat(24:47, 15);
% %     yvec_test2 = data(24:47, 15);
% % 
% %     Xmat_train3 = Xmat(48:71,15);
% %     yvec_train3 = data(48:71,15);
% % 
% %     Xmat_test3 = Xmat(48:71, 15);
% %     yvec_test3 = data(48:71, 15);
% % 
% %     Xmat_train4 = Xmat(72:95,15);
% %     yvec_train4 = data(72:95,15);
% % 
% %     Xmat_test4 = Xmat(72:95, 15);
% %     yvec_test4 = data(72:95, 15);
% % 
% %     Xmat_train5 = Xmat(96:119,15);
% %     yvec_train5 = data(96:119,15);
% % 
% %     Xmat_test5 = Xmat(96:119, 15);
% %     yvec_test5 = data(96:119, 15);
% % 
% %     
% %     Compute the RMS errors of 5-fold cross-validation
% %     %
% %     % STUDENT CODE GOES HERE: REMOVE THE NEXT 2 LINES AND THIS COMMENT
% %     % THEN PERFORM THE COMPUTATIONS
% %     %
% %     rmstrain = [rms(Xmat_train1) ; rms(Xmat_train2) ; rms(Xmat_train3) ; 
% %     rms(Xmat_train4) ; rms(Xmat_train5)]
% %     rmstest =  [rms(Xmat_test1) ; rms(Xmat_test2) ; rms(Xmat_test3) ; 
% %     rms(Xmat_test4) ; rms(Xmat_test5)]
    
%     M = size(Xmat, 1);
% 
%     % Set the number of folds; must be 1<k<M
%     if nargin >= 3 & ~isempty(k_in)
%         k = max(min(round(k_in), M-1), 2);
%     else
%         k = 5;
%     end
% 
%     % Initialize the return variables
%     rmstrain = zeros(1, k);
%     rmstest  = zeros(1, k);
%         Xmat_test = Xmat(groups{1,ix}, :);
%         yvec_test = yvec(groups{1,ix}, :);
%         Xmat_train = Xmat(setdiff(randomSet, groups{1,ix}), :);
%         yvec_train = yvec(setdiff(randomSet, groups{1,ix}), :);
%         wvec = linsolve(Xmat_train, yvec_train);
% 
%         rmstrain(ix) = rms(xmat_train*wvec - yvec_train);
%         rmstest(ix)  = rms(xmat_test*wvec  - yvec_test);
%     end


