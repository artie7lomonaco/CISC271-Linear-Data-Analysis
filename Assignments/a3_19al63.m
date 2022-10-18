function a3_19al63
% Function for CISC271, Winter 2022, Assignment #3

    
    %a)
    Xmat = csvread("wine.csv", 0, 1);
    yvec = transpose(Xmat(1, :));
    Xmat(1,:) = [];
    Xmat = transpose(Xmat);
    dbScores = [];

    for ix = 1:size(Xmat, 2);
        pca1 = Xmat(:, ix);
        for kx = 1:size(Xmat, 2);
            pca2 = Xmat(:, kx);
            Dmat = [pca1(:), pca2(:)];
            dbValue = dbindex(Dmat, yvec);
            dbScores = [dbScores, dbValue];
        end
    end
    dbValue
    dbScores;
    iValues = [1,7]
    ax1 = Xmat(:,iValues(1));
    ax2 = Xmat(:,iValues(2));
    Dmat = [ax1 , ax2];
    gscatter(ax1, ax2, yvec);

    %b)
    M = Xmat - mean(Xmat);
    B = (M'*M)/(size(M,1)-1);

    %Find the eigenvectors of B
    svd(B);
    [V,D] = eig(B);
    D=diag(D);
    maxeigval=V(:,D==max(D));

    [U,S,V] = svd(B);
    eigenValuess = S;
    eigenVectors = U;
    s = sqrt(S);
    loadingVectors = eigenVectors*s;
    ax3 = M*loadingVectors(:,1);
    ax4 = M*loadingVectors(:,2);

    Dmat = [ax3, ax4];
    dbindex(Dmat, yvec)
    gscatter(ax3, ax4, yvec);

    %C
    Zscore = zscore(Xmat);
    B2 = (Zscore'*Zscore)/(size(Zscore,2)-1);
    [U,S,V] = svd(B2);
    eigenValuess = S;
    eigenVectors = U;
    loadingVectors = eigenVectors*s;
    ax3 = M*loadingVectors(:,1);
    ax4 = M*loadingVectors(:,2);

    Dmat = [ax3, ax4];
    dbindex(Dmat, yvec)
    gscatter(ax3, ax4, yvec);
   


    

end
function score = dbindex(Xmat, lvec)
% SCORE=DBINDEX(XMAT,LVEC) computes the Davies-Bouldin index
% for a design matrix XMAT by using the values in LVEC as labels.
% The calculation implements a formula in their journal article.
%
% INPUTS:
%        XMAT  - MxN design matrix, each row is an observation and
%                each column is a variable
%        LVEC  - Mx1 label vector, each entry is an observation label
% OUTPUT:
%        SCORE - non-negative scalar, smaller is "better" separation

    % Anonymous function for Euclidean norm of observations
    rownorm = @(xmat) sqrt(sum(xmat.^2, 2));

    % Problem: unique labels and how many there are
    kset = unique(lvec);
    k = length(kset);

    % Loop over all indexes and accumulate the DB score of each cluster
    % gi is the cluster centroid
    % mi is the mean distance from the centroid
    % Di contains the distance ratios between IX and each other cluster
    D = [];
    for ix = 1:k
        Xi = Xmat(lvec==kset(ix), :);
        gi = mean(Xi);
        mi = mean(rownorm(Xi - gi));
        Di = [];
        for jx = 1:k
            if jx~=ix
                Xj = Xmat(lvec==kset(jx), :);
                gj = mean(Xj);
                mj = mean(rownorm(Xj - gj));
                Di(end+1) = (mi + mj)/norm(gi - gj);
            end
        end
        D(end+1) = max(Di);
    end

    % DB score is the mean of the scores of the clusters
    score = mean(D);
end
