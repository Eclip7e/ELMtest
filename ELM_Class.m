classdef ELM_Class
    %ELM_CLASS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        nInputs         % number of input days
        nHidden         % number of hidden nodes                
        actFun          % activation function     
        IW              % input weights
        nOutputs        % output weights
        nFeatures       % #features
        Betha           % Betha weights
        H               % H matrix
        bias            % bias for input layer        
    end
   % g = 1.0 ./ (1.0 + exp(-z));

    methods
        %constructor
        function obj = ELM_Class(nInputs, nHidden,nOutputs,nFeatures, actFun ,bias)
            %ELM_CLASS Construct an instance of this class
            %   Detailed explanation goes here
        obj.nInputs = nInputs;        
        obj.nHidden  = nHidden;
        obj.nOutputs = nOutputs;
        obj.bias = bias;
        obj.nFeatures=nFeatures;
         switch actFun
                case 'tanh'
                    obj.actFun = @(x) (1-2./(exp(2*x)+1));
                case 'sig'
                    obj.actFun = @(x)(1./(1+exp(-x)));
                case 'linear'
                    obj.actFun = @(x) (x);
                case 'radbas'
                    obj.actFun = @radbas;
                case 'sine'
                    obj.actFun = @sin;
                case 'hardlim'
                    obj.actFun = @(x) (double(hardlim(x)));
                case 'tribas'
                    obj.actFun = @tribas;
                otherwise
                    obj.actFun = @(x)(1./(1+exp(-x)));   % custom activation sigmoid
         end
        end
        
        function num = getnumofOutdays(obj)
            num = obj.nOutputs;
        end
        function obj = train(obj,X,Y)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            %adding bias neuron 
            X= [(ones(size(X,1),1)*obj.bias) X];
            obj.IW= randInitializeWeights(obj.nInputs*obj.nFeatures, obj.nHidden);
            obj.H = obj.actFun(X * obj.IW');
            %removed bias from hidden layer its not needed
            %obj.H = [ones(size(obj.H,1),1) obj.H];
            obj.Betha = pinv(obj.H)*Y;
        end
        
        function Y = predict(obj,X)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            %adding bias neuron 
            X= [(ones(size(X,1),1)*obj.bias) X];
            Hi = obj.actFun(X * obj.IW');
           %removed bias from hidden layer its not needed
           % Hi = [ones(size(Hi,1),1) Hi];
            Y = Hi * obj.Betha;
        end
        
        function [outX,outY] = rearrangeData(obj,X)
            sizeX=size(X,1);
            sizeOfRearrangedData = sizeX-(obj.nInputs+obj.nOutputs)+1;
            if(sizeOfRearrangedData < 1)
                disp('you need to provide bigger dataset!')
            else
                %flip X upside down so that latest dates are first
                X=flipud(X);
                outY=[];
                %transposing X so later in for loop we can treat entire
                %matrix as 1 row in row major order, otherwise it would be
                %in column major order.
                XT=X';
                %its defacto obj.nFeatures
                ncols=size(X,2);
                j=0;
                for i=1:sizeOfRearrangedData
                    %the below operation allows us to have all rows of X 
                    %from i to i+ninputs-1 in 1row
                    outX(i,:)=XT(j+1: (j+ (obj.nInputs*ncols)));
                    outY(i,:)=XT(obj.nInputs*ncols+(j)+1:obj.nInputs*ncols+(j) + ncols*obj.nOutputs);
                    j=i*ncols;
                end
            end
        end
        

    end
end

