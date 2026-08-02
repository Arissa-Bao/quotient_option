
function [f] = CDF(x)
%UNTITLED2 
[~,i,~]=unique(x);
y=x(sort(i));
% y=sort(x);

n=length(y);
f=zeros(1,n);

for i=1:n
    f(i)=sum(sum(x<=y(i)))/length(x);
end
                          
end