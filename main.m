%
% Collaborative filtering for jester dataset
% author: Evgeniy Kuznetsov
%

disp("Load data");

loadData();

load ./jester-11.mat;

fprintf("Loaded %i users with %i reviews\n\n", size(jesterData1));

disp("Process data");

disp("Before:");
disp(jesterData1(1:5, 1:5));

data = processData(jesterData1);

disp("After:");
disp(data(1:5,1:5));

