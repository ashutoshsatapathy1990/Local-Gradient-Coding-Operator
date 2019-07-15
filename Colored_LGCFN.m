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
    I = im2double(I);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ZERO PADDING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    I = padarray(I, [2,2], 0, 'both');
%%%%%%%%%%%%%%%%%%% EXTRACT CHANNELS FROM THE PRODUCED ONE %%%%%%%%%%%%%%%%%%%%
    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);
%%%%%%%%%%%%%%%%%%%%%%%% GET THE SIZE OF IMAGE CHANNEL %%%%%%%%%%%%%%%%%%%%%%%%
    [m,n]=size(R); 
%%%%%%%%%%%%%%%%%%%%%%%%%%% CREATE 2D ARRAYS OF ZERO %%%%%%%%%%%%%%%%%%%%%%%%%%
    RED=zeros(m-4,n-4);
    GREEN=zeros(m-4,n-4);
    BLUE=zeros(m-4,n-4);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LGCFN CALCULATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=3:m-2
        for j=3:n-2        
            if (R(i-2,j-2)-R(i-2,j+2)>=0); RH7=2^7; else; RH7=0; end
            if (G(i-2,j-2)-G(i-2,j+2)>=0); GH7=2^7; else; GH7=0; end
            if (B(i-2,j-2)-B(i-2,j+2)>=0); BH7=2^7; else; BH7=0; end
            if (R(i-1,j-1)-R(i-1, j+1)>=0); RH6=2^6; else; RH6=0; end
            if (G(i-1,j-1)-G(i-1, j+1)>=0); GH6=2^6; else; GH6=0; end
            if (B(i-1,j-1)-B(i-1, j+1)>=0); BH6=2^6; else; BH6=0; end
            if (R(i+1,j-1)-R(i+1,j+1)>=0); RH5=2^5; else; RH5=0; end
            if (G(i+1,j-1)-G(i+1,j+1)>=0); GH5=2^5; else; GH5=0; end
            if (B(i+1,j-1)-B(i+1,j+1)>=0); BH5=2^5; else; BH5=0; end
            if (R(i+2,j-2)-R(i+2,j+2)>=0); RH4=2^4; else; RH4=0; end
            if (G(i+2,j-2)-G(i+2,j+2)>=0); GH4=2^4; else; GH4=0; end
            if (B(i+2,j-2)-B(i+2,j+2)>=0); BH4=2^4; else; BH4=0; end
            if (R(i-2,j-2)-R(i+2,j+2)>=0); RH3=2^3; else; RH3=0; end
            if (G(i-2,j-2)-G(i+2,j+2)>=0); GH3=2^3; else; GH3=0; end
            if (B(i-2,j-2)-B(i+2,j+2)>=0); BH3=2^3; else; BH3=0; end
            if (R(i-1,j-1)-R(i+1,j+1)>=0); RH2=2^2; else; RH2=0; end
            if (G(i-1,j-1)-G(i+1,j+1)>=0); GH2=2^2; else; GH2=0; end
            if (B(i-1,j-1)-B(i+1,j+1)>=0); BH2=2^2; else; BH2=0; end
            if (R(i-2,j+2)-R(i+2,j-2)>=0); RH1=2^1; else; RH1=0; end
            if (G(i-2,j+2)-G(i+2,j-2)>=0); GH1=2^1; else; GH1=0; end
            if (B(i-2,j+2)-B(i+2,j-2)>=0); BH1=2^1; else; BH1=0; end
            if (R(i-1,j+1)-R(i+1,j-1)>=0); RH0=1; else; RH0=0; end
            if (G(i-1,j+1)-G(i+1,j-1)>=0); GH0=1; else; GH0=0; end
            if (B(i-1,j+1)-B(i+1,j-1)>=0); BH0=1; else; BH0=0; end
            RED(i-2,j-2) = RH7+RH6+RH5+RH4+RH3+RH2+RH1+RH0;
            GREEN(i-2,j-2) = GH7+GH6+GH5+GH4+GH3+GH2+GH1+GH0;
            BLUE(i-2,j-2) = BH7+BH6+BH5+BH4+BH3+BH2+BH1+BH0;
        end
    end
%%%%%%%%%%%%%%%%%%%%% CONVERT PIXELS FROM double to uint8 %%%%%%%%%%%%%%%%%%%%%%
    RED = uint8(RED); GREEN = uint8(GREEN); BLUE = uint8(BLUE);
%%%%%%%%%%%%%%%%%% JOIN ALL THREE CHANNELS TO GET FINAL ONE %%%%%%%%%%%%%%%%%%%%
    I = cat(3, RED, GREEN, BLUE);
%%%%%%%%%%%%%%%%%%%%%%%%% WRITE FINAL IMAGE TO A FILE %%%%%%%%%%%%%%%%%%%%%%%%%%
    imwrite(I, F);
end