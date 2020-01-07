close all
clear all
clc

for k = 1:15
    
    imname = ['IMG',num2str(k),'.jpeg']; % create a string of filenames

    im1 = imresize(imread(imname),0.3); % resize and read (0.3 scale)
    im1 = imrotate(im1,-90); % rotate the image -90 degrees
    im1 = im2bw(imcomplement(rgb2gray(im1))); % change from a light/dark
    % to a dark/light, and convert to black and white

    BW = edge(im1,'canny',0.2); % set threshold at 0.2.

    % take hough transform and get peaks
    [H,T,R] = hough(BW);
    P  = houghpeaks(H,10);
    x = T(P(:,2)); 
    y = R(P(:,1));

    % Find lines
    lines = houghlines(BW,T,R,P);
    
    figure(1)
    clf % clear the figure
    imshow(im1)
    hold on
    max_len = 0;
    for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];
        plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');

        % plot beginnings and ends of lines
        plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
             plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','blue');

        % determine the endpoints of the longest line segment 
        len = norm(lines(k).point1 - lines(k).point2);
        if ( len > max_len)
           max_len = len;
           xy_long = xy;
        end
    end

    % highlight the longest line segment
    plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','green');
    pause(0.5) % so you can see what's happening
   
end