function HFDdescriptor = HFD(img, ThresholdFrequency, imgSize, HighFrequencyRadius)
%% get High Frequency Descriptor of the input img under currect parameters.
% input parameter:
%     @img: the input img mat;
%     @ThresholdFrequency: the threshold of high frequency;
%     @imgSize: the size of input mat;
%     @HighFrequencyRadius: the radius of high frequency.
% output parameter:
%     @LFDDescriptor: the obtained HFD descriptor under currect parameter.

%% default parameter
if nargin < 4
    if nargin < 3
        if nargin < 2
            ThresholdFrequency = 100;
        end
        imgSize = 64;
    end
    HighFrequencyRadius = imgSize / 3;
end

%% fourier spectra
ClientTrainFFT = abs(fftshift(fft2(img)));

%% energy of high frequencies
HighFrequencyEnergy = 0;
for x = 1 : imgSize
    for y = 1 : imgSize
        if ((x-(1+imgSize)/2)^2 + (y-(1+imgSize)/2)^2) > HighFrequencyRadius^2 && ClientTrainFFT(x,y) >= ThresholdFrequency
            HighFrequencyEnergy = HighFrequencyEnergy + ClientTrainFFT(x,y);
        end
    end
end

%% energy of all frequencies
TotalEnergy = sum(ClientTrainFFT(:)) - sum(img(:));
%% high frequency descriptor
HFDdescriptor = HighFrequencyEnergy / TotalEnergy;

end