function Zero(im)
    %zero out small co-efficients and inverse transform
    Ahat=fft2(im);
    [nx,ny]=size(im);
    count_pic=1;
    for thresh= .1*[0.001 0.005 0.01]* max(abs(Ahat(:)))
        ind=abs(Ahat)>thresh;
        AhatFilt=Ahat.*ind;
        count=nx*ny-sum(ind(:));
        percent=100-count/(nx*ny)*100;
        Afilt=ifft2(AhatFilt);
        figure(3),subplot(2,2,count_pic)
        imshow(uint8(Afilt));
        count_pic=count_pic+1;
        title([num2str(percent) '% of FFT basis'],'FontSize',14)
    end
end