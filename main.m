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

null_value = 99;
jesterData1 = jesterData1';

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
Y = data;
R = Y != null_value;

if (exist("learned.mat", "file") == 0)
  X = randn(num_jokes, num_features);
  Theta = randn(num_users, num_features);
else
  load learned.mat
  X = learned_X;
  Theta = learned_Theta;
endif

[J, X, Theta] = learn(X, Theta, Y, R, num_users, num_jokes, num_features);

J = calcCost(X, Theta, Y, R);
fprintf("Learned, cost=%i.\n\n", J);


% Validation
disp("Validation.");

% Max diff
predictions = (X * Theta' - Y) .* R;
predictions = predictions(find(predictions != 0));
predictions = abs(predictions / 20);
max_diff = max(predictions(:));
mean_diff = 1/length(predictions(:)) * sum(predictions(:));
min_diff = min(predictions(:));

fprintf("Max/min/mean diff %i %i %i.\n", max_diff, min_diff, mean_diff);
disp("Press any key to continue");
pause;

% Select random user
user_id = round(rand() * num_users - 1) + 1;
user_ratings = Y(:, user_id);
user_rated_ids = find(user_ratings != null_value);
user_rated = user_ratings(user_rated_ids);
user_predictions = X * Theta(user_id, :)';
user_predictions = user_predictions(user_rated_ids);
user_predictions = round(user_predictions);
diff = user_rated - user_predictions;
diff_p = abs(diff / 20);
max_diff_p = max(diff_p);

fprintf("User is %i.\n\n", user_id);
fprintf("Predictions:\n");

disp("R/P/D/Dp");
for i = 1:length(user_rated)
  fprintf("%i %i %i %i\n", user_rated(i), ...
    user_predictions(i), diff(i), diff_p(i));
endfor

fprintf("\nMax diff is %i.\n\n", max_diff_p);


% Predictions



