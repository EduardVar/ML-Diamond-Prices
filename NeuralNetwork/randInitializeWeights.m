%{
function W = randInitializeWeights(L_in, L_out)
%RANDINITIALIZEWEIGHTS Randomly initialize the weights of a layer with L_in
%incoming connections and L_out outgoing connections
%   W = RANDINITIALIZEWEIGHTS(L_in, L_out) randomly initializes the weights 
%   of a layer with L_in incoming connections and L_out outgoing 
%   connections. 

% You need to return the following variables correctly 
W = zeros(L_out, 1 + L_in);

% Randomly initialize the weights to small values
epsilon_init = 0.01;    % 0.12 original
W = rand(L_out, 1 + L_in) * 2 * epsilon_init - epsilon_init;
%}

function init_nn_params = randInitializeWeights(L_in, HL_size, L_out, HL_num)

    % Sets the epsilon amount
    epsilon_init = 0.01;    % 0.12 original
    
    % Randomly initialize theta forward towards first hidden layer
    ThetaFirst = rand(HL_size, 1 + L_in) * 2 * epsilon_init - epsilon_init;
    
    % Unrolls input theta into init_nn_params
    init_nn_params = ThetaFirst(:);
    
    disp(size(init_nn_params));
    
    for i = 1:(HL_num-1),
        
        % Makes a hidden layer theta forward to next hidden layer
        Theta = rand(HL_size, 1 + HL_size) * 2 * epsilon_init - epsilon_init;
        
        % Adds unrolled hidden theta to the initial parameters
        init_nn_params = [init_nn_params; Theta(:)];
        
        disp(i);
        disp("HERE");
        
    end
    
    % Randomly initialize last theta forward towards output label(s)
    ThetaLast = rand(L_out, 1 + HL_size) * 2 * epsilon_init - epsilon_init;
    
    % Unrolls output theta into init_nn_params
    init_nn_params = [init_nn_params; ThetaLast(:)];
    
    disp(size(init_nn_params));

end
