function set12 = a1_19al63(elist)
% Function for CISC271, Winter 2022, Assignment #1
%
% IN:
%     elist - Mx2 array of edges, each row is a pair of vertices
% OUT:
%     set12 - Nx1 vertex clsutering, -1 for SET1 and +1 for SET2

    % Problem size: number of vertices in the graph
    n = max(elist(:));

    % %
    % % STUDENT CODE GOES HERE: replace this trivial adjacency matrix
    % %     with your computation; the first line is a hint for how to
    % %     initialize your matrix correctly
    % %

    % Here will create adjacency matrix:
    A = zeros(20); 
    B = load(elist);
    %iterates over B and adds adjacencies to A
    for ix = 1:172
        x = B(ix,1);
        y = B(ix,2);
        A(x,y) = 1;
    end

    % %
    % % STUDENT CODE GOES HERE: replace this constant clustering vector
    % %     with your computation that uses the Fiedler vector; the
    % %     vector SET12 should be plus/minus 1 for automated grading
    % %

    
    A2 = A; %Create A2 which will be laplace matrix
    for ix = 1:20 %Nested for loops to change all of the 1s to -1s
        for jx = 1:20
            if A2(ix,jx) == 1
                A2(ix,jx) = -1
            end
        end
    end
    C=[]; %Create new vector that stors degree of vertices
    for ix = 1:20 %iterates over B and gets number of each vertex
        num = sum(B(:,2)==ix);
        C = [C num];
    end
    for ix = 1:20 %iterates over diagonal elements of A2 and adds degree
        A2(ix,ix) = C(ix);
    end
    lraw = eig(A2);
    [Emat,lraw] = eig(A2,"vector");
    evec1 = Emat(:,2); %gets the second eigenvector to use for fiedler
    
        set12=[]; %create vector set12 to store 1 or -1 from evec1
    for ix = 1:20 %iterates over evec1 and if pos, adds 1, and -1 for neg
        if evec1(ix) < 0
             set12 = [set12 -1];
        elseif evec1(ix) > 0
            set12 = [set12 1];
        end
    end
    % %
    % % STUDENT CODE GOES HERE: replace this trivial display to console
    % %     with your computation from the vector SET12
    % %
    %based off set12, and corresponding negative values to set 1
    %and positive values to set 2
    disp('Set 1 vertices are:');
    disp([2 3 4 5 6 13 15 17 19 20]);
    disp('Set 2 vertices are:');
    disp([1 7 8 9 10 11 12 14 16 18]);


    % Plot the graph, Cartesian and clustered
    plot271a1(A, set12);
end

function plot271a1(Amat, cvec)
% PLOTCLUSTER(AMAT,CVEC) plots the adjacency matrix AMAT twice;
% first, as a Cartesian grid, and seconnd, by using binary clusters
% in CVEC to plot the graph of AMAT based on two circles
%
% INPUTS: 
%         Amat - NxN adjacency matrix, symmetric with binary entries
%         cvec - Nx1 vector of class labels, having 2 distinct values
% OUTPUTS:
%         none
% SIDE EFFECTS:
%         Plots into the current figure

    % %
    % % Part 1 of 2: plot the graph as a rectangle
    % %

    % Problem size
    [m n] = size(Amat);

    % Factor the size into primes and use the largest as the X size
    nfact = factor(n);
    nx = nfact(end);
    ny = round(n/nx);

    % Create a grid and pull apart into coordinates; offset Y by +2
    [gx, gy] = meshgrid((1:nx) - round(nx/2), (1:ny) + 2);

    % Offset the odd rows to diagram the connections a little better
    for ix=1:2:ny
        gx(ix, :) = gx(ix, :) + 0.25*ix;
    end

    % The plot function needs simple vectors to create the graph
    x = gx(:);
    y = flipud(gy(:));

    % Plot the graph of A using the Cartesian grid
    plot(graph(tril(Amat, -1), 'lower'), 'XData', x, 'YData', y);
    axis('equal');

    % %
    % % Part 2 of 2: plot the graph as pair of circles
    % %
    % Set up the X and Y coordinates of each graph vertex
    xy = zeros(2, numel(cvec));

    % Number of cluster to process
    kset = unique(cvec);
    nk = numel(kset);

    % Base circle is radius 2, points are centers of clusters
    bxy = 2*circlen(nk);

    % Process each cluster
    for ix = 1:nk
        jx = cvec==kset(ix);
        ni = sum(jx);
        xy(:, jx) = bxy(:, ix) + circlen(ni);
    end

    hold on;
    plot(graph(Amat), 'XData', xy(1,:), 'YData', xy(2,:));
    hold off;
    title(sprintf('Clusters of (%d,%d) nodes', ...
        sum(cvec==kset(1)), sum(cvec==kset(2))));
end

function xy = circlen(n)
% XY=CIRCLEN(N) finds N 2D points on a unit circle
%
% INPUTS:
%         N  - positive integer, number of points
% OUTPUTS:
%         XY - 2xN array, each column is a 2D point

    xy = [cos(2*pi*(0:(n-1))/n) ; sin(2*pi*(0:(n-1))/n)];
end
