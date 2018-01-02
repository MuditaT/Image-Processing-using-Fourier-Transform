function Decompress(img, radius)
    %Initilization
    I_ori=img;
    imwrite(I_ori,'original.jpg')
    I=im2double(I_ori);
    %Blurring operation
    blur_filter=fspecial('disk',radius);
    I_blurred=imfilter(I,blur_filter,'conv');
    figure
    subplot(1,3,1)
    imshow(I_blurred)
    imwrite(im2uint8(I_blurred),'blur.jpg')
    infoblur=imfinfo('blur.jpg');
    blursize=infoblur.FileSize/1024;
    title('Blurred image')
    xlabel({['File Size: ' num2str(blursize,'%1.2f') 'KB']})
    for i=1
        % Compress
        [CR_,BPP_] = wcompress('c',I,'mask_.wtc','gbl_mmc_h','bpp',i);
        [CR,BPP] = wcompress('c',I_blurred,'mask.wtc','gbl_mmc_h','bpp',i);
        % Decompress
        Xc_ = wcompress('u','mask_.wtc');
        Xc = wcompress('u','mask.wtc');
        subplot(1,3,2)
        imshow(Xc_);
        imwrite(im2uint8(Xc_),'decompressNoBlur.jpg')
        infoxc_=imfinfo('decompressNoBlur.jpg');
        xc_size=infoxc_.FileSize/1024;
        axis square;
        title('Compressed Image without blurring')
        xlabel({['Compressed Ratio: ' num2str(CR,'%1.2f %%')], ...
            ['BPP: ' num2str(BPP,'%3.2f')], ...
            ['File Size: ' num2str(xc_size,'%1.2f') 'KB']})
        subplot(1,3,3)
        imshow(Xc);
        imwrite(im2uint8(Xc),'decompressWithBlur.jpg')
        infoxc=imfinfo('decompressWithBlur.jpg');
        xcsize=infoxc.FileSize/1024;
        axis square;
        title('Compressed Image after blurring')
        xlabel({['Compressed Ratio: ' num2str(CR_,'%1.2f %%')], ...
            ['BPP: ' num2str(BPP_,'%3.2f')], ...
            ['File Size: ' num2str(xcsize,'%1.2f') 'KB']})
    end
end


