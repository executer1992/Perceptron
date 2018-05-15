clear all
clc

I = 1000; %liczba danych

X = rand(2,I)*pi;
Y = cos(X(1,:).*X(2,:).*cos(2*X(1,:)))

eta = 1/100;
K = 20;
w = rand(1,K+1)/1000;


v = rand(K,3)/1000;


for i=1:90
    
    for j=1:I
        
        x=X(:,j); 
        y2 = Y(j);
       
        s = v(:,1) + v(:,2:end) * x;
        fi = 1 / ( 1 + exp(-s) );
        y = w(1) + w(2:end) * fi';

        w = w - eta*(y-y2) * [1 fi];
        v = v - eta*(y-y2) *( w(2:end)' .* ( fi' .* (1-fi') ) )* [1; x]';

    end
    idx = randperm(I);
    X = X(:,idx);
    Y = Y(idx);
end

[x1,x2] = meshgrid([0:0.1:pi]);
y_m = cos(x1.*x2).*cos(2.*x1);
surf(x1,x2,y_m);

[ii,jj] = size(x1);
y = zeros(ii,jj);

for i=1:ii
    
    for j=1:jj
        
        s = v(:,1) + v(:,2:end) * x;
        fi = 1 / ( 1 + exp(-s) );
        y(ii,jj) = w(1) + w(2:end) * fi';
        
    end
    
end

hold on
surf(x1,x2,y);