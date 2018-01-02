function MountainAfterFFT(im)
    Ahat=fft2(im);
    S = abs(Ahat);
    figure
    Anew=imresize(S,.1);
    surf(double(Anew));
    title('Fourier transform of the image')
end