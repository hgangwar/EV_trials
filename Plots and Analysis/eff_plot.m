close all
Data2 = load("eff_map.mat");
torque = Data2.torque;
speed = Data2.speed;
eff = Data2.eff;
% Define the function you want to plot
[x, y] = meshgrid(torque,speed); % Create a grid of x and y values

% Plot the contour plot
figure
surf(x,y,eff);

% Reverse y-axis
set(gca, 'YDir', 'reverse');

% Label axes and add title
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
title('Surf Plot: Cubic Interpolation Over Finer Grid');