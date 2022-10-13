%% Example images
clearvars;

%Read the image
I = double(imread('./images/examples/desert_toRestore.png'));

[ni, nj, nC] = size(I);


I = I - min(I(:));
I = I / max(I(:));

%We want to inpaint those areas in which mask == 1 (red part of the image)
I_ch1 = I(:,:,1);
I_ch2 = I(:,:,2);
I_ch3 = I(:,:,3);

mask_img = double(imread('./images/examples/desert_mask.png'));
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

saveas(img_before,'./images/examples/desert_before.png');

Iinp(:,:,1)=team_MLR(I_ch1, mask, param);
Iinp(:,:,2)=team_MLR(I_ch2, mask, param);
Iinp(:,:,3)=team_MLR(I_ch3, mask, param);
    
img_after = figure(2);
imshow(Iinp)
title('After');

saveas(img_after,'./images/examples/desert_after.png');

return;