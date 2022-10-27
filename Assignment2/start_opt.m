clearvars;
dst = double(imread('dst_6.png'));
src = double(imread('src_6.png')); 
[ni,nj, nChannels]=size(dst);

param.hi=1;
param.hj=1;

%masks to exchange: Eyes
mask_src=logical(imread('src_6_mask.png'));
mask_dst=logical(imread('dtc_6_mask.png'));

for nC = 1: nChannels

    grad_src_i = sol_DiFwd(src(:,:,nC), param.hi)-sol_DiBwd(src(:,:,nC), param.hi);
    grad_src_j = sol_DjFwd(src(:,:,nC), param.hj)-sol_DiBwd(src(:,:,nC), param.hj);
    
    grad_dst_i = sol_DiFwd(dst(:,:,nC), param.hi)-sol_DiBwd(dst(:,:,nC), param.hi);
    grad_dst_j = sol_DjFwd(dst(:,:,nC), param.hj)-sol_DjBwd(dst(:,:,nC), param.hj);


    driving_Grad_src_i = zeros(size(dst(:,:,1)));
    driving_Grad_src_j = zeros(size(dst(:,:,1)));
    
    driving_Grad_src_i(mask_dst(:)) = grad_src_i(mask_src(:));
    driving_Grad_src_j(mask_dst(:)) = grad_src_j(mask_src(:));
    
   
    driving_Grad_dst_i = zeros(size(dst(:,:,1)));
    driving_Grad_dst_j = zeros(size(dst(:,:,1)));

    driving_Grad_dst_i(mask_dst(:)) = grad_dst_i(mask_dst(:));
    driving_Grad_dst_j(mask_dst(:)) = grad_dst_j(mask_dst(:));

    %Criteria - check which absolute value of the gradient is bigger
    bigger_Grad_i=compare(driving_Grad_dst_i,driving_Grad_src_i);
    bigger_Grad_j=compare(driving_Grad_dst_j,driving_Grad_src_j);
    
    %Compute the driving gradient of the image with the bigger gradient 
    driving_on_dst_i = sol_DiBwd(bigger_Grad_i, param.hi)-sol_DiFwd(bigger_Grad_i, param.hi);    
    driving_on_dst_j = sol_DjBwd(bigger_Grad_j, param.hj)-sol_DjFwd(bigger_Grad_j, param.hj);  

    driving_on_dst = driving_on_dst_i + driving_on_dst_j;
      
    param.driving = driving_on_dst;
    dst1(:,:,nC) = G2_Poisson_Equation_Axb(dst(:,:,nC), mask_dst,  param);

end
 
imshow(dst1/256)


%funtion to compute the criteria:
function grad = compare(grad_F, grad_G)
    if abs(grad_F)>abs(grad_G)
        grad = grad_F;
    else
        grad = grad_G;
    end
end
