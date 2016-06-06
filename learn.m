function [J, learned_X, learned_Theta] = learn(X, Theta, Y, R, num_users, num_jokes, num_features, lambda)

  init_params = [X(:); Theta(:)];

  opts = optimset('MaxIter', 400);

  costfn = @(t)(costFunction(t, Y, R, num_users, num_jokes, num_features, lambda));

  learned_params = fmincg(costfn, init_params, opts);

  [learned_X learned_Theta] = unroll(learned_params, num_jokes, num_users, num_features);

  J = calcCost(learned_X, learned_Theta, Y, R, lambda);

  save -binary learned.mat learned_X learned_Theta

end