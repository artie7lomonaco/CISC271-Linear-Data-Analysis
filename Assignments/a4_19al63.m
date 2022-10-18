function a4_19al63
% Function for CISC271, Winter 2022, Assignment #4

    % Read the test data from a CSV file
    dmrisk = csvread('dmrisk.csv',1,0);

    % Columns for the data and labels; DM is diabetes, OB is obesity
    jDM = 17;
    jOB = 16;

    % Extract the data matrices and labels
    XDM = dmrisk(:, (1:size(dmrisk,2))~=jDM); %data with no class column
    yDM = dmrisk(:,jDM); % class column
    XOB = dmrisk(:, (1:size(dmrisk,2))~=jOB); % data without obesity column
    yOB = dmrisk(:,jOB); %obesity column

    % Reduce the dimensionality to 2D using PCA
    [~,rDM] = pca(zscore(XDM), 'NumComponents', 2);
    [~,rOB] = pca(zscore(XOB), 'NumComponents', 2);

    % Find the LDA vectors and scores for each data set
    [qDM zDM qOB zOB] = a4q1(rDM, yDM, rOB, yOB);
    %use svd to get largest eigenvector
    [U1,S1,V1]=svd(qDM); 
    v1=U1(:,1);
    [U2,S2,V2]=svd(zDM); 
    v2=U2(:,1)
    [U3,S3,V3]=svd(qOB); 
    v3=U3(:,1)
    [U4,S4,V4]=svd(zDM); 
    v4=U4(:,1)

    % Compute the ROC curve and its AUC where: "xroc" is the horizontal
    % axis of false positive rates; "yroc" is the vertical
    % axis of true positive rates; "auc" is the area under curve
    roccurve(v1,v2);
     test1 = confmat(v1,v2,0.8)
    aucofroc(test1(1,2),test1(1,1))

    roccurve(v3,v4);
     test2 = confmat(v3,v4,0.8)
    aucofroc(test2(1,2),test2(1,1))

% END OF FUNCTION
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [q1, z1, q2, z2] = a4q1(Xmat1, yvec1, Xmat2, yvec2)
% [Q1 Z1 Q2 Z2]=A4Q1(X1,Y1,X2,Y2) computes an LDA axis and a
% score vector for X1 with Y1, and for X2 with Y2.
%
% INPUTS:
%         X1 - MxN data, M observations of N variables
%         Y1 - Mx1 labels, +/- computed as ==/~= 1
%         X2 - MxN data, M observations of N variables
%         Y2 - Mx1 labels, +/- computed as ==/~= 1
% OUTPUTS:
%         Q1 - Nx1 vector, LDA axis of data set #1
%         Z1 - Mx1 vector, scores of data set #1
%         Q2 - Nx1 vector, LDA axis of data set #2
%         Z2 - Mx1 vector, scores of data set #2

    q1 = [];
    z1 = [];
    q2 = [];
    z2 = [];
    
    % Compute the LDA axis for each data set
    q1 = lda2class(Xmat1(yvec1==1,:), Xmat1(yvec1~=1, :));
    q2 = lda2class(Xmat2(yvec2==1,:), Xmat2(yvec2~=1, :));
   
    z1 = Xmat1*q1;
    z2 = Xmat2*q2;
    
