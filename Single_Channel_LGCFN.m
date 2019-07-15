%%%%%%%%%%%%%%%%%%%%%%%%%% READ THE FOLDER PATH %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dir = 'Image';
%%%%%%%%%%%%%%%%%%%% LIST ALL IMAGES IN THE FOLDER %%%%%%%%%%%%%%%%%%%%%%%%%%%%
S = dir(fullfile(Dir, '*.jpg'));
for K = 1:numel(S)
    F = fullfile(Dir, S(K).name);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% READ AN IMAGE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    I = imread(F);
%%%%%%%%%%%%%%%%%%%%%%%%% RESIZE IMAGE [300 x 300] %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    I = imresize(I, [300, 300]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RGB TO GRAY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    I = im2double(rgb2gray(I));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ZERO PADDING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    I = padarray(I, [2,2], 0, 'both');
%%%%%%%%%%%%%%%%%%%%%%%% GET THE SIZE OF IMAGE CHANNEL %%%%%%%%%%%%%%%%%%%%%%%%
    [m,n] = size(I);
%%%%%%%%%%%%%%%%%%%%%%%%%% 2D ZERO ARRAY [300 x 300] %%%%%%%%%%%%%%%%%%%%%%%%%%
    GRAY = zeros(m-4,n-4);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LGCFN CALCULATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=3:m-2
        for j=3:n-2        
            if (I(i-2,j-2)-I(i-2,j+2)>=0); H7=2^7; else; H7=0; end       
            if (I(i-1,j-1)-I(i-1, j+1)>=0); H6=2^6; else; H6=0; end
            if (I(i+1,j-1)-I(i+1,j+1)>=0); H5=2^5; else; H5=0; end
            if (I(i+2,j-2)-I(i+2,j+2)>=0); H4=2^4; else; H4=0; end
            if (I(i-2,j-2)-I(i+2,j+2)>=0); H3=2^3; else; H3=0; end
            if (I(i-1,j-1)-I(i+1,j+1)>=0); H2=2^2; else; H2=0; end
            if (I(i-2,j+2)-I(i+2,j-2)>=0); H1=2^1; else; H1=0; end
            if (I(i-1,j+1)-I(i+1,j-1)>=0); H0=1; else; H0=0; end
            GRAY(i-2,j-2) = H7+H6+H5+H4+H3+H2+H1+H0;
        end
    end
%%%%%%%%%%%%%%%%%%%%% CONVERT PIXELS FROM double to uint8 %%%%%%%%%%%%%%%%%%%%%%
    GRAY = uint8(GRAY);
%%%%%%%%%%%%%%%%%%%%%%%%% WRITE FINAL IMAGE TO A FILE %%%%%%%%%%%%%%%%%%%%%%%%%%
imwrite(GRAY, F);
end