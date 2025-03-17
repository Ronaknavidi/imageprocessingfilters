% پاک‌سازی حافظه و بستن تمامی شکل‌ها
clear;
close all;

% بارگذاری تصویر
original_image = imread('cam.jpg');

% تبدیل تصویر به سیاه و سفید
gray_image = rgb2gray(original_image);

% کاهش اندازه تصویر برای جلوگیری از مشکلات حافظه
gray_image_resized = imresize(gray_image, 0.5);

% اضافه کردن نویز فلفل نمکی با مقدار کم
noisy_image = imnoise(gray_image_resized, 'salt & pepper', 0.02);

% تبدیل تصویر به حوزه فرکانس
F_noisy_image = fft2(double(noisy_image));
F_noisy_image_shifted = fftshift(F_noisy_image);

% مقادیر فرکانس قطع جدید
cutoff_frequencies = [100, 150, 200];

% ابعاد تصویر
[m, n] = size(noisy_image);
[u, v] = meshgrid(-floor(n/2):floor((n-1)/2), -floor(m/2):floor((m-1)/2));

% نمایش تصاویر فیلترشده
figure;
for i = 1:length(cutoff_frequencies)
    % ایجاد فیلتر پایین‌گذر ایده‌آل
    D = sqrt(u.^2 + v.^2);
    H = double(D <= cutoff_frequencies(i));
    
    % اعمال فیلتر روی تصویر در حوزه فرکانس
    F_filtered = F_noisy_image_shifted .* H;
    
    % تبدیل معکوس فوریه برای بازگشت به حوزه مکان
    F_filtered_shifted = ifftshift(F_filtered);
    filtered_image = ifft2(F_filtered_shifted);
    filtered_image = abs(filtered_image); % گرفتن مقدار مطلق برای تصویر واقعی
    
    % نمایش تصویر
    subplot(1, 3, i);
    imshow(filtered_image, []);
    title(['Cutoff Frequency: ', num2str(cutoff_frequencies(i))]);
end
