clearvars;

% Change name to image you want to inpaint
img_name = 'image2';
path_name= append('./images/tests/',img_name);

% set I to the original image (with holes)
I = double(imread([ path_name '_toRestore.jpg']));

%Number of pixels for each dimension, and number of channles
[ni, nj, nC] = size(I);

if nC==3
    I = mean(I,3); %Convert to b/w. If you load a color image you should comment this line
end

%Normalize values into [0,1]
I=I-min(I(:));
I=I/max(I(:));

%Load the mask
mask_img = double(imread([path_name '_mask.jpg']));
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

img_before = figure(1);
imshow(I);
title('Before')

image_before_save_name = append('./results/tests/', img_name,'_before.png');
saveas(img_before,image_before_save_name);

Iinp=team_MLR(I, mask, param);
    
img_after = figure(2);
imshow(Iinp)
title('After');

image_after_save_name = append('./results/tests/', img_name,'_after.png');
saveas(img_after, image_after_save_name);

%% Challenge image. (We have lost 99% of information)
clearvars;

% Change name to image you want to inpaint
img_name = 'image5';
path_name= append('./images/tests/',img_name);

% set I to the original image (with holes)
I = double(imread([ path_name '_toRestore.jpg']));

%Normalize values into [0,1]
I=I/256;


%Number of pixels for each dimension, and number of channels
[ni, nj, nC] = size(I);

mask_img = double(imread([path_name '_mask.jpg']));
mask = mask_img >128; %mask(i,j) == 1 means we have lost information in that pixel
                      %mask(i,j) == 0 means we have information in that
                      %pixel

param.hi = 1 / (ni-1);
param.hj = 1 / (nj-1);

img_before = figure(1);
imshow(I);
title('Before')

image_before_save_name = append('./results/tests/', img_name,'_before.png');
saveas(img_before,image_before_save_name);

Iinp(:,:,1)=team_MLR(I(:,:,1), mask(:,:,1), param);
Iinp(:,:,2)=team_MLR(I(:,:,2), mask(:,:,2), param);
Iinp(:,:,3)=team_MLR(I(:,:,3), mask(:,:,3), param);
    
img_after = figure(2);
imshow(Iinp)
title('After');

image_after_save_name = append('./results/tests/', img_name,'_after.png');
saveas(img_after, image_after_save_name);



%% Goal Image
clearvars;

%Read the image
img_name = 'image';
path_name= append('./images/tests/',img_name);

I = double(imread([ path_name '_toRestore.png']));

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
img_before = figure(1);
imshow(I);
title('Before')

image_before_save_name = append('./results/tests/', img_name,'_before.png');
saveas(img_before,image_before_save_name);

Iinp(:,:,1)=team_MLR(I_ch1, mask, param);
Iinp(:,:,2)=team_MLR(I_ch2, mask, param);
Iinp(:,:,3)=team_MLR(I_ch3, mask, param);
    
img_after = figure(2);
imshow(Iinp)
title('After');

image_after_save_name = append('./results/tests/', img_name,'_after.png');
saveas(img_after, image_after_save_name);

%% Example images
clearvars;

% select the image, choose from: night, social, desert
img_name = 'night';
path_name= append('./images/examples/',img_name);

%Read the image
I = double(imread([ path_name '_toRestore.png']));

[ni, nj, nC] = size(I);


I = I - min(I(:));
I = I / max(I(:));

%We want to inpaint those areas in which mask == 1 (red part of the image)
I_ch1 = I(:,:,1);
I_ch2 = I(:,:,2);
I_ch3 = I(:,:,3);

mask_img = double(imread([path_name '_mask.png']));
mask = mask_img > 128;
%TO COMPLETE 1
 %mask_img(i,j) == 1 means we have lost information in that pixel
                                      %mask(i,j) == 0 means we have information in that pixel

%%%Parameters for gradient descent (you do not need for week1)
%param.dt = 5*10^-7;
%param.iterMax = 10^4;
%param.tol = 10^-5;

%parameters
param.hi = 1 / (ni-1);
param.hj = 1 / (nj-1);

% for each channel 

img_before = figure(1);
imshow(I);
title('Before')

image_before_save_name = append('./results/examples/', img_name,'_before.png');
saveas(img_before,image_before_save_name);

Iinp(:,:,1)=team_MLR(I_ch1, mask, param);
Iinp(:,:,2)=team_MLR(I_ch2, mask, param);
Iinp(:,:,3)=team_MLR(I_ch3, mask, param);
    
img_after = figure(2);
imshow(Iinp)
title('After');

image_after_save_name = append('./results/examples/', img_name,'_after.png');
saveas(img_after,image_after_save_name);

return;