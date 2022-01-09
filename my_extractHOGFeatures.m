% TODO: this is, umm... slower than the bundled version. At least the
% performance is equal?
% Description: given a greyscale image, extract HOG features from patches
% of size 16*16 pixels using 9-bin histograms, and return all the bin
% totals in a single large array
%
% Inputs: im: an image
% 
% Outputs: h an array containing all the resulting bin totals (all
% individual histograms concatenated together)
function h = my_extractHOGFeatures(im)
    xsize = size(im,1);
    ysize = size(im,2);
    % check for excess pixels
    xcess = mod(xsize,16);
    ycess = mod(ysize,16);
    % check for excess pixels
    if xcess > 0 || ycess > 0
        % resize the image so that it fits a 16x16 grid
        im = imresize(im,[xsize-xcess,ysize-ycess]);
    end
    % initialise array
    h = [];
    % find the tile starting points
    for y = 1:16:size(im, 1)
        for x = 1:16:size(im, 2)
            % initialise empty tile
            itile = [];
            % construct an image tile
            for iy = 1:16
                for ix = 1:16
                    itile(ix,iy) = im(x+ix-1,y+iy-1);
                end
            end
            % collect gradients using the prewitt method
            [Gx, Gy] = my_imgradientxy(itile);
            % generate magnitudes and angles
            [Gmag, Gdir] = imgradient(Gx, Gy);
            % prepare the axes, I want their edges extra sharp
            Gaxes = [0,0,0,0,0,0,0,0,0];
            % look at all 16 values
            for g = 1:16
                % ignore empty magnitudes
                if Gmag(g) ~= 0
                    % see where this value fits on the histogram
                    if Gdir(g) >= 140
                        Gbin = 1;
                    elseif Gdir(g) >= 100
                        Gbin = 2;
                    elseif Gdir(g) >= 60
                        Gbin = 3;
                    elseif Gdir(g) >= 20
                        Gbin = 4;
                    elseif Gdir(g) >= -20
                        Gbin = 5;
                    elseif Gdir(g) >= -60
                        Gbin = 6;
                    elseif Gdir(g) >= -100
                        Gbin = 7;
                    elseif Gdir(g) >= -140
                        Gbin = 8;
                    else
                        Gbin = 9;
                    end
                    % add the magnitude
                    Gaxes(Gbin) = Gaxes(Gbin) + Gmag(g);
                end
            end
            for i = 1:9
                h(end+1) = Gaxes(i);
            end
        end
    end
    % normalise so that the unit l2 norm is equal to 1, this is basically
    % single block level lighting normalisation
    h = h .* (1 / (sqrt(sum(h .^ 2))));
end