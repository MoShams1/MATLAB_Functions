% plot_rows_colored v1.0
% 16-03-2021
% Mohammad Shams
% m.shamsahmar@gmail.com

% plot each row of a matrix with the graded colors between the two given colors

function plot_rows_colored(A,c1,c2)

nrows = size(A,1);

% create a color map out of the two input colors
column1 = linspace(c1(1),c2(1),nrows);
column2 = linspace(c1(2),c2(2),nrows);
column3 = linspace(c1(3),c2(3),nrows);
color_map = [column1', column2', column3'];

% an alternative way of creating the color map
% color_map = copper(nrows);

for irow = 1:nrows
    
    hold on
    plot(A(irow,:),'color',color_map(irow,:))    
    
end