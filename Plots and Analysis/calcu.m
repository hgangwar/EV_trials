close all
score=[];
for i=1:10
    score=[score; str2double(scores(i))];
end 
score=sort(score);
plot(score)

score = [];
for i = 1:10
    score = [score; str2double(scores{i})];
end 

score = sort(score);

% Plot the data
plot(score, 'o-', 'LineWidth', 1.5, 'MarkerSize', 8, 'MarkerFaceColor', 'red', 'MarkerEdgeColor', 'blue');

% Set axis labels and title
xlabel('Experiments');
ylabel('SOC Savings');
title('Perforance');

% Adjust plot appearance
grid on;
xlim([0.5, 10.5]); % Adjust x-axis limits to center data points
ylim([min(score) - 0.1, max(score) + 0.1]); % Add padding to y-axis limits
xticks(1:10); % Set x-axis ticks to correspond with data points
yticks(min(score):0.5:max(score)); % Adjust y-axis ticks
set(gca, 'FontSize', 12); % Adjust font size

% Show plot