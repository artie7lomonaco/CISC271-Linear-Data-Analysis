%CISC 271 Winter 2022 week 7
% script for k means of small data
% data and distance matrix

Amat = [8 4 ; 4 7 ; 6 4 ; 2 8 ; 5 8 ; 7 3]
Dmat = dist(Amat')
gscatter(Amat(:,1), Amat(:,2)); % plot
axis([1 9 1 9])

% initializations in the homework
g1 = Amat(4,:)    % method 1, step one then step two
g2 = Amat(1,:)
S1 = Amat(1:3,:)  % method 2, step two then step one
S2 = Amat(4:6,:)

% step 1: using centroids (guesses) find partitions of A
dvec1 = pdist2(Amat, g1) % find the distance from all the observations in A to the point g1
dvec2 = pdist2(Amat, g2)

dvec1<dvec2 
 % let's just take a look at what this cause we're going to use it
 % dvec1<dvec2 = [0 1 0 1 1 0]
 % dvec1<dvec2 has a 1 where the boolean is true, 0 where its false
 % this computations lets us skip having to loop
 % this is an instance of "vectorization" - a HUGE concept in compsci

% when we pass a logical array as index, it grabs only entries where the logical array is 1
Part1 = Amat(dvec1 < dvec2, :) 
Part2 = Amat(dvec1 > dvec2, :)

% step 2: from initial partitions, find centroids (guesses)
ix1 = dsearchn(Amat, mean(S1))
ix2 = dsearchn(Amat, mean(S2))
c1 = Amat(ix1, :)
c2 = Amat(ix2, :)

%% kmeans outputs 2 things: 
% 1) the partition, 
% 2) the centroids of each partition element (OR the point in each
% partition element which is closest to the centroid - we can specify this in function options)
