clearvars;
dst = double(imread('dst_9.png'));
src = double(imread('src_9.png')); % flipped girl, because of the eyes
[ni,nj, nChannels]=size(dst);

param.hi=1;
param.hj=1;


%masks to exchange:
mask_src=logical(imread('src_9_mask.png'));
mask_dst=logical(imread('src_9_mask.png'));

for nC = 1: nChannels
    
    %TO DO: COMPLETE the ??

    drivingGrad_i = sol_DiBwd(src(:,:,nC)) + sol_DiFwd(src(:,:,nC));
    drivingGrad_j = sol_DjBwd(src(:,:,nC)) + sol_DjFwd(src(:,:,nC));

    driving_on_src = drivingGrad_i + drivingGrad_j; 


    driving_on_dst = zeros(size(src(:,:,1)));   
    driving_on_dst(mask_dst(:)) = driving_on_src(mask_src(:));
    
    param.driving = driving_on_dst;

    dst1(:,:,nC) = G2_Poisson_Equation_Axb(dst(:,:,nC), mask_dst,  param);
end
 



imshow(dst1/256)