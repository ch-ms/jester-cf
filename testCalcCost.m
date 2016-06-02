function t = testCalcCost()

  X = [1; 2];
  Theta = [3; 4; 5];
  Y = [0 1 0; 1 0 0];
  R = Y;

  t = calcCost(X, Theta, Y, R) == 17;

end