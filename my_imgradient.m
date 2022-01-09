% Description: uses horizontal and vertical local gradient estimates to
% compute maximum rate of increase information at each pixel
%
% Inputs: 
% Gx an array of horizontal local gradient estimates in double precision 
% Gy an array of vertical local gradient estimates in double precision
% 
% Outputs:
% Gmag an array of magnitudes for the maximum rate of increase in local
% gradient
% Gdir an array of directions for the maximum rate of increase in local
% gradient (in units of degrees)
function [Gmag, Gdir] = my_imgradient(Gx, Gy)
    for i = 1:16
        Gmag(i) = sqrt(Gx(i)^2 + Gy(i)^2);
        % answer is converted to degrees because the function returns
        % radians
        Gdir(i) = rad2deg(atan2(-Gx(i), Gy(i)));
    end
end