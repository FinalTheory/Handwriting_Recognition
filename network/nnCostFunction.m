function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)

Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

m = size(X, 1);
         
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

Y = zeros(m, num_labels);
for i = 1:m; Y(i, int32(y(i))) = 1; end

X = [ones(m, 1), X];
z2 = X * Theta1';
a2 = sigmoid(z2);
a2 = [ones(size(a2, 1), 1), a2];
z3 = a2 * Theta2';
a3 = sigmoid(z3);

J = sum( sum( -Y .* log(a3) - (1 - Y) .* log(1 - a3) ) ) / m + ...
    ( sum(sum(Theta1(:, 2:end).^2)) + sum(sum(Theta2(:, 2:end).^2)) ) * lambda / (2*m);

delta3 = a3 - Y;
delta2 = delta3 * Theta2;
delta2 = delta2(:, 2:end) .* sigmoidGradient(z2);

Theta1_grad = delta2' * X / m;
Theta2_grad = delta3' * a2 / m;

Theta1(:, 1) = 0;
Theta2(:, 1) = 0;
Theta1_grad = Theta1_grad + Theta1 * lambda / m;
Theta2_grad = Theta2_grad + Theta2 * lambda / m;

grad = [Theta1_grad(:) ; Theta2_grad(:)];

end
