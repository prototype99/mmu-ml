% TODO: what if the image already is greyscale?
% Description: convert a given image to greyscale
%
% Inputs:
% im: an image
% 
% Outputs: 
% im_g: a greyscale image consisting of uint8 values
function im_g = my_im2gray(im)
    % go through all the pixels
    for i = 1:size(im, 1)
        for j = 1:size(im, 2)
            % store the pixel converted to greyscale, then cast it to the
            % required data type (which also solves rounding)
            im_g(i,j,:) = cast(sum([im(i,j,1),im(i,j,2),im(i,j,3)])/4,'uint8');
        end
    end
end