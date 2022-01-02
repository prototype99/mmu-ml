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
function predictions = knn_predict(m, testData)
    predictions = categorical;
    % loop over the data, it must be transposed to loop over it
    for p = testData.'
        i = 1;
        % build the general array structure, ready to use
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
        % fill the predictions array. because k is 3, the mode is taken out
        % of the 3 most similar values
        predictions(end+1,:) = mode([m.trainCat(dists(1,2)),m.trainCat(dists(2,2)),m.trainCat(dists(3,2))]);
    end
end