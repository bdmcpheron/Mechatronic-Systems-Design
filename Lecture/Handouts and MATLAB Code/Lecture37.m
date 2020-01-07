close all
clear all
clc

% hough lines example       
I  = imread('hallexample.png');
grayI=rgb2gray(I); % set image to grayscale
figure; imshow(grayI)
% detect edgels
BW = edge(grayI,'canny',0.3); % set threshold at 0.3
figure; imshow(BW)
% hough transform
[H,T,R] = hough(BW);
figure;
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
colormap('hot')
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;

% find the peaks of the hough transform
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2)); 
y = R(P(:,1));
plot(x,y,'s','color','white');
 
% Find lines and plot them
lines = houghlines(BW,T,R,P,'FillGap',20,'MinLength',10);
figure, imshow(grayI), hold on
max_len = 0;
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
 
    % plot beginnings and ends of lines
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
         plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
 
    % determine the endpoints of the longest line segment 
    len = norm(lines(k).point1 - lines(k).point2);
    if ( len > max_len)
       max_len = len;
       xy_long = xy;
    end
end
 
% highlight the longest line segment
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');
 