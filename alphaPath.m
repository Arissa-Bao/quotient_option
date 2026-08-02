function path = alphaPath(Parameter,alpha,timelow,timeup,initialValue,UDE)
Phi=sqrt(3)*log(alpha/(1-alpha))/pi;
if strcmp(UDE,'linear')==1
    path=initialValue+Parameter(1)*(timeup-timelow)+Phi*Parameter(2)*(timeup-timelow);
elseif strcmp(UDE,'exp')==1
    path=exp(log(initialValue)+Parameter(1)*(timeup-timelow)+Phi*Parameter(2)*(timeup-timelow));
elseif strcmp(UDE,'meanRevertionWithXt')==1
    path=(initialValue+Parameter(1)/(Parameter(3)*Phi-Parameter(2)))*exp((Parameter(3)*Phi-Parameter(2))*(timeup-timelow))-Parameter(1)/(Parameter(3)*Phi-Parameter(2));
elseif strcmp(UDE,'meanRevertionWithoutXt')==1
    path=((Parameter(2)*initialValue-Parameter(1))*exp(Parameter(2)*(timelow-timeup))+Parameter(1)+abs(Parameter(3))*Phi*(1-exp(Parameter(2)*(timelow-timeup))))/Parameter(2);
elseif strcmp(UDE,'exponentialOU')==1
    path=exp(log(initialValue)*exp(-Parameter(1)*Parameter(2)*(timeup-timelow))+1/Parameter(2)*(1-exp(-Parameter(1)*Parameter(2)*(timeup-timelow)))*(1+Parameter(3)*Phi/Parameter(1)));
elseif strcmp(UDE,'cannotBeResolved')==1   
    h=0.00001;
    N=1+floor((timeup-timelow)/h);
    X=zeros(1,N);
    X(1)=initialValue;
    for i=2:N
        [f,g]=FandG(timelow+(i-2)*h,X(i-1),Parameter);
        X(i)=X(i-1)+f*h+abs(g)*Phi*h;
    end
    path=X(N);
%  change this    
% path=(initialValue+Parameter(1)/(Parameter(3)*Phi-Parameter(2)))*exp((Parameter(3)*Phi-Parameter(2))*(timeup-timelow))-Parameter(1)/(Parameter(3)*Phi-Parameter(2));
else
end

end
