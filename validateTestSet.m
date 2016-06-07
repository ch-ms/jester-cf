function [] = validateTestSet(Y, X, Theta, null_value)

  R = Y != null_value;
  n = length(find(R == 1));

  predictions = (X * Theta');
  error_rate = (predictions - Y) .* R;
  error_rate = 1/n * sum(abs(error_rate(:)));

  fprintf("Error rate on test set is %i.\n\n", error_rate);

end