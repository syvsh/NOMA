clc;
clear all;

MC = 1e7;
Nt = 2;
Nr = 2;
alph = [0.01:0.01:0.99];
avgR=zeros(1,numel(alph));
P = 10;

for (alp = 0.01:0.01:0.99)%Power allocation factor
    sumR = 0;
    a1 = alp;
    a2 = 1 - alp;
    A = [a1,a2];
    B = sort(A,'descend');
    No = 1;
    for c = 1:MC
        h1 = (randn(Nr,Nt)+1i*randn(Nr,Nt))/sqrt(2);        
        h2 = (randn(Nr,Nt)+1i*randn(Nr,Nt))/sqrt(2);

        g1 = (norm(h1))^2;
        g2 = (norm(h2))^2;
       
        gamma_1 = (sqrt(B(1) * P) * g1)/(sqrt(B(2) * P) * g1 + No);
        gamma_2 = (sqrt(B(2) * P) * g2)/No;
      
        R1 = log2(1 + gamma_1);
        R2 = log2(1 + gamma_2);
        R = R1 + R2 ;
        sumR = sumR + R;
    end
    avg = sumR/MC;
    
    int8(alp*100)
    
    avgR(int8(alp*100)) = avg;
end

p1 = plot(alph,avgR,'color','r','LineWidth',2);
xlabel('\alpha');
ylabel('Achievable sumrate');
title('Plot of Sumrate vs \alpha for a MIMO NOMA system');


