function data = processData(data)

  % Normalize ratings
  data = data + 10;
  data(find(data == 109)) = 0;
  data = data';

end