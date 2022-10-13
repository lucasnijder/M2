%Example script: You should replace the beginning of each function ('sol')
%with the name of your group. i.e. if your gropu name is 'G8' you should
%call :
% G8_DualTV_Inpainting_GD(I, mask, paramInp, paramROF)

clearvars;

name= './images/tests/image2';

I = double(imread([ name '_toRestore.jpg']));


%Number of pixels for each dimension, and number of channles
[ni, nj, nC] = size(I);

if nC==3
    I = mean(I,3); %Convert to b/w. If you load a color image you should comment this line
end

%Normalize values into [0,1]
I=I-min(I(:));
I=I/max(I(:));

%Load the mask
mask_img = double(imread([name '_mask.jpg']));
%mask_img =mask_img(1:10,1:10);
[ni, nj, nC] = size(mask_img);
if nC==3
    mask_img = mask_img(:,:,1); %Convert to b/w. If you load a color image you should comment this line
end
%We want to inpaint those areas in which mask == 1
mask = mask_img >128; %mask(i,j) == 1 means we have lost information in that pixel
                      %mask(i,j) == 0 means we have information in that
                      %pixel
                                                                    
%%%Parameters for gradient descent (you do not need for week1)
param.dt = 5*10^-7;
param.iterMax = 10^4;
param.tol = 10^-5;

%%Parameters 
param.hi = 1 / (ni-1);
param.hj = 1 / (nj-1);


figure(1)
imshow(I);
title('Before')

Iinp=team_MLR(I, mask, param);
figure(2)
imshow(Iinp)
title('After');

%% Challenge image. (We have lost 99% of information)
clearvars

name= './images/tests/image5';

I = double(imread([ name '_toRestore.jpg']));

%Normalize values into [0,1]
I=I/256;


%Number of pixels for each dimension, and number of channels
[ni, nj, nC] = size(I);

mask_img = double(imread([name '_mask.jpg']));
mask = mask_img >128; %mask(i,j) == 1 means we have lost information in that pixel
                      %mask(i,j) == 0 means we have information in that
                      %pixel

param.hi = 1 / (ni-1);
param.hj = 1 / (nj-1);

figure(1)
imshow(I);
title('Before')

Iinp(:,:,1)=team_MLR(I(:,:,1), mask(:,:,1), param);
Iinp(:,:,2)=team_MLR(I(:,:,2), mask(:,:,2), param);
Iinp(:,:,3)=team_MLR(I(:,:,3), mask(:,:,3), param);

figure(2)
imshow(Iinp)
title('After');

%% Goal Image
clearvars;

%Read the image
name= './images/tests/image';

I = double(imread([ name '_toRestore.png']));

[ni, nj, nC] = size(I);


I = I - min(I(:));
I = I / max(I(:));

%We want to inpaint those areas in which mask == 1 (red part of the image)
I_ch1 = I(:,:,1);
I_ch2 = I(:,:,2);
I_ch3 = I(:,:,3);

%TO COMPLETE 1
mask =1.*(I(:,:,1)>0.5 & I(:,:,2)<0.3 & I(:,:,3)<0.3) ; %mask_img(i,j) == 1 means we have lost information in that pixel
                                                         %mask(i,j) == 0 means we have information in that pixel

%%%Parameters for gradient descent (you do not need for week1)
%param.dt = 5*10^-7;
%param.iterMax = 10^4;
%param.tol = 10^-5;

%parameters
param.hi = 1 / (ni-1);
param.hj = 1 / (nj-1);

% for each channel 
figure(1)
imshow(I);
title('Before')

Iinp(:,:,1)=team_MLR(I_ch1, mask, param);
Iinp(:,:,2)=team_MLR(I_ch2, mask, param);
Iinp(:,:,3)=team_MLR(I_ch3, mask, param);
    
figure(2)
imshow(Iinp)
title('After');
