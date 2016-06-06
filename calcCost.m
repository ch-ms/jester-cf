function J = calcCost(X, Theta, Y, R, lambda)

  J = X * Theta' - Y;
  J = J .^ 2;
  J = J .* R;
  J = sum(J(:));
  J = 1/2 * J;
  J += lambda/2 * sum(sum(Theta .^ 2));
  J += lambda/2 * sum(sum(X .^ 2));

end