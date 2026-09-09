
function [f] = CDF(x)

[~,i,~]=unique(x);
y=x(sort(i));

n=length(y);
f=zeros(1,n);

for i=1:n
    f(i)=sum(sum(x<=y(i)))/length(x);
end
                          
end