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
            % Xs in Xs and Ys in Ys, read one single pixel and soon you'll
            % read nine
            % the relative matrices exist to allow reading of all local
            % pixels
            xrel = [-1,-1,-1;0,0,0;1,1,1];
            yrel = [1,0,-1;1,0,-1;1,0,-1];
            % csum contains all filtered pixels
            csum = 0;
            for iy = 1:3
                for ix = 1:3
                    csum = csum + im(i+xrel(ix,iy),j+yrel(ix,iy));
                end
            end
            % store the final convoluted value
            c(j-1,i-1) = csum;
            j = j + 1;
        end
        i = i + 1;
    end
    c = c;
end