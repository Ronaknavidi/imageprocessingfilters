% پاک‌سازی حافظه و بستن تمامی شکل‌ها
clear;
close all;

% بارگذاری تصویر
original_image = imread('cam.jpg');

% تبدیل تصویر به سیاه و سفید
gray_image = rgb2gray(original_image);

% کاهش اندازه تصویر برای جلوگیری از خطا
gray_image_resized = imresize(gray_image, 0.5);

% اضافه کردن نویز فلفل نمکی با مقدار کم
noisy_image = imnoise(gray_image_resized, 'salt & pepper', 0.02);

% نمایش تصویر خاکستری و تصویر نویزدار در کنار هم
figure;

subplot(1, 2, 1);
imagesc(gray_image_resized);
colormap gray;
axis image off;
title('Grayscale Image (Resized)');

subplot(1, 2, 2);
imagesc(noisy_image);
colormap gray;
axis image off;
title('Image with Salt & Pepper Noise (Low Amount, Resized)');
