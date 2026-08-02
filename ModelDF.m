
function [f] = ModelDF(x,ModelStyle,coeff)
%UNTITLED2 

[~,i,~]=unique(x);
x=x(sort(i));


n=length(x);
f=zeros(1,n);

if strcmp(ModelStyle,'normal')==1
    for i=1:n
        f(i)=1/(1+exp(pi*(coeff(1)-x(i))/(sqrt(3)*coeff(2))));
    end

elseif strcmp(ModelStyle,'linear')==1
    for i=1:n
        if x(i)<coeff(1)
            f(i)=0;
        elseif x(i)>=coeff(1) && x(i)<=coeff(2)
            f(i)=(x(i)-coeff(1))/(coeff(2)-coeff(1));
        elseif x(i)>coeff(2)
            f(i)=1;
        end
    end
    
elseif strcmp(ModelStyle,'zigzag')==1
    for i=1:n
        if x(i)<coeff(1)
            f(i)=0;
        elseif x(i)>=coeff(1) && x(i)<=coeff(2)
            f(i)=(x(i)-coeff(1))/(2*(coeff(2)-coeff(1)));
        elseif x(i)>coeff(2) && x(i)<=coeff(3)
            f(i)=(x(i)+coeff(3)-2*coeff(2))/(2*(coeff(3)-coeff(2)));
        else
            f(i)=1;
        end
    end  

elseif strcmp(ModelStyle,'truncated normal')==1
    for i=1:n
        if x(i)<0
            f(i)=0;
        else
            f(i)=1/(1+exp(pi*(coeff(1)-x(i))/(sqrt(3)*coeff(2))));
        end
    end

elseif strcmp(ModelStyle,'truncated linear')==1
    for i=1:n
        if x(i)<0
            f(i)=0;
        elseif x(i)>=0 && x(i)<=coeff(2)
            f(i)=(x(i)-coeff(1))/(coeff(2)-coeff(1));
        elseif x(i)>coeff(2)
            f(i)=1;
        end
    end


elseif strcmp(ModelStyle,'lognormal')==1
    for i=1:n
        f(i)=1/(1+exp(pi*(coeff(1)-log(x(i)))/(sqrt(3)*coeff(2))));
    end


elseif strcmp(ModelStyle,'logisticgrowth')==1
    for i=1:n
        if x(i)<0
            f(i)=0;
        elseif x(i)>=0 
            f(i)=1/(1+coeff(1)*exp(-coeff(2)*x(i)));
        end
    end

elseif strcmp(ModelStyle,'1-1/x')==1
    for i=1:n
        if x(i)<coeff(1)
            f(i)=1-coeff(2)/coeff(1);
        elseif x(i)>=coeff(1)
            f(i)=1-coeff(2)/x(i);
        end
    end

elseif strcmp(ModelStyle,'1-exp(-x)')==1
    for i=1:n
        if x(i)<coeff(1)
            f(i)=1-exp(-coeff(2)*coeff(1));
        elseif x(i)>=coeff(1)
            f(i)=1-exp(-coeff(2)*x(i));
        end
    end 

elseif strcmp(ModelStyle,'sqrt(x)')==1
     coeff(3)=0.14;
    for i=1:n
        if x(i)<coeff(1)
            f(i)=(coeff(1)/coeff(2))^(coeff(3));
        elseif x(i)>=coeff(1) && x(i)<coeff(2)
            f(i)=(x(i)/coeff(2))^(coeff(3));
        elseif x(i)>=coeff(2)
            f(i)=1;
        end
    end 
       
end
            
              
end