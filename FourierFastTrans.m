function FourierFastTrans(im)
    disp('Doing FFT analysis for sparsity check')
    Ahat=fft2(im);
    S = abs(Ahat);
    figure;
    subplot(2,1,1)
    imshow(S,[]);
    title(' Magnitude Fourier transform of an image');
    Y=angle(Ahat);
    subplot(2,1,2)
    imshow(Y,[]);
    title('Phase Fourier transform of image');
    Fsh = fftshift(Ahat);
    figure;
    subplot(2,1,1)
    imshow(abs(Fsh),[]);
    title('Centered fourier transform of Image')
    F=log(abs(Fsh)+1);
    F=mat2gray(F);
    subplot(2,1,2)
    imshow(F,[]);
    title('Log Transformed Image')
end