function [train test] = splitData(data, ratio, null_value)

  train = data;
  test  = ones(size(data)) * null_value;

  for i = 1:size(data)(2)

    user_ratings = data(:, i);
    rated = find(user_ratings != null_value);
    withdraw_count = round(length(rated) * ratio);
    withdraw_idx = rated(randperm(size(rated)))(1:withdraw_count);

    test(withdraw_idx, i)  = data(withdraw_idx, i);
    train(withdraw_idx, i) = null_value;

  endfor

end