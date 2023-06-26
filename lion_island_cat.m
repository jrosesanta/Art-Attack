A = imread('Art Attack.jpg'); %import 'Art Attack' image
specialA = imadjust(A); %adjust brightness and contrast
figure;
imshow(specialA);
title('Adjusted Image');

B = rgb2gray(specialA); %convert to grayscale
figure;
imshow(B);
title('Grayscale Image');

C = edge(B,'Canny'); %apply Canny edge detection
figure;
imshow(C);
title('Canny Edge Image');

D = bwmorph(C,'bridge'); %apply bridge morphological functions
figure;
imshow(D);
title('Bridge Morphology');

E = imfill(D,'holes'); %fill holes
figure;
imshow(E);
title('Filled Image');

F = bwmorph(E,'remove'); %apply remove morphological functions 
figure;
imshow(F);
title('Remove Morphology');

G = bwperim(F); %create perimeter around objects
figure;
imshow(G);
title('Perimeter Image');

H = imdilate(G,ones(5,5)); %dilate perimeter image
figure;
imshow(H);
title('Dilated Image');

I = imclose(A,H); %apply morphological closing 
figure;
imshow(I);
title('Closing Image');

J = imfill(I,'holes'); %fill holes for final image
figure;
imshow(J);
title('Final Image');