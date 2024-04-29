% Generate sample data (replace this with your actual array)
data = rand(1000, 1); % Generating 1000 random values between 0 and 1

% Define the edges for the histogram bins
edges = 0:0.2:1; % Bins of width 0.2, from 0 to 1

% Plot the histogram with percentage as the y-axis
histogram(data, edges, 'Normalization', 'probability')

% Set labels and title
xlabel('Value')
ylabel('Percentage of Occurrence')
title('Distribution of Values between 0 and 1')

% Show grid
grid on
