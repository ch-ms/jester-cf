function [J grad] = costFunction(params, Y, R, num_users, num_jokes, num_features)

  [X, Theta] = unroll(params, num_jokes, num_users, num_features);

  % Cost
  J = calcCost(X, Theta, Y, R);


  % Grad
  X_grad = zeros(size(X));
  Theta_grad = zeros(size(Theta));

  for i = 1:size(X)(1)
    % Find users who rated that joke
    idx = find(R(i, :) == 1);
    % Choose thetas for that users
    Theta_temp = Theta(idx, :);
    % Choose ratings for that joke for that users
    Y_temp = Y(i, idx);

    X_grad(i, :) = (X(i, :) * Theta_temp' - Y_temp) * Theta_temp;
  endfor

  for j = 1:size(Theta)(1)
    % Find jokes which that user rated
    idx = find(R(:, j) == 1);
    % Choose X's for that jokes
    X_temp = X(idx, :);
    % Choose ratings for that jokes
    Y_temp = Y(idx, j);

    theta_mul = (X_temp * Theta(j, :)' - Y_temp) .* X_temp;

    if (size(theta_mul)(1) == 1)
      Theta_grad(j, :) = theta_mul;
    else
      Theta_grad(j, :) = sum(theta_mul);
    endif

  endfor

  grad = [X_grad(:); Theta_grad(:)];

end