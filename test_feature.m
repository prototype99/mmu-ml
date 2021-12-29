% Description: test a feature for the investigation and output the accuracy
%
% Inputs: testCat, testData, trainCat, trainData
function test_feature(testCat, testData, trainCat, trainData)
    % train the model
    model = fitcknn(trainData,trainCat,"NumNeighbors",3);
    % use the model to predict what label each row of data will have
    predictions = predict(model, testData);
    % create a confusion matrix to aid in performance evaluation
    [results,~] = confusionmat(testCat, predictions);
    % create a percentage accuracy to allow easy comparison
    a = 100 * (sum(diag(results)) / sum(results(:)));
    % declare the accuracy
    disp('The accuracy is: ' + a + '%')
end