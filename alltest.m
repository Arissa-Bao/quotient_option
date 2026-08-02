function [test0,pansari,pks2] = alltest(residual)
n=length(residual);
test0=zeros(2,n-3);
for i= 1:n-3
    r1=residual(1:i+1);
    r2=residual((i+2):n);
    [~,p0]=ansaribradley(r1,r2);%检验是否服从同一分布；
    [~,p1]=kstest2(r1,r2); %KS2
  if p0<0.05
      test0(1,i)=p0;
  else
      test0(1,i)=1;
  end
   if p1<0.05
      test0(2,i)=p1;
  else
      test0(2,i)=1;
  end
end

pansari=min(test0(1,:));
pks2=min(test0(2,:));
end

