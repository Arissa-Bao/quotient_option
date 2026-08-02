function [residual] = ResidualGenerate(Parameter,delta,t,x,signal,UDE)

n=length(t);
residual=zeros(1,n);
if strcmp(signal,'uncertain')==1
    for i=2:n
        timelow=t(i-1);
        timeup=t(i);
        initialValue=x(i-1);
        endValue=x(i);
        a=0;
        b=1;
        beta=(a+b)/2;
        Path=endValue+1;
        while (b-a)>delta
            Path=alphaPath(Parameter,beta,timelow,timeup,initialValue,UDE);
            if Path==endValue
                break
            elseif Path<endValue
                a=beta;
            else
                b=beta;
            end
            beta=(a+b)/2;
        end
        residual(i)=beta;
    end
elseif strcmp(signal,'random')==1
    if strcmp(UDE,'linear')==1
        for i=2:n
            timelow=t(i-1);
            timeup=t(i);
            initialValue=x(i-1);
            endValue=x(i);
            Expected=initialValue+Parameter(1)*(timeup-timelow);
            Variance=Parameter(2)*Parameter(2)*(timeup-timelow);
            residual(i)=normcdf(endValue,Expected,sqrt(Variance));
        end
    elseif strcmp(UDE,'exp')==1
        for i=2:n
            timelow=t(i-1);
            timeup=t(i);
            initialValue=x(i-1);
            endValue=(log(x(i)/x(i-1))-(Parameter(1)-Parameter(2)*Parameter(2)/2)*(timeup-timelow))/Parameter(2);
            residual(i)=normcdf(endValue,0,sqrt(timeup-timelow));
        end
    elseif strcmp(UDE,'meanRevertionWithoutXt')==1
        for i=2:n
            timelow=t(i-1);
            timeup=t(i);
            initialValue=x(i-1);
            endValue=x(i);
            Expected=Parameter(1)/Parameter(2)+(initialValue-Parameter(1)/Parameter(2))*exp(Parameter(2)*(timelow-timeup));
            Variance=Parameter(3)*Parameter(3)*(1-exp(2*Parameter(2)*(timelow-timeup)))/(2*Parameter(2));
            residual(i)=normcdf(endValue,Expected,sqrt(Variance));
        end
     elseif strcmp(UDE,'meanRevertionWithXt')==1
        for i=2:n
            timelow=t(i-1);
            timeup=t(i);
            initialValue=x(i-1);
            endValue=x(i);
            num_simulations = 1000;
            num_N = 1000;
            residual(i) = MonteCarlo(Parameter,initialValue,endValue,timelow,timeup,num_simulations,num_N);
        end
    else
    end
else
end
residual(1)=[];
end

