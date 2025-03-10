clc; clear; close all;

img = imread('lena.png'); % Read the input image

% Convert to grayscale if the image is RGB
if size(img,3) == 3
    img = rgb2gray(img);
end

% Create an empty watermark image of the same size as the original image
watermark = zeros(size(img));

% Display the watermark image and add text to it
figure; imshow(watermark, []); hold on;
text(size(img,2)/2, size(img,1)/2, 'KSV', 'FontSize', 50, 'Color', 'white', ...
    'FontWeight', 'bold', 'HorizontalAlignment', 'center');

% Capture the frame and convert it to an image
frame = getframe(gca);
watermark = frame2im(frame);
watermark = rgb2gray(watermark); % Convert the watermark to grayscale

% Resize the watermark to half the size of the original image
watermark = imresize(watermark, size(img) / 2);
close; % Close the figure

% Perform Discrete Wavelet Transform (DWT) using the Haar wavelet
[LL, LH, HL, HH] = dwt2(double(img), 'haar');

% Embedding the watermark in the HH sub-band using a scaling factor
alpha = 0.1; % Strength of the watermark
HH_watermarked = HH + alpha * double(watermark);

% Perform inverse DWT to obtain the watermarked image
img_watermarked = idwt2(LL, LH, HL, HH_watermarked, 'haar');
img_watermarked = uint8(img_watermarked); % Convert back to uint8 format

% Save the watermarked image
imwrite(img_watermarked, 'text_watermarked_image.png');

% Display original, watermarked, and watermark images
figure;
subplot(1,3,1); imshow(img); title('Original Image');
subplot(1,3,2); imshow(img_watermarked); title('Watermarked Image');
subplot(1,3,3); imshow(watermark, []); title('Text Watermark');

% Extract watermark: Apply DWT to the watermarked image
[LL2, LH2, HL2, HH2] = dwt2(double(img_watermarked), 'haar');

% Remove the watermark from HH sub-band
HH2_cleaned = HH2 - alpha * double(watermark);

% Perform inverse DWT to reconstruct the cleaned image
img_cleaned = idwt2(LL2, LH2, HL2, HH2_cleaned, 'haar');
img_cleaned = uint8(img_cleaned); % Convert back to uint8 format

% Save the image after watermark removal
imwrite(img_cleaned, 'text_watermark_removed.png');

% Display watermarked image, HH after removal, and cleaned image
figure;
subplot(1,3,1); imshow(img_watermarked); title('Watermarked Image');
subplot(1,3,2); imshow(HH2_cleaned, []); title('HH after Removal');
subplot(1,3,3); imshow(img_cleaned); title('Watermark Removed');
