function data = processData(data)

  % Normalize ratings
  data = data + 11;
  data = round(data);
  data(find(data == 110)) = 0;

end