function [distance sim_id] = findClosest(Params, id)

  obj = Params(id, :);
  similarity = sqrt(sum(abs(Params - obj) .^ 2, 2));
  % Self penalty
  similarity(id, :) = Inf;
  [distance sim_id] = min(similarity);

end