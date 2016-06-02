function [J, X, Theta] = learn(X, Theta, Y, R, num_users, num_jokes, num_features)

  init_params = [X(:); Theta(:)];

  opts = optimset('MaxIter', 40);

  costfn = @(t)(costFunction(t, Y, R, num_users, num_jokes, num_features));

  learned_params = fmincg(costfn, init_params, opts);

  [X Theta] = unroll(learned_params, num_jokes, num_users, num_features);

  J = calcCost(X, Theta, Y, R);

end