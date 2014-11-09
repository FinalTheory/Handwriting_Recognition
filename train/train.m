function train()
%% Initialization
clear ; close all; clc

%% Setup the parameters
input_layer_size  = 784;  % 20x20 Input Images of Digits
hidden_layer_size = 50;   % 25 hidden units
num_labels = 10;          % 10 labels, from 1 to 10   
                          % (note that we have mapped "0" to label 10)
%% Load data
load('10kdata.mat');
m = size(X, 1);

%% Show data
sel = randperm(size(X, 1));
sel = sel(1:100);
displayData(X(sel, :));
fprintf('Now showing data\n'); pause;

%% Init parameters
fprintf('\nInitializing Neural Network Parameters ...\n');
initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

%% Begin to train
fprintf('\nTraining Neural Network... \n');
options = optimset('MaxIter', 400);
lambda = 1;
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambda);
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

%% Check result
pred = predict(Theta1, Theta2, X);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);

%% Save results
save('../NN.mat', 'Theta1', 'Theta2');

end
