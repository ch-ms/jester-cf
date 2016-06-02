function J = calcCost(X, Theta, Y, R)

  J = X * Theta' - Y;
  J = J .^ 2;
  J = J .* R;
  J = sum(J(:));
  J = 1/2 * J;

end