function MagnitudeSpectrum(im)
    Ahat=fft2(im);
    Fsh = fftshift(Ahat);
    F=log(abs(Fsh)+1);
    F=mat2gray(F);
    figure
    imagesc(100*F); colormap(gray);
    title('magnitude spectrum')
end