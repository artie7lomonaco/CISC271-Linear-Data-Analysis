function show10(Amat, yvec, wvec)
% SHOW10(AMAT,WVEC) displays 2D data in AMAT with labels YVEC,
% plus the hyperplane specified in WVEC.
%
% INPUTS:
%         AMAT - Mx2 design matrix; can be wider than N=2
%         YVEC - Mx1 labels, usually 0 and 1
%         WVEC - (N+1)x1 augmented normal vector for
%                a hyperplane
% OUTPUTS:
%         none

    % Compute a reasonable plot axis for the data
    axv = [(floor(min(Amat(:,1))) - 1) , ...
        (ceil(max(Amat(:,1))) + 1) , ...
        (floor(min(Amat(:,2))) - 1) , ...
        (ceil(max(Amat(:,2))) + 1)];

    % Normalize the hyperplane vector and define
    % its scoring function
    naug = wvec/norm(wvec(1:(end - 1)));
    fimp =@(x,y) x*naug(1) + y*naug(2) + naug(3);

    % Compute X and Y grids, plus an anonymous function
    gdensity = 100;
    xlin = linspace(axv(1), axv(2), gdensity);
    ylin = linspace(axv(3), axv(4), gdensity);
    [xg,yg] = meshgrid(xlin, ylin);

    % Point close to hyperplane midpoint
    mtheta = 0.01;
    mx = mean(xg(abs(fimp(xg, yg))<mtheta));
    my = mean(yg(abs(fimp(xg, yg))<mtheta));

    % Scale factor is 15% of axis range
    vscale = 0.15;
    vmag = vscale*max([axv(2) - axv(1) , axv(4) - axv(3)]);

    % Plot the data
    ph = gscatter(Amat(:,1), Amat(:,2), yvec, ...
        'rb', 'o+', [], 'off');
    set(ph, 'LineWidth', 2);
    axis(axv);
    axis('equal');

    % Plot the hyperplane and normal vector
    hold on;
    contour(xg, yg, fimp(xg,yg), [0,0], ...
        'Color', 'k', 'LineWidth', 2);
    quiver(mx, my, vmag*naug(1), vmag*naug(2), ...
        'MaxHeadSize', vmag, 'AutoScale', 'off', ...
        'Color', 'k', 'LineWidth', 2);
    hold off;
end
