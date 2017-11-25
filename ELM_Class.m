classdef ELM_Class
    %ELM_CLASS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        nInputs         % number of inputs
        nHidden         % number of hidden nodes                
        actFun          % activation function     
        IW              % input weights
        nOutputs
        Betha           % Betha weights
        H               % H matrix
        bias % bias        
    end
   % g = 1.0 ./ (1.0 + exp(-z));

    methods
        %constructor
        function obj = ELM_Class(nInputs, nHidden,nOutputs, actFun ,bias)
            %ELM_CLASS Construct an instance of this class
            %   Detailed explanation goes here
        obj.nInputs = nInputs;        
        obj.nHidden  = nHidden;
        obj.nOutputs = nOutputs;
        obj.bias = bias;
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
        
        function obj = train(obj,X,Y)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            %adding bias neuron 
            X= [(ones(size(X,1),1)*obj.bias) X];
            obj.IW= randInitializeWeights(obj.nInputs, obj.nHidden);
            obj.H = X * obj.IW';
            obj.Betha = pinv(obj.H)*Y;
        end
        
        function Y = predict(obj,X)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            %adding bias neuron 
            X= [(ones(size(X,1),1)*obj.bias) X];
            Hi = X * obj.IW';
            Y = Hi * obj.Betha;
        end
    end
end

