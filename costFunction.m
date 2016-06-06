function [J grad] = costFunction(params, Y, R, num_users, num_jokes, num_features, lambda)

  [X, Theta] = unroll(params, num_jokes, num_users, num_features);

  % Cost
  J = calcCost(X, Theta, Y, R, lambda);

  % Grad
  X_grad = ((X*Theta' - Y) .* R) * Theta;
  Theta_grad = ((X*Theta' - Y) .* R)' * X;

  X_grad += lambda * X;
  Theta_grad += lambda * Theta;

  grad = [X_grad(:); Theta_grad(:)];

end