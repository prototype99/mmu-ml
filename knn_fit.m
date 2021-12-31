% TODO: add validation?
% Description: create a model ready to perform k-NN classification
% from some training data
%
% Inputs:
% train_examples: a numeric array containing the training examples
% train_labels: a categorical array containing the associated
% labels (i.e., with the same ordering as train_examples)
% 
% Outputs:
% m: a struct holding the parameters of the k-NN model (the
% training examples, the training labels, and a value for k - the number of
% nearest neighbours to use)
function m = knn_fit(train_examples, train_labels)
    % store the values in a simple struct. Always use 3 as requested
    m = struct('train_examples', train_examples, 'train_labels', train_labels, 'k', 3);
end