% END OF FUNCTION
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function qvec = lda2class(X1, X2)
% QVEC=LDA2(X1,X2) finds Fisher's linear discriminant axis QVEC
% for data in X1 and X2.  The data are assumed to be sufficiently
% independent that the within-label scatter matrix is full rank.
%
% INPUTS:
%         X1   - M1xN data with M1 observations of N variables
%         X2   - M2xN data with M2 observations of N variables
% OUTPUTS:
%         qvec - Nx1 unit direction of maximum separation

    qvec = ones(size(X1,2), 1);
    xbar1 = mean(X1);
    xbar2 = mean(X2);

    %algorithm to get the zero mean matrix of M1 and M2
    col_num = size(X1, 2);
    row_num = size(X1, 1);
    tmp = [];
    for ix = 1:(col_num)
        u = mean(X1(:,ix));
        uVec = u + zeros(row_num, 1);
        tmp = [tmp, uVec];
    end
    zero_mean_matrix1 = X1 - tmp;


    colNum = size(X2, 2);
    rowNum = size(X2, 1);
    tempMat = [];
    for ix = 1:(colNum)
        u = mean(X2(:,ix))
        uVec = u + zeros(rowNum, 1);
        tempMat = [tempMat, uVec];
    end
    zeroMeanMat = X2 - tempMat;

    M1 = zero_mean_matrix1;
    M2 = zeroMeanMat;

    % Compute the within-class means and scatter matrices
    S1 = ((M1).')*M1;
    S2 = ((M2).')*M2;
    SW = S1 + S2;
    
    
    

    % Compute the between-class scatter matrix
    MB = [xbar1 - mean([X1;X2]); xbar2 - mean([X1;X2])];
    SB = (MB - mean(MB))'*(MB - mean(MB))
    
    % Fisher's linear discriminant is the largest eigenvector
    % of the Rayleigh quotient
    [Eraw, lraw] = eig((inv(SW))*SB);
    [lvec, ndx] = sort(diag(lraw), 'descend');
    Emat = Eraw(:, ndx)/norm(Eraw, 'fro');
    %LDA axis
    qvec = Emat(:,1);
   

    % May need to correct the sign of qvec to point towards mean of X1
    if (xbar1 - xbar2)*qvec < 0
        qvec = -qvec;
    end
% END OF FUNCTION
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [fpr tpr auc bopt] = roccurve(yvec_in,zvec_in)
% [FPR TPR AUC BOPT]=ROCCURVE(YVEC,ZVEC) computes the
% ROC curve and related values for labels YVEC and scores ZVEC.
% Unique scores are used as thresholds for binary classification.
%
% INPUTS:
%         YVEC - Mx1 labels, +/- computed as ==/~= 1
%         ZVEC - Mx1 scores, real numbers
% OUTPUTS:
%         FPR  - Kx1 vector of False Positive Rate values
%         TPR  - Kx1 vector of  True Positive Rate values
%         AUC  - scalar, Area Under Curve of ROC determined by TPR and FPR
%         BOPT - scalar, optimal threshold for accuracy

    % Sort the scores and permute the labels accordingly
    [zvec zndx] = sort(zvec_in);
    yvec = yvec_in(zndx);
        
    % Sort and find a unique subset of the scores; problem size
    bvec = unique(zvec);
    bm = numel(bvec);
    
    % Compute a confusion matrix for each unique threshold value;
    % extract normalized entries into TPR and FPR vectors; track
    % the accuracy and optimal B threshold
    tpr = [];
    fpr = [];
    acc = -inf;
    bopt = -inf;
    for jx = 1:bm
        [tpr,fpr,thresholds] = roc(yvec ,bvec);
    end
    
    % Ensure that the rates, from these scores, will plot correctly
    tpr = sort(tpr);
    fpr = sort(fpr);
    
    % Compute AUC for this ROC
    auc = aucofroc(fpr, tpr);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function cmat = confmat(yvec, zvec, theta)
% CMAT=CONFMAT(YVEC,ZVEC,THETA) finds the confusion matrix CMAT for labels
% YVEC from scores ZVEC and a threshold THETA. YVEC is assumed to be +1/-1
% and each entry of ZVEC is scored as -1 if <THETA and +1 otherwise. CMAT
% is returned as [TP FN ; FP TN]
%
% INPUTS:
%         YVEC  - Mx1 values, +/- computed as ==/~= 1
%         ZVEC  - Mx1 scores, real numbers
%         THETA - threshold real-valued scalar
% OUTPUTS:
%         CMAT  - 2x2 confusion matrix; rows are +/- labels,
%                 columns are +/- classifications

    % Find the plus/minus 1 vector of quantizations
    qvec = sign((zvec >= theta) - 0.5);
    
    % Compute the confusion matrix by entries
    yvec2 = []
    for idx = 1:yvec
        if zvec(idx) >= theta
            yvec2 = [yvec2 , 1];
        else
            yvec2 = [yvec2 , -1];
        end
    end
    confmat = zeros(2);
    %for loops that go through yvecs and get the value to be put into
    %confusion matrix
    tmp = 0
    for idx = 1:yvec
        if yvec(idx) == 1 && yvec2(idx) == 1
            tmp = tmp + 1;
        end
    end
    confmat(1,1) = tmp
    tmp = 0
    for idx = 1:yvec
        if yvec(idx) == -1 && yvec2(idx) == -1
            tmp = tmp + 1;
        end
    end
    confmat(2,2) = tmp
    tmp = 0
    for idx = 1:yvec
        if yvec(idx) == -1 && yvec2(idx) == 1
            tmp = tmp + 1;
        end
    end
    confmat(1,2) = tmp
    for idx = 1:yvec
        if yvec(idx) == 1 && yvec2(idx) == 1
            tmp = tmp + 1;
        end
    end
    confmat(2,1) = tmp
    cmat = confmat;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function auc = aucofroc(fpr, tpr)
% AUC=AUCOFROC(TPR,FPR) finds the Area Under Curve of the
% ROC curve specified by the TPR, True Positive Rate, and
% the FPR, False Positive Rate.
%
% INPUTS:
%         TPR - Kx1 vector, rate for underlying score threshold 
%         FPR - Kx1 vector, rate for underlying score threshold 
% OUTPUTS:
%         AUC - integral, from Trapezoidal Rule on [0,0] to [1,1]

    [X undx] = sort(reshape(fpr, 1, numel(fpr)));
    Y = sort(reshape(tpr(undx), 1, numel(undx)));
    auc = abs(trapz([0 X 1] , [0 Y 1]));
end
