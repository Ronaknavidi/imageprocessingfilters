% پاک‌سازی حافظه و بستن تمامی شکل‌ها
clear;
close all;

% بارگذاری تصویر
original_image = imread('cam.jpg');

% تبدیل تصویر به سیاه و سفید
gray_image = rgb2gray(original_image);

% کاهش اندازه تصویر برای جلوگیری از مشکلات حافظه
gray_image_resized = imresize(gray_image, 0.3); % کاهش بیشتر اندازه تصویر

% اضافه کردن نویز فلفل نمکی با مقدار کم
noisy_image = imnoise(gray_image_resized, 'salt & pepper', 0.02);

% تبدیل فوریه تصویر به حوزه فرکانس
F = fft2(double(noisy_image));
F_shifted = fftshift(F); % جابجایی صفر به وسط تصویر

% تعریف مقادیر مختلف فرکانس قطع
cutoff_frequencies = [10, 20, 30, 40, 50]; % مقادیر مختلف شعاع فیلتر بالاگذر

% نمایش تصاویر فیلتر شده بالاگذر
figure;
for i = 1:length(cutoff_frequencies)
    % شعاع فیلتر بالاگذر
    radius = cutoff_frequencies(i);
    
    % ایجاد فیلتر بالاگذر در حوزه فرکانس
    [M, N] = size(noisy_image);
    [x, y] = meshgrid(1:N, 1:M);
    center_x = floor(N/2);
    center_y = floor(M/2);
    
    % طراحی فیلتر بالاگذر (High-pass filter)
    H = sqrt((x - center_x).^2 + (y - center_y).^2) > radius; % نقاط دورتر از مرکز باقی می‌مانند
    
    % اعمال فیلتر بالاگذر در حوزه فرکانس
    F_filtered = F_shifted .* H;
    
    % تبدیل معکوس فوریه برای بازسازی تصویر
    filtered_image = ifft2(ifftshift(F_filtered));
    filtered_image = abs(filtered_image); % تبدیل به مقادیر مثبت
    
    % نمایش تصویر فیلتر شده بالاگذر با استفاده از imagesc
    subplot(2, 3, i);
    imagesc(filtered_image);
    axis off; % حذف محورهای شکل
    colormap gray; % استفاده از رنگ خاکستری
    colorbar; % افزودن نوار رنگ
    title(['Cutoff = ', num2str(radius)]);
end
