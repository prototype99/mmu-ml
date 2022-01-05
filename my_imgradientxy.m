% Description: generate image gradients using the prewitt method
%
% Inputs: im: an image
% 
% Outputs: Gx an array of horizontal local gradient estimates in double
% precision Gy an array of vertical local gradient estimates in double
% precision
% 
% Notes: you might want to start by calling imfilter() to do the
% convolutions for you, before then trying to replace them for yourself, or
% you might prefer to jump straight into the convolutions. (Note if you do
% use it that imfilter() will return the same data types you pass it, and
% so you'll lose information if you pass it uint8s.) A full implementation
% should add padding around the image (by copying the closest pixel
% values)
function [Gx, Gy] = my_imgradientxy(im)
    % pad the image. is there an easier way? probably? i'll get back to you
    % on that when i have a positive iq
    im = padarray(im,1,"replicate");
    im = im';
    im = padarray(im,1,"replicate");
    % im is left transposed because of how for loops work, the filters are
    % also transposed
    Gx = convolve(im,[ -1 -1 -1; 0  0  0; 1  1  1]);
    Gy = convolve(im,[ -1  0  1; -1  0  1; -1  0  1 ]);
end