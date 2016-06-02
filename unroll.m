function [X, Theta] = unroll(params, num_x, num_theta, num_features)

  X = reshape(params(1:(num_x * num_features)), num_x, num_features);
  Theta = reshape(params((num_x * num_features + 1):end), num_theta, num_features);

end