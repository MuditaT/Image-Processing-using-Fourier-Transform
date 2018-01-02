function Edge_ori = EdgeDetect(im)
    im = double(im(:,:,1));
    %J=imadjust(I,[0.1 0.9],[0 1],1);
    % canny
    Img=edge(im,'canny');
    Edge_ori=Img;
    figure
    subplot(2,2,1);
    imshow(Edge_ori)
    ind=2;
    for i= 0.1:0.1:0.3
        [CR,BPP] = wcompress('c',im,'plane.wtc','gbl_mmc_h','bpp',i);
        Xc = wcompress('u','plane.wtc');
        delete('plane.wtc')
        BW1 = edge(Xc,'canny');
        subplot(2,2,10*i+1)
        ind=ind+1;
        imshow(BW1);
          xlabel({['Cpmressed Ratio: ' num2str(CR,'%1.2f %%')], ...
       ['BPP: ' num2str(BPP,'%3.2f')]})
    end
end