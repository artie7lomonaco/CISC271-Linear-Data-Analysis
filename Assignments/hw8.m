% perform PCA and LDA
%create ellipse data, do PCA
pca08;

%extract the dat for LDA

X1 = Xe(ye < 0,:);
X2 = Xe(ye >= 0,:);

%within labels: means nad scatter
X1m = mean(X1)
X2m = mean(X2)
Sw1 = (X1 - X1m)'*(X1 - X1m);
Sw2 = (X2 - X2m)'*(X2 - X2m);
Sw = Sw1 + Sw2;

%between labels: means and scatter
Mb = [X1m ; X2m]
Sb = (Mb - mean(Mb))'* (Mb - mean(Mb))

%spectral decomposition of inv(Sw)*Sb
[Eraw lraw] = eig(inv(Sw)*Sb);

%sort eigenvalues in decreasing order
[lvec ndx] = sort(diag(lraw), 'descend');

%permute eigenvectors
Emat = Eraw(:, ndx)/norm(Eraw, 'fro');

%lda main axis
Qlda = Emat(:,1)
hold on;
quiver(Xem(1), Xem(2), 4*Qlda(1), 4*Qlda(2),...
 'color', 'm', 'LineWidth', 2);
hold off;