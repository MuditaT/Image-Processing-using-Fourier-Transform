function LowPassFilter(im)
    %Low Pass Filter in Fourier Domain
    %cut off
    [nx,ny]=size(im);
    [x,y]=meshgrid(-nx/2:(nx/2-1),-ny/2:(ny/2-1));
    z=sqrt(x.^2+y.^2);
    %c=z<15; % sharp cut off 15
    c=z<40;
    Ahat=fft2(im);
    Fsh = fftshift(Ahat);
    af1=Fsh.*c;
    aff1=log(1+abs(af1));
    affm=max(aff1(:));
    figure
    subplot(2,1,1)
    imshow(im2uint8(aff1/affm));
    title('Fourier trnasform of image after cut off')
    aiff=ifft2(af1);
    aiff1=abs(aiff);
    aiffm=max(aiff1(:));
    subplot(2,1,2)
    imshow(aiff1/aiffm);
    title('Inverse Fourier transform')
end
