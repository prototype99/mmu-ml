% Description: use an existing k-NN model to classify some testing examples 
%
% Inputs:
% m: a struct containing details of the k-NN model we want to use
% for classification 
% test_examples: a numeric array containing the testing examples we want to
% classify
% 
% Outputs:
% predictions: a categorical array containing the predicted
% labels (i.e., with the same ordering as test_examples)
%
% Notes:
% Assumes that the model m has been created with a call to knn_fit()
function predictions = knn_predict(m, testData)
    % Guidance (first task):
    % 1. initialise an empty categorical array to hold the predictions
    % 2. loop over every example in the testing_examples array
    % and... 
    %   a. find its nearest neighbour in the data inside the
    %   model
    %   b. take the label associated with that nearest neighbour as
    %   your prediction
    %   c. add the new prediction onto the end of your categorical
    %   array (from step 1)
    
    % Guidance (second task):
    % adjust your code to take account of the k value set inside the model
    % m. Adjust step a from above so that all k nearest neighbours are
    % found. Adjust step b from above to take the the most common class
    % label across all k nearest neighbours as your prediction

    predictions = categorical;
    % loop over the data, it must be transposed to loop over it
    for p = testData.'
        i = 1;
        dists = [0,1;0,2;0,3];
        for q = m.trainData.'
            distNew = knn_calculate_distance(p, q);
            switch i
                % the cases exist to prevent null values, these can be
                % hardcoded as we use only one k number
                case 1
                    dists(1,1) = distNew;
                case 2
                    dists(2,1) = distNew;
                case 3
                    dists(3,1) = distNew;
                otherwise
                    for d = [1:3]
                        % ensure the smallest value is stored, because the
                        % largest value is always replaced, it can be
                        % determined that the 3 stored values are the
                        % smallest without any complex comparison
                        if dists(d,1) == max(dists(:,1)) && distNew < min(dists(:,1))
                            % store the new value
                            dists(d,1) = distNew;
                            % store the new location
                            dists(d,2) = i;
                        end
                    end
            end
            % increment index to match the index of the next row to be
            % compared
            i = i + 1;
        end
    end
    prediction = 1;
    predictions(end+1,:) = prediction;
end