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

% تعریف اندازه‌ها و نوع پنجره‌های مختلف
window_sizes = [3, 5, 7, 9, 11, 15];
window_types = {'average', 'disk', 'gaussian', 'average', 'disk', 'gaussian'};

% نمایش تصاویر فیلترشده
figure;
for i = 1:length(window_sizes)
    % انتخاب نوع و اندازه فیلتر
    window_size = window_sizes(i);
    window_type = window_types{i};
    
    % ایجاد فیلتر میانگین‌گیر با نوع و اندازه مشخص
    switch window_type
        case 'average'
            h = fspecial('average', [window_size window_size]);
        case 'disk'
            h = fspecial('disk', window_size);  % تغییر این خط برای اندازه صحیح
        case 'gaussian'
            h = fspecial('gaussian', [window_size window_size], window_size / 6);
    end
    
    % اعمال فیلتر روی تصویر نویزدار
    filtered_image = imfilter(noisy_image, h, 'symmetric');
    
    % نمایش تصویر فیلتر شده
    subplot(2, 3, i);
    imshow(filtered_image, []);
    title([window_type, ' - ', num2str(window_size), 'x', num2str(window_size)]);
end

