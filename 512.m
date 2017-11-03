clear all, close all, clc

% Load full image
disp('Loading full image...')
A=imread('cameraman','jpeg');
figure(3)
imshow(A)

%make black and white image(gray)
Abw2=rgb2gray(A);
[nx,ny]=size(Abw2);
figure(1), subplot(2,2,1), imshow(Abw2)
title('Original image','FontSize',16)

%compute FFT of our image using FFT2
disp('Doing FFT analysis for sparsity check')

Ahat=fft2(Abw2);
S = abs(Ahat); 
 figure(9);
 imshow(S,[]);
 title(' Magnitude Fourier transform of an image'); 
Y=angle(Ahat);
figure(10);
imshow(Y,[]);
title('Phase Fourier transform of image');
 Fsh = fftshift(Ahat); 
 figure(8);
 imshow(abs(Fsh),[]);
 title('Centered fourier transform of Image') 
F=log(abs(Fsh)+1);
F=mat2gray(F);
figure(4)
imshow(F,[]); 
title('Log Transformed Image')

[x,y]=meshgrid(-128:127,-128:127);
z=sqrt(x.^2+y.^2);
%c=z<15; % sharp cut off 15
c=z<40;
af1=Fsh.*c;
aff1=log(1+abs(af1));
affm=max(aff1(:));
figure,imshow(im2uint8(aff1/affm));
aiff=ifft2(af1)
aiff1=abs(aiff);
aiffm=max(aiff1(:));
figure,imshow(aiff1/aiffm);

h=size(Abw2,1)
w=size(Abw2,2)
[x,y]=meshgrid(-floor(w/2):floor(w-1)/2,-floor(h/2):floor(h-1)/2)
out=1-(1./(1.+(15./(x.^2+y.^2).^0.5).^(2*1)));
afhb=Fsh.*out;
aff1=log(1+abs(afhb));
affm=max(aff1(:));
figure,imshow(im2uint8(aff1/affm));
aiff=ifft2(afhb)
aiff1=abs(aiff);
aiffm=max(aiff1(:));
figure,imshow(aiff1/aiffm);

gau=fspecial('gaussian',256,10);
g1=mat2gray(gau)
ag1=Fsh.*g1
aff1=log(1+abs(ag1));
affm=max(aff1(:));
figure,imshow(im2uint8(aff1/affm));
aiff=ifft2(ag1)
aiff1=abs(aiff);
aiffm=max(aiff1(:));
figure,imshow(aiff1/aiffm);

[x,y]=meshgrid(-128:127,-128:127);
z=sqrt(x.^2+y.^2);
%c=z<15; % sharp cut off 15
c=z>40;
af1=Fsh.*c;
aff1=log(1+abs(af1));
affm=max(aff1(:));
figure,imshow(im2uint8(aff1/affm));
aiff=ifft2(af1)
aiff1=abs(aiff);
aiffm=max(aiff1(:));
figure,imshow(aiff1/aiffm);

%butterworth(image,cut_off frequency,order)
h=size(Abw2,1)
w=size(Abw2,2)
[x,y]=meshgrid(-floor(w/2):floor(w-1)/2,-floor(h/2):floor(h-1)/2)
out=(1./(1.+(15./(x.^2+y.^2).^0.5).^(2*1)));
afhb=Fsh.*out;
aff1=log(1+abs(afhb));
affm=max(aff1(:));
figure,imshow(im2uint8(aff1/affm));
aiff=ifft2(afhb)
aiff1=abs(aiff);
aiffm=max(aiff1(:));
figure,imshow(aiff1/aiffm);

%zero out small co-efficients and inverse transform
count_pic=2;
for thresh= .1*[0.001 0.005 0.01]* max(abs(Ahat(:)));
    ind=abs(Ahat)>thresh;
    AhatFilt=Ahat.*ind;
    count=nx*ny-sum(ind(:));
    percent=100-count/(nx*ny)*100;
    Afilt=ifft2(AhatFilt);
    figure(1),subplot(2,2,count_pic)
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
                