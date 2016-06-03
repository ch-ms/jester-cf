function [J grad] = costFunction(params, Y, R, num_users, num_jokes, num_features)

  [X, Theta] = unroll(params, num_jokes, num_users, num_features);

  % Cost
  J = calcCost(X, Theta, Y, R);


  % Grad
  X_grad = ((X*Theta' - Y) .* R) * Theta;
  Theta_grad = ((X*Theta' - Y) .* R)' * X;

  grad = [X_grad(:); Theta_grad(:)];

end