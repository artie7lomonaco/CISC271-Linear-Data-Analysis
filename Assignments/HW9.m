% CISC271, Winter 2022: Homework for Week #9, data

    % Question 1: Confusion matrix
    y1 = [1  -1  -1   1  -1   1   1   1  -1  -1   1  -1]';
    q1 = [1  -1   1   1  -1   1  -1   1   1  -1   1  -1]';
    
    %true false comparison for labels and predictions
    tp = sum((y1>0) & (q1 > 0));
    tn = sum(~(y1>0) & ~(q1 > 0));
    fp = sum(~(y1>0) & (q1 > 0));
    fn = sum((y1>0) & ~(q1 > 0));
    %confusion matrix
    Ccomp = [tp fn ; fp tn]
    %confusion from builtin
    Cmat = confusionmat(y1, q1, ...
        'Order', [1,-1]);

    % Question 2: Y labels and Z scores
    y2 = [1  -1  -1   1  -1   1   1   1  -1  -1   1  -1]';
    %z2 = [-2.5, -2, -1.5, -1, -0.5 0, 0.5, 1, 1.5, 2, 2.5, 3];
    z2 = linspace(-2.5, 3, 12);
    t2vals = [-0.75 ; -0.25 ; 1.25];

    %classes and confusion matrices
    q2a = sign(z2 - t2vals(1));
    q2b = sign(z2 - t2vals(2));
    q2c = sign(z2 - t2vals(3));

    %compute confusion matrix myself
    q2aa = q2a';
    tp1 = sum((y2>0) & (q2aa > 0));
    tn1 = sum(~(y2>0) & ~(q2aa > 0));
    fp1 = sum(~(y2>0) & (q2aa > 0));
    fn1 = sum((y2>0) & ~(q2aa > 0));
    cmatq2 = [tp1 fn1; fp1 tn1]
    %compute confusion matrices with built-in function
    disp(' Y2 Q2a Q2b Q2c');
    Cmat1r = [tp1 fn1 ; fp1 tn1]
    Cmat1b = confusionmat(y2, q2a, ...
        'Order', [1,-1])
    Cmat2b = confusionmat(y2, q2b, ...
        'Order', [1,-1])
    Cmat3b = confusionmat(y2, q2c, ...
        'Order', [1,-1])
    
    % Question 3: confusion matrices
    cm3a = [98  2 ; 81 19];
    cm3b = [92  8 ; 56 44];
    cm3c = [78 22 ; 29 71];
    cm3d = [57 43 ; 11 89];
    cm3e = [34 66 ;  3 97];

    %Q3: FPR and TPR per matrix
    fprA = cm3a(2,1)/sum(cm3a(2,:)); %false positive RATE (false alarm rate)
    tprA = cm3a(1,1)/sum(cm3a(1,:)); %true positive RATE (sensitivity)
    fprintf('FPR=%0.2f TPR=%0.2f\n', fprA,tprA)
    fnrA = cm3a(1,2)/ sum(cm3a(2,:)); %false negative RATE (miss rate)
    tnrA = cm3a(2,2)/ sum(cm3a(2,:)); %true negative RATE (specificity)
    acc = (cm3a(1,1) + cm3a(2,2)) / (sum(cm3a(1,:)) + sum(cm3a(2,:))); %accuracy
    
    fprB = cm3b(2,1)/sum(cm3b(2,:));
    tprB = cm3b(1,1)/sum(cm3b(1,:));
    fprintf('FPR=%0.2f TPR=%0.2f\n', fprB,tprB)
    
    fprC = cm3c(2,1)/sum(cm3c(2,:));
    tprC = cm3c(1,1)/sum(cm3c(1,:));
    fprintf('FPR=%0.2f TPR=%0.2f\n', fprC,tprC)

    fprD = cm3d(2,1)/sum(cm3d(2,:));
    tprD = cm3d(1,1)/sum(cm3d(1,:));
    fprintf('FPR=%0.2f TPR=%0.2f\n', fprD,tprD)
    
    fprE = cm3e(2,1)/sum(cm3e(2,:));
    tprE = cm3e(1,1)/sum(cm3e(1,:));
    fprintf('FPR=%0.2f TPR=%0.2f\n', fprE,tprE)

      
    % Question 4: ROC vectors
    rv4a = [0.05;0.60];
    rv4b = [0.40;0.80];
    rv4c = [0.65;0.66];
    rv4d = [0.01;0.99];
    rv4e = [0.60;0.19];

    %Q3: plot a blank square
    hv = [0 1 1 0 0];
    vv = [0 0 1 1 0]; 
    plot(hv, vv, 'k-')
    % plot (0,0), then (1,0), then (1,1) etc.
    % we tell matlab to plot with black line, so we get a black square
    xlabel('FPR');
    ylabel('TPR');

    %Q3: add the ROC points
    hold on;
    plot(fprA, tprA, 'k*')
    plot(fprB, tprB, 'r*')
    plot(fprC, tprC, 'g*')
    plot(fprD, tprD, 'b*')
    plot(fprE, tprE, 'm*')
... (5 lines left)