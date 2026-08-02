function [e,sigma,outlier,signal,out] = Test(alpha,residual)
beta=1-alpha;
e=mean(residual);
sigma=std2(residual);
n=length(residual);
temp=sigma*sqrt(3)/pi*log((1+beta)/(1-beta));
RankTest=zeros(1,n);
out=zeros(1,n);
for i=1:n
    if residual(i)>1-alpha/2 || residual(i)<alpha/2
        RankTest(i)=1;
        out(i+1)=1;
    else
    end
end
if sum(RankTest)>n*alpha
    signal=0;
else
    signal=1;
end
outlier=sum(RankTest);
end

