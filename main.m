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


% Split
disp("Split data");

if (exist("jester-11-splitted.mat", "file") == 0)
  [data_train data_test] = splitData(data, .1, null_value);

  save -binary jester-11-splitted.mat data_train data_test
  disp("Splitted");
else
  load jester-11-splitted.mat
  disp("jester-11-splitted.mat exists, using it's data.");
endif

num_exmpl_original = length(find(data != null_value));
num_exmpl_train = length(find(data_train != null_value));
num_exmpl_test = length(find(data_test != null_value));

fprintf("Original/train/test %i %i %i\n\n", num_exmpl_original, ...
  num_exmpl_train, num_exmpl_test);

anykey();


% Learn
disp("Learning");

num_features = 100;
num_users = size(data_train)(2);
num_jokes = size(data_train)(1);
Y = data_train;
R = Y != null_value;
num_examples = length(find(R == 1));

fprintf("Learning on %i examples.\n\n", num_examples);

if (exist("learned.mat", "file") == 0)
  X = randn(num_jokes, num_features);
  Theta = randn(num_users, num_features);
else
  load learned.mat
  X = learned_X;
  Theta = learned_Theta;
endif

lambda = 1/2;

[J, X, Theta] = learn(X, Theta, Y, R, num_users, num_jokes, num_features, lambda);

J = calcCost(X, Theta, Y, R, lambda);
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
anykey();

validateTestSet(data_train, X, Theta, null_value);
anykey();


% Predictions
user_id = round(rand() * num_users - 1) + 1;
user_ratings = data(:, user_id);

fprintf("Recommendations for %i user:\n\n", user_id);
fprintf("Joke id, predicted rating\n");
[recs vals] = recommendTopN(user_ratings != null_value, X, Theta(user_id, :), 10);
disp([recs vals]);

anykey();



