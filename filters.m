clear all
close all
clc

% Load full image
disp('Loading full image...')
%A=imread('cameraman.jpg');
A=imread('plane.jpg');
figure(1)
subplot(2,1,1)
imshow(A)
title('Original Image')

%make black and white image(gray)
Abw2=rgb2gray(A);
[nx,ny]=size(Abw2);
subplot(2,1,2)
imshow(Abw2)
title('Gray image','FontSize',16)

%compute FFT of our image using FFT2
disp('Doing FFT analysis for sparsity check')

Ahat=fft2(Abw2);
S = abs(Ahat); 
figure(2);
subplot(2,1,1)
imshow(S,[]);
title(' Magnitude Fourier transform function'); 
Y=angle(Ahat);
subplot(2,1,2)
imshow(Y,[]);
title('Phase Fourier transform function');
Fsh = fftshift(Ahat); 
figure(3);
subplot(2,1,1)
imshow(abs(Fsh),[]);
title('Centered fourier transform of Image') 
F=log(abs(Fsh)+1);
F=mat2gray(F);
subplot(2,1,2)
imshow(F,[]); 
title('Log Transformed Image')

%Low Pass Filter in Fourier Domain
%cut off
[x,y]=meshgrid(-nx/2:(nx/2-1),-ny/2:(ny/2-1));
z=sqrt(x.^2+y.^2);
%c=z<15; % sharp cut off 15
c=z<40;
af1=Fsh.*c;
aff1=log(1+abs(af1));
affm=max(aff1(:));
figure(4)
subplot(2,1,1)
imshow(im2uint8(aff1/affm));
title('Low Pass Filter')
aiff=ifft2(af1);
aiff1=abs(aiff);
aiffm=max(aiff1(:));
subplot(2,1,2)
imshow(aiff1/aiffm);
title('Inverse Fourier transform')


%Butterworth low frequency filter
h=size(Abw2,1);
w=size(Abw2,2);
[x,y]=meshgrid(-floor(w/2):floor(w-1)/2,-floor(h/2):floor(h-1)/2);
out=1-(1./(1.+(15./(x.^2+y.^2).^0.5).^(2*1)));
afhb=Fsh.*out;
aff1=log(1+abs(afhb));
affm=max(aff1(:));
figure(5)
subplot(2,1,1)
imshow(im2uint8(aff1/affm));
title('Butterworth low frequency filter')
aiff=ifft2(afhb);
aiff1=abs(aiff);
aiffm=max(aiff1(:));
subplot(2,1,2)
imshow(aiff1/aiffm);
title('Inverse Fourier transform')


%gaussian low frequency filter
gau=fspecial('gaussian',nx,10);
g1=mat2gray(gau);
ag1=Fsh.*(g1);
aff1=log(1+abs(ag1));
affm=max(aff1(:));
figure(6)
subplot(2,1,1)
imshow(im2uint8(aff1/affm));
title('Gaussian low frequency transform ')
aiff=ifft2(ag1);
aiff1=abs(aiff);
aiffm=max(aiff1(:));
subplot(2,1,2)
imshow(aiff1/aiffm);
title('Inverse Fourier transform')

%High Frequency Filter in Fourier Domain
[x,y]=meshgrid(-nx/2:(nx/2-1),-ny/2:(ny/2-1));
 z=sqrt(x.^2+y.^2);
 %c=z<15; % sharp cut off 15
 c=z>40;
 af1=Fsh.*c;
 aff1=log(1+abs(af1));
 affm=max(aff1(:));
 figure(7)
 subplot(2,1,1);
 imshow(im2uint8(aff1/affm));
 title('High Frequency Filter ');
 aiff=ifft2(af1);
 aiff1=abs(aiff);
 aiffm=max(aiff1(:));
 subplot(2,1,2);
 imshow(aiff1/aiffm);
 title('Inverse Fourier Transform');
 
 

%butterworth(image,cut_off frequency,order) high frequency filter
 h =size(Abw2,1);
 w=size(Abw2,2);
 [x,y]=meshgrid(-floor(w/2):floor(w-1)/2,-floor(h/2):floor(h-1)/2);
 out=(1./(1.+(15./(x.^2+y.^2).^0.5).^(2*1)));
 afhb=Fsh.*out;
 aff1=log(1+abs(afhb));
 affm=max(aff1(:));
 figure(8)
 subplot(2,1,1);
 imshow(im2uint8(aff1/affm));
 title('Butterworth High Frequency Filter');
 aiff=ifft2(afhb);
 aiff1=abs(aiff);
 aiffm=max(aiff1(:));
 subplot(2,1,2);
 imshow(aiff1/aiffm);
 title('Inverse Fourier Transform');
 
 %gaussian high frequency filter
gau=fspecial('gaussian',nx,10);
g1=mat2gray(gau);
ag1=Fsh.*(1-g1);
aff1=log(1+abs(ag1));
affm=max(aff1(:));
figure(9)
subplot(2,1,1)
imshow(im2uint8(aff1/affm));
title('Gaussian high frequency transform ')
aiff=ifft2(ag1);
aiff1=abs(aiff);
aiffm=max(aiff1(:));
subplot(2,1,2)
imshow(aiff1/aiffm);
title('Inverse Fourier transform')

%zero out small co-efficients and inverse transform
count_pic=1;
for thresh= .1*[0.001 0.005 0.01]* max(abs(Ahat(:)))
    ind=abs(Ahat)>thresh;
    AhatFilt=Ahat.*ind;
    count=nx*ny-sum(ind(:));
    percent=100-count/(nx*ny)*100;
    Afilt=ifft2(AhatFilt);
    figure(10),subplot(2,2,count_pic)
    imshow(uint8(Afilt));
    count_pic=count_pic+1;
    title([num2str(percent) '% of FFT basis'],'FontSize',14)
end


%plot image as mountain surface


figure
Anew=imresize(Abw2,.1);
hist(double(Anew));
title('original image')

figure
Anew=imresize(Afilt,.1);
surf(double(Anew));
title('filtered image')

figure
Anew=imresize(S,.1);
surf(double(Anew));
title('Fourier transform of the image')

figure
imagesc(angle(Afilt));  colormap(gray);
title('phase spectrum')

figure
imagesc(100*F); colormap(gray); 
title('magnitude spectrum')
                