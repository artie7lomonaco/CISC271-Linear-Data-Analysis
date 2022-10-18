Amat = [1 1 ; 2 0 ; -1 2 ; 0 -1 ; 7 7 ; 8 7 ; 5 8 ; 8 8];
g1 = Amat(1,:);
g2 = Amat(2,:);
S1 = Amat(1:2,:); 
S2 = Amat(3:8,:);
partition1 = pdist2(Amat, g1);
partition2 = pdist2(Amat, g2);
index1 = dsearchn(Amat, mean(S1))
index2 = dsearchn(Amat, mean(S2))
centroid1 = Amat(index1, :)
centroid2 = Amat(index2, :)

s1 = kmeans(Amat(1:2,:),2);
s2 = kmeans(Amat(3:8,:),2);

% yk3 = kmeans(zmat, 3, 'start', [1 1 ; 0 -2 ; 3 1]);
% for ix = 1:size(yk3, 2);
%         pca1 = yk3(:, ix);
%         for kx = 1:size(yk3, 2);
%             pca2 = yk3(:, kx);
%             Dmat = [pca1(:), pca2(:)];
%             incorrect_value = dbindex(Dmat, yvec);
%             ivIndexes = [ivIndexes, incorrect_value];
%         end
% end




