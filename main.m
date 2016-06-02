%
% Collaborative filtering for jester dataset
% author: Evgeniy Kuznetsov
%

% Load
disp("Load data");

loadData();

load ./jester-11.mat;

fprintf("Loaded %i users with %i reviews\n\n", size(jesterData1));


% Process
disp("Process data");

disp("Before:");
disp(jesterData1(1:5, 1:5));

data = processData(jesterData1);

disp("After:");
disp(data(1:5,1:5));


% Learn
disp("Learning");

num_features = 10;
num_users = size(data)(2);
num_jokes = size(data)(1);
X = randn(num_jokes, num_features);
Theta = randn(num_users, num_features);
Y = data;
R = Y != 0;

[J, X, Theta] = learn(X, Theta, Y, R, num_users, num_jokes, num_features);

J = calcCost(X, Theta, Y, R);
fprintf("Learned, cost=%i.\n\n", J);
