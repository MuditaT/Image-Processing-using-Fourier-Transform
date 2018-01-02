function ButterHighFilter(im)
    %butterworth(image,cut_off frequency,order) high frequency filter
    Ahat=fft2(im);
    Fsh = fftshift(Ahat);
    h =size(im,1);
    w=size(im,2);
    [x,y]=meshgrid(-floor(w/2):floor(w-1)/2,-floor(h/2):floor(h-1)/2);
    out=(1./(1.+(15./(x.^2+y.^2).^0.5).^(2*1)));
    afhb=Fsh.*out;
    aff1=log(1+abs(afhb));
    affm=max(aff1(:));
    figure
    subplot(2,1,1)
    imshow(im2uint8(aff1/affm));
    title('Fourier transform after butterworth high frequency filter')
    aiff=ifft2(afhb);
    aiff1=abs(aiff);
    aiffm=max(aiff1(:));
    subplot(2,1,2)
    imshow(aiff1/aiffm);
    title('Inverse Fourier transform')
end