function MountainAfterFilter(im)
    Ahat=fft2(im);
    for thresh= .1*[0.001 0.005 0.01]* max(abs(Ahat(:)))
        ind=abs(Ahat)>thresh;
        AhatFilt=Ahat.*ind;
        Afilt=ifft2(AhatFilt);
    end
    figure
    Anew=imresize(Afilt,.1);
    surf(double(Anew));
    title('filtered image')
end