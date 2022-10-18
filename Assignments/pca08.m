% Script for CISC271, Fall 2022, Week #8
% Load data and perform PCA
load Xe.txt;
load ye.txt;

% Means and PCA
Xem  = mean(Xe);
Qe = pca(Xe);

% PCA main axis
Qpca = Qe(:,1)

% Plot the data and PCA axis
gscatter(Xe(:,1),Xe(:,2),ye);
hold on;
quiver(Xem(1), Xem(2), 2*Qpca(1), 2*Qpca(2),...
'color', 'k', 'LineWidth', 2);
hold off;
