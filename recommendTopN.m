function [recs vals] = recommendTopN(R, X, Theta, n)

  predictions = X * Theta' .* (R != 1);
  [vals recs] = sort(predictions, 1, "descend");
  recs = recs(1:n, :);
  vals = vals(1:n, :);

end