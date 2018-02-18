clc;
clear all;
close all;
%%Original image
[fname path]=uigetfile('*.jpg','Select an Image');
fname=strcat(path,fname);
img=imread(fname);
figure
subplot(3,2,1);
imshow(img,[]);
title('Original image');
%%introduce noise
im=imnoise(img,'gaussian',0,0.06);
%%figure
subplot(3,2,2);
imshow(im);
title('Noisy Gaussian image');
%%Noise removed
for(i=1:3)
    im2(:,:,i)=medfilt2(im(:,:,i),[3,3]);
end
%%figure
subplot(3,2,3);
imshow(im2);
title('Denoised median image');
%%Gaussian
h=fspecial('gaussian',[5 5],10);
for(i=1:3)
    im3(:,:,i)=imfilter(im(:,:,i),h);
end
%%figure
subplot(3,2,4);
imshow(im3);
title('Denoised Gaussian image');
%%Wiener
win_size=3;
im4=rgb2gray(im);
im5=wiener2(im4,[7 7]);
subplot(3,2,5);
imshow(im4);
title('Denoised Wiener image');
%%Segmentation
t0=40;
th=t0+(max(im2(:))+min(im2(:)))./2;
for(i=1:1:size(im2,1))
    for(j=1:1:size(im2,2))
        if(im2(i,j)>th)
            sout(i,j)=1;
        else
            sout(i,j)=0;
        end
    end
end

subplot(3,2,6);
imshow(sout);
title('Segmented image');








