%week 10: hyperplane classification
load10;

%compute the normalized hyperplane
naug = waug/norm(waug(1:2));
show10(Amat, yvec, waug);
title('separation by hyperplane');

%q1: observations
qbyW = (Amat*waug) >= 0;
qbyN = (Amat*naug) >= 0;

%display results
fprintf('Q1> Classifications by:\n      w           n');
disp([qbyW qbyN]);

%q2: score the data using W and N
zbyW = Amat*waug;
ZbyN = Amat*naug

%display results
fprintf('Q2> scores by:\n      W           N\n');
disp([zbyW ZbyN]);

%anonymous definition of logistic f
z2p = @(u) 1./(1 + exp(-u));

%q3: probabilites, from W (wrong) and N (correct)
pbyW = z2p(zbyW);
pbyN = z2p(ZbyN);

%display results
fprintf('Q3> probabilites by :\n      W           N\n');
disp([pbyW pbyN]);


%q4: odds, from W to N
obyW = pbyW./(1-pbyW);
obyN = pbyN./(1-pbyN);

%display results
fprintf('Q4> Odds by :\n   W       N\n');
fprintf('%10.4f %4.1f\n', [obyW obyN]);

%Extra: data with LDA hyperplane
load('lda10.txt');
show10(Amat,yvec,lda10);
title('Separation by LDA');



