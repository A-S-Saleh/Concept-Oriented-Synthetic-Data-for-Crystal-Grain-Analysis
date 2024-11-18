% Initialization
clear,clc,close all;

% Error convergance criteria
Er_conv = 0.003; 

% Load trained NETs
load('net1.mat');
load('net2.mat');
InSiz = net.Layers(1).InputSize(1:2);

% load input image
img = imread('TEM.png');

% Put image in correct size and format
if size(img,1)<50,img = imresize(img,2);end
Siz = size(img(:,:,1));
k = imresize(img,InSiz);
if size(k,3)>1,k = rgb2gray(k);end
lowhigh = stretchlim(k); k1 = imadjust(k,lowhigh); k1 = medfilt2(k1,[7,7],"symmetric");
figure(); imshow(k); title('Input Image (resized)'); drawnow;

% Use filters to get edges
E1 = 255*uint8(edge(k1,'Sobel'));
figure(); imshow(cat(3,E1,zeros(size(E1)),zeros(size(E1)))); title('Sobel edge detector');
E2 = 255*uint8(edge(k1,'log'));
figure(); imshow(cat(3,zeros(size(E2)),E2,zeros(size(E2)))); title('LoG edge detector');
E3 = 255*uint8(edge(k1,'Canny'));
figure(); imshow(cat(3,zeros(size(E3)),zeros(size(E3)),E3)); title('Canny edge detector');

% Use edges to get initial guess
k1 = cat(3,E1,E2,E3);
figure(); imshow(k1); title('Detected edges'); drawnow;
k1 = uint8(predict(net,k1));
figure(); imshow(k1); title('Initial guess'); drawnow;

% Use diffusion model for grain boudaries prediction
k2 = k1; Er = inf; n = 0;
Er_conv = Er_conv*numel(k2)*255; % Error convergance
while Er > Er_conv
    k2old = k2; n = n + 1;
    k2 = uint8(predict(net2,k2)*255);
    Er = sum(sum(abs(k2 - k2old))); 
end
k2 = k2 > 0.2*255; k2 = imdilate(k2,strel("disk",2)); 
k2 = imerode(k2,strel("disk",2));
BW_gb = imfill(~imresize(k2,Siz),'holes');

% Show final output
CmpImgTEM(img,~BW_gb,[],1);


function res = CmpImgTEM(img,BW_gb,path,PLOT)

if size(img,3)<3, img = cat(3,img(:,:,1),img(:,:,1),img(:,:,1)); end
kr = img(:,:,1); kr(BW_gb) = 255;
kg = img(:,:,2); kg(BW_gb) = 0;
kb = img(:,:,3); kb(BW_gb) = 0;
res = cat(3,kr,kg,kb);
if PLOT
    figure,imshow(res,[])
end

if~isempty(path)
    imwrite(res,[path,'\compare.png'])
end

end
