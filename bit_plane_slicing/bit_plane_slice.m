% Created by Keshav Saini
% Bit Plane Slicing

% Read the image
img = imread('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQN2ko9LJLTbaPrcncnhZFDsvJh4D4Zz4mGwA&s');

% Convert the image to grayscale if it's not already
if size(img, 3) == 3
    img = rgb2gray(img);
end

% Get the size of the image
[rows, cols] = size(img);

% Initialize the output image
output_img = zeros(rows, cols, 'uint8');

% Loop through each bit plane
for bit = 1:8
    % Extract the bit plane
    bit_plane = bitget(img, bit);
    
    % Remove the LSB (bit 1)
    if bit > 1
        output_img = output_img + uint8(bit_plane * 2^(bit-1));
    end
end

% Display the original and processed images
figure;
subplot(1, 2, 1);
imshow(img);
title('Original Image');

subplot(1, 2, 2);
imshow(output_img);
title('Image with LSB Removed');