function GaussianHighFilter(im)
    %gaussian high frequency filter
    Ahat=fft2(im);
    [nx,~]=size(im);
    Fsh = fftshift(Ahat);
    gau=fspecial('gaussian',nx,10);
    g1=mat2gray(gau);
    ag1=Fsh.*(1-g1);
    aff1=log(1+abs(ag1));
    affm=max(aff1(:));
    figure(1)
    subplot(2,1,1)
    imshow(im2uint8(aff1/affm));
    title('Gaussian high frequency transform ')
    aiff=ifft2(ag1);
    aiff1=abs(aiff);
    aiffm=max(aiff1(:));
    subplot(2,1,2)
    imshow(aiff1/aiffm);
    title('Inverse Fourier transform')
end