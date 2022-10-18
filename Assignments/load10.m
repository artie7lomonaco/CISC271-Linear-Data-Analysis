% SHOW10 - Script for CISC1271, Winter 2022, Homework Week 10

    % Load the data into Amat and Yvec
    Araw = load('hw10.txt');
    Amat = [Araw(:, 1:(end-1)) ones(size(Araw,1), 1)];
    yvec = Araw(:, end);
    
    % Load the hyperplane
    waug = load('waug.txt');
    naug = waug/norm(waug(1:2));
    
    % Compute a reasonable plot axis
    ax10 = [(floor(min(Amat(:,1))) - 1) (ceil(max(Amat(:,1))) + 1) ...
        (floor(min(Amat(:,2))) - 1) (ceil(max(Amat(:,2))) + 1)];
    