load ../NN.mat; 

X = loadMNISTImages('data/t10k-images.idx3-ubyte')';
y = loadMNISTLabels('data/t10k-labels.idx1-ubyte');
y(y == 0) = 10;

pred = predict(Theta1, Theta2, X);
fprintf('\nTest Set Accuracy: %f\n', mean(double(pred == y)) * 100);
mask = (pred ~= y);
displayData(X(mask, :));