% Created by Keshav Saini

% Define the image URL (replace with the desired image URL)
url = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQN2ko9LJLTbaPrcncnhZFDsvJh4D4Zz4mGwA&s';
% Read the image from the internet
img = imread(url);
% Convert the image to grayscale (if it's RGB)
if size(img, 3) == 3
 img = rgb2gray(img);
end
% Get the size of the image
[rows, cols] = size(img);
% Initialize reconstruction
reconstructed_img = zeros(rows, cols, 'uint8');
% Create a figure to display all results
figure;
% Display the original image
subplot(3, 4, 1);
imshow(img);
title('Original Image');
% Perform Bit Plane Slicing and Reconstruction
for k = 0:7
 % Extract the k-th bit plane
 bit_plane = bitget(img, k+1);
 % Scale to full intensity for visualization
 bit_plane_image = uint8(bit_plane * 255);
 % Add the weighted contribution to reconstruct the image
 reconstructed_img = reconstructed_img + uint8(bit_plane * 2^k);
 % Display the k-th bit plane
 subplot(3, 4, k+2);
 imshow(bit_plane_image);
 title(['Bit Plane ', num2str(k)]);
end
% Display the reconstructed image
subplot(3, 4, 10);
imshow(reconstructed_img);
title('Reconstructed Image');
% Add a super title
sgtitle('Original Image, Bit Planes, and Reconstructed Image');
