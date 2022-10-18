function [rmsvars lowndx rmstrain rmstest] = a2_19al63
% [RMSVARS LOWNDX RMSTRAIN RMSTEST]=A3 finds the RMS errors of
% linear regression of the data in the file "GOODS.CSV" by treating
% each column as a vector of dependent observations, using the other
% columns of the data as observations of independent varaibles. The
% individual RMS errors are returned in RMSVARS and the index of the
% smallest RMS error is returned in LOWNDX. For the variable that is
% best explained by the other variables, a 5-fold cross validation is
% computed. The RMS errors for the training of each fold are returned
% in RMSTEST and the RMS errors for the testing of each fold are
% returned in RMSTEST.
%
% INPUTS:
%         none
% OUTPUTS:
%         RMSVARS  - 1xN array of RMS errors of linear regression
%         LOWNDX   - integer scalar, index into RMSVALS
%         RMSTRAIN - 1x5 array of RMS errors for 5-fold training
%         RMSTEST  - 1x5 array of RMS errors for 5-fold testing

    filename = 'goods.csv';
    [rmsvars lowndx] = a2q1(filename);
    [rmstrain rmstest] = a2q2(filename, lowndx)
    disp(lowndx)
end

function [rmsvars lowndx] = a2q1(filename)
% [RMSVARS LOWNDX]=A2Q1(FILENAME) finds the RMS errors of
% linear regression of the data in the file FILENAME by treating
% each column as a vector of dependent observations, using the other
% columns of the data as observations of independent varaibles. The
% individual RMS errors are returned in RMSVARS and the index of the
% smallest RMS error is returned in LOWNDX. 
%
% INPUTS:
%         FILENAME - character string, name of file to be processed;
%                    assume that the first row describes the data variables
% OUTPUTS:
%         RMSVARS  - 1xN array of RMS errors of linear regression
%         LOWNDX   - integer scalar, index into RMSVALS
    % % THEN READ THE FILE SPECIFIED BY THE INPUT ARGUMENT
%     data = csvread(filename,1,1);
%     dataSize = size(data,2);
%     
% 
%     % Compute the RMS errors for linear regression
%     % %
%     % % STUDENT CODE GOES HERE: REMOVE THE NEXT 2 LINES AND THIS COMMENT
%     % % THEN PERFORM THE COMPUTATIONS
%     % %


    Amat = readmatrix(filename);
    Amat(:,1) = [];

    n = size(Amat,1);
    m = size(Amat,2);

    rmsvars = zeros(m,1)
    for ix = 1:m
        cvec = Amat(:, ix);
        Xmat = Amat;
        Xmat(:, ix) = []
        wvec = Xmat\cvec
        evec = cvec-Xmat*wvec % or rms(evec)
    end

    [~, lowndx] = min(rmsvars);

    Xmat = Amat(:, [1:lowndx-1 , lowndx+1:end]);
    cvec = Amat(:, lowndx);
    wvec = Xmat\cvec;

    figure
    plot(cvec, '.')
    hold on
    plot(Xmat*wvec)
    xlabel('Time')
    ylabel('Price')
    hold off

    % Plot the results
    % %
    % % STUDENT CODE GOES HERE: REMOVE THIS COMMENT
    % % THEN PLOT THE RESULTS
    % %

end
function [rmstrain rmstest] = a2q2(filename,lowndx)
% [RMSTRAIN RMSTEST]=A3Q2(LOWNDX) finds the RMS errors of 5-fold
% cross-validation for the variable LOWNDX of the data in the file
% FILENAME. The RMS errors for the training of each fold are returned
% in RMSTEST and the RMS errors for the testing of each fold are
% returned in RMSTEST.
%
% INPUTS:
%         FILENAME - character string, name of file to be processed;
%                    assume that the first row describes the data variables
%         LOWNDX   - integer scalar, index into the data
% OUTPUTS:
%         RMSTRAIN - 1x5 array of RMS errors for 5-fold training
%         RMSTEST  - 1x5 array of RMS errors for 5-fold testing

    % Read the test data from a CSV file; find the size of the data
    % %
    % % STUDENT CODE GOES HERE: REMOVE THIS COMMENT
    % % THEN READ THE FILE SPECIFIED BY THE INPUT ARGUMENT
    % %

    Amat= readmatrix(filename);
    Amat(:,1) = [];
    n = size(Amat,1);
    m = size(Amat,2);


    yvec = Amat(:, lowndx);
    Amat(:, lowndx) = [];

    [rmstrain, rmstest] = mykfold(Amat, yvec, 5);

end

function [rmstrain,rmstest]=mykfold(Xmat, yvec, k_in)
% [RMSTRAIN,RMSTEST]=MYKFOLD(XMAT,yvec,K) performs a k-fold validation
% of the least-squares linear fit of yvec to XMAT. If K is omitted,
% the default is 5.
%
% INPUTS:
%         XMAT     - MxN data vector
%         yvec     - Mx1 data vector
%         K        - positive integer, number of folds to use
% OUTPUTS:
%         RMSTRAIN - 1xK vector of RMS error of the training fits
%         RMSTEST  - 1xK vector of RMS error of the testing fits

    % Problem size

% 
%     % Process each fold
%     for ix=1:k
%         % %
%         % % STUDENT CODE GOES HERE: replace the next 5 lines with code to
%         % % (1) set up the "train" and "test" indexing for "xmat" and "yvec"
%         % % (2) use the indexing to set up the "train" and "test" data
%         % % (3) compute "wvec" for the training data
%         % %


M = size(Xmat, 1);

if nargin >= 3 & ~isempty(k_in)
    k = max(min(round(k_in), M-1), 2);
else
    k = 5
end

rmstrain = zeros(1, k);
rmstest = zeros(1, k);

perm = randperm(M);
Xmat = Xmat(perm, :);
yvec = yvec(perm);

fold_size = floor(M/k);
for ix = 1:k
    start_ix = (ix-1)*fold_size + 1;
    end_ix = ix*fold_size;


    %testing data
    Xmat_test = Xmat(start_ix:end_ix, :);
    yvec_test = yvec(start_ix:end_ix);

    %training data
    Xmat_train = Xmat([1:start_ix-1, end_ix+1:end], :);
    yvec_train = yvec([1:start_ix-1, end_ix+1:end]);


    wvec = Xmat_train\yvec_train;

    %error vectors
    evec_train = yvec_train - Xmat_train*wvec;
    evec_test = yvec_test - Xmat_test*wvec;

    %RMS errors
    rmstrain(ix) = rms(evec_train);
    rmstest(ix) = rms(evec_test);
end

end

