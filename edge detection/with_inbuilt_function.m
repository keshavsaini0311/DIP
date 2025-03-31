% Clear workspace, close all figures, and clear command window
clear all; 
close all; 
clc;

% Read the input image from the given URL
I = imread('https://upload.wikimedia.org/wikipedia/en/7/7d/Lenna_%28test_image%29.png');

% Convert the RGB image to grayscale
I_gray = rgb2gray(I);

% Apply various edge detection techniques
BW1 = edge(I_gray, 'sobel');     % Sobel edge detection
BW2 = edge(I_gray, 'canny');     % Canny edge detection
BW3 = edge(I_gray, 'prewitt');   % Prewitt edge detection
BW4 = edge(I_gray, 'roberts');   % Roberts edge detection
BW5 = edge(I_gray, 'log');       % Laplacian of Gaussian (LoG) edge detection
BW6 = edge(I_gray, 'zerocross'); % Zero-crossing edge detection

% Create a 2-row, 4-column tiled layout for displaying images
tiledlayout(2,4);

% Display the original image
nexttile; 
imshow(I);
title('Original Image');

% Display the images obtained using different edge detection techniques
nexttile; 
imshow(BW1);
title('Sobel');

nexttile; 
imshow(BW2);
title('Canny');

nexttile; 
imshow(BW3);
title('Prewitt');

nexttile; 
imshow(BW4);
title('Roberts');

nexttile; 
imshow(BW5);
title('LoG');

nexttile; 
imshow(BW6);
title('Zero-Crossing');