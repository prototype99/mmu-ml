% Description: test a feature for the investigation
%
% Inputs: x: the feature number, matches up to the header
% 
% Outputs: a: the overall accuracy
function a = test_feature(x)
    % re-seed the random number for reproducible results
    rng(0);
    % read the file's data and store it in memory
    if x == 1
        data = readcell('MerchData.csv');
    else
        data = imageDatastore('MerchData', ...
        'IncludeSubfolders', true, ...
        'LabelSource', 'foldernames');
    end
    % create a 2:3 split of test:train randomised data
    if x == 1
        data(1,:) = []; % remove the headers
        data = data(randperm(size(data,1)),:);
        testSize = round(0.4 * size(data,1));
        testData = data(1:testSize,:);
        trainData = data(testSize+1:end,:);
    else
        [imdsTrain, imdsTest] = splitEachLabel(data, 0.6, 'randomize');
    end
    % gather the labels
    if x == 1
        trainCat = categorical(trainData(:,2));
        testCat = categorical(testData(:,2));
    else
        trainCat = imdsTrain.Labels;
        testCat = imdsTest.Labels;
    end
    % prepare the data
    if x == 1
        % strip the categories
        trainData(:,2) = [];
        testData(:,2) = [];
        % convert to matrices
        trainData = cell2mat(trainData(:,:));
        testData = cell2mat(testData(:,:));
    else
        % initialise arrays
        trainData = [];
        testData = [];
        % one feature needs words, the rest not so much
        if x == 5
            words = bagOfFeatures(imdsTrain);
        else
            words = 0;
        end
        % test resnet50 on a sample image
        if x == 6
            % set the requested neural network
            net = resnet50;
            % retrieve the first test image
            im = imdsTest.read();
            % make sure later uses still use all images
            imdsTest.reset;
            inputSize = net.Layers(1).InputSize;
            im = imresize(im,inputSize(1:2));
            label = classify(net,im)
        end
        % populate arrays, feature is extracted from greyscale image
        while hasdata(imdsTrain)
            trainData(end+1,:) = get_feature(x, im2gray(imdsTrain.read()), words);
        end
        while hasdata(imdsTest)
            testData(end+1,:) = get_feature(x, im2gray(imdsTest.read()), words);
        end
    end
    % train the model
    model = fitcknn(trainData,trainCat,"NumNeighbors",3);
    % use the model to predict what label each row of data will have
    predictions = predict(model, testData);
    % create a confusion matrix to aid in performance evaluation
    [results,~] = confusionmat(testCat, predictions);
    % create a percentage accuracy to allow easy comparison
    a = 100 * (sum(diag(results)) / sum(results(:)));
end