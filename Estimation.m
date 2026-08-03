function [coefficient,Fvar,Exitflag]=Estimation(coeff0,t,x,alpha,signal,UDE,method)
n = length(t);
Residual = zeros(1,n);
beta = 0.95;

if strcmp(method,'MME')==1
    delta=0.000001;
elseif strcmp(method,'MLE')==1
    delta=0.000000000000001;
    num=ceil((n-1)*alpha)-1;    %
elseif strcmp(method,'LSE')==1 
    delta=0.000001;  
else
end

%
    function [f1] = FunctionMME(coeff)
        Residual=ResidualGenerate(coeff,delta,t,x,signal,UDE);
        k=length(coeff);
        H=zeros(1,k);
        for i=1:k
            H(i)=(mean(Residual.^i)-1/(i+1))^2;
        end
        f1=sum(H);
    end

%
    function [f2] = FunctionMLE(coeff)
        Residual=ResidualGenerate(coeff,delta,t,x,signal,UDE);
        residual=sort(Residual);  %
        if num>=1
            for i=1:num   %
                if residual(2)-residual(1)>residual(length(residual))-residual(length(residual)-1)   %
                    residual(1)=[];
                else
                    residual(length(residual))=[];
                end
            end
        else
        end
        g=(residual(1)-alpha/2)^2+(residual(length(residual))+alpha/2-1)^2;
        if residual(1)>=alpha/2 && residual(length(residual))<=1-alpha/2    %正常值的话
            f2=g;
        else
            f2=g+1;
        end
    end

%
    function [f3] = FunctionLSE(coeff)
        Residual=ResidualGenerate(coeff,delta,t,x,signal,UDE);
        f3=sum((ModelDF(Residual,'linear',[0,1])-CDF(Residual)).^2);
    end

%
    function [f4] = FunctionMCE(coeff)
        f4 = alphaPath(coeff,beta ,t(n-1),t(n),x(n-1),UDE) - alphaPath(coeff0,1-beta,t(n-1),t(n),x(n-1),UDE);
    end

    function [c,ceq]=nonlconeg(coeff0)
        c = zeros(1,n);
        for i = 1:n
            c(i) = x(i) - alphaPath(coeff0,beta ,t(n-1),t(n),x(n-1),UDE);
            c(i+n) = -x(i) + alphaPath(coeff0,1-beta,t(n-1),t(n),x(n-1),UDE);
        end
        ceq=[];
    end


    if strcmp(method,'MME') == 1
        [coefficient,Fvar,Exitflag]=fminsearch(@FunctionMME,coeff0);
    elseif strcmp(method,'MLE') == 1
        [coefficient,Fvar,Exitflag]=fminsearch(@FunctionMLE,coeff0);
    elseif strcmp(method,'LSE') == 1
        [coefficient,Fvar,Exitflag]=fminsearch(@FunctionLSE,coeff0); 
    elseif strcmp(method,'MCE') == 1
        lb = [];
        ub = [];
        % 
        % 'interior-point'
        % 'trust-region-reflective'：
        % 'sqp'：
        % 'sqp-legacy'：
        % 'active-set'：
        options = optimoptions('fmincon', 'Algorithm', 'sqp');
        [coefficient,Fvar,Exitflag]=fmincon(@FunctionMCE,coeff0,[],[],[],[],lb,ub,@nonlconeg,options); 
    else
    end
end

