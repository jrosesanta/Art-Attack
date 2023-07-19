% This program creates a beautiful, colorful art painting named "Art Attack"
% using the Matlab plotting capabilities

% Set up the figure
figure 
hold on

% Plot the first yellow circle in the top left corner
plot(0,6,'o','MarkerSize',8,'MarkerFaceColor','y','MarkerEdgeColor',[0.7 0.7 0.7]);

% Plot the second yellow circle in the top right corner
plot(6,6,'o','MarkerSize',8,'MarkerFaceColor','y','MarkerEdgeColor',[0.7 0.7 0.7]);

% Plot the third yellow circle in the bottom right corner
plot(6,0,'o','MarkerSize',8,'MarkerFaceColor','y','MarkerEdgeColor',[0.7 0.7 0.7]);

% Plot the fourth yellow circle in the bottom left corner
plot(0,0,'o','MarkerSize',8,'MarkerFaceColor','y','MarkerEdgeColor',[0.7 0.7 0.7]);

% Plot the red circle in the middle of the yellow circles
plot(3,3,'o','MarkerSize',8,'MarkerFaceColor','r','MarkerEdgeColor',[0.7 0.7 0.7]);

% Plot the one orange circle in the top center
plot(3,6,'o','MarkerSize',8,'MarkerFaceColor','orange','MarkerEdgeColor',[0.7 0.7 0.7]);

% Plot the one blue circle in the bottom center
plot(3,0,'o','MarkerSize',8,'MarkerFaceColor','b','MarkerEdgeColor',[0.7 0.7 0.7]);

% Plot the one green circle in the center right
plot(6,3,'o','MarkerSize',8,'MarkerFaceColor','g','MarkerEdgeColor',[0.7 0.7 0.7]);

% Plot the one pink circle in the center left
plot(0,3,'o','MarkerSize',8,'MarkerFaceColor','m','MarkerEdgeColor',[0.7 0.7 0.7]);

% Create the figure title
title('Art Attack');

% Add the legend
legend('Top Left','Top Right','Bottom Right','Bottom Left','Center','Top Center','Bottom Center','Right Center','Left Center');

% Change the axes
axis([-1 7 -1 7]);

% Set the background color
set(gcf,'Color','w');


% Plot the first orange line
plot([3 3],[3 6],'LineWidth',3,'Color','orange');

% Plot the second orange line
plot([3 6],[6 6],'LineWidth',3,'Color','orange');

% Plot the third orange line
plot([6 6],[6 3],'LineWidth',3,'Color','orange');

% Plot the fourth orange line
plot([6 3],[3 3],'LineWidth',3,'Color','orange');

% Plot the first blue line
plot([3 0],[3 3],'LineWidth',3,'Color','b');

% Plot the second blue line
plot([0 0],[3 0],'LineWidth',3,'Color','b');

% Plot the third blue line
plot([0 3],[0 0],'LineWidth',3,'Color','b');

% Plot the fourth blue line
plot([3 3],[0 3],'LineWidth',3,'Color','b');

% Plot the first green line
plot([3 6],[3 3],'LineWidth',3,'Color','g');

% Plot the second green line
plot([6 6],[3 6],'LineWidth',3,'Color','g');

% Plot the third green line
plot([6 3],[6 6],'LineWidth',3,'Color','g');

% Plot the fourth green line
plot([3 3],[6 3],'LineWidth',3,'Color','g');

% Plot the first pink line
plot([0 3],[3 3],'LineWidth',3,'Color','m');

% Plot the second pink line
plot([3 3],[3 0],'LineWidth',3,'Color','m');

% Plot the third pink line
plot([3 0],[0 0],'LineWidth',3,'Color','m');

% Plot the fourth pink line
plot([0 0],[0 3],'LineWidth',3,'Color','m');

% Turn off the axis lines
axis off

% Set the aspect ratio
axis equal

% Make sure the plot is visible
hold off

% Create a custom colormap
cmap=[255 255 0;
    255 0 0;
    255 165 0;
    0 0 255;
    0 255 0;
    255 0 255];

% Set the colormap
colormap(cmap)