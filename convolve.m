% Description: apply a 3x3 filter to a padded image that has been
% transposed
%
% Inputs: im: an image, f: a filter
% 
% Outputs: c: a convoluted image
function c = convolve(im,f)
    % make an iterator, we skip the first row, it's all padding
    i = 2;
    for y = i:size(im,1)-1
        % make an iterator, we skip the first column, it's all padding
        j = 2;
        for x = j:size(im,2)-1
            c(j-1,i-1) = im(i,j);
            j = j + 1;
        end
        i = i + 1;
    end
    c = c;
end