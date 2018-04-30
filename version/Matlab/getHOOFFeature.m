function Feature = getHOOFFeature(OF, bins, blocks)
%% get HOOF features of the input img under currect parameters
% by the function gradientHistogram provided in HOOF toolbox..
% input parameter:
%     @OF: the optical flow captured by the camera;
%     @bins & blocks: decide the HOOF feature's size jointly.
% output parameter:
%     @Feature: the obtained HOOF feature under currect parameter.

Feature = zeros(1, bins * blocks * blocks);
[h, w] = size(OF);
OF(isnan(OF)) = 0;
for iBlock = 1 : blocks
    for jBlock = 1 : blocks
        Feature(((iBlock - 1) * blocks + jBlock - 1) * bins + 1 : ((iBlock - 1) * blocks + jBlock - 1) * bins + bins) = ...
            gradientHistogram(...
            real(OF(round(1+h*(iBlock-1)/(blocks+1)):round(h*(iBlock+1)/(blocks+1)), round(1+w*(jBlock-1)/(blocks+1)):round(w*(jBlock+1)/(blocks+1)))), ...
            imag(OF(round(1+h*(iBlock-1)/(blocks+1)):round(h*(iBlock+1)/(blocks+1)), round(1+w*(jBlock-1)/(blocks+1)):round(w*(jBlock+1)/(blocks+1)))), ...
            bins)';
    end
end
Feature(isnan(Feature)) = 0;

end