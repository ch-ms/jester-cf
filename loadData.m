function [] = loadData()

  fname = "./jester-11.mat";

  review_counts = zeros(0, 1);

  if (exist(fname, "file") == 0)
    disp("Convert file to binary");

    fid = fopen("./jester-data-11.csv");
    line_num = 0;

    while (! feof(fid) )

      line = fgets(fid);
      raw_data = strsplit(line, ',', 'collapsedelimiters', false);
      data = cellfun(@str2num, raw_data);

      review_counts = [review_counts; data(1)];

      if (exist("jesterData1", "var") == 0)
        jesterData1 = zeros(0, size(data)(2) - 1);
      endif

      jesterData1 = [jesterData1; data(2:end)];

      line_num += 1;
      if (mod(line_num, 10) == 0)
        fprintf("Processed line #%i, jesterData size %ix%i.\n", line_num, size(jesterData1));
      endif

    endwhile

    save -binary jester-11.mat jesterData1 review_counts

    fprintf("Processed %i users with %i reviews.\n\n", size(jesterData1));

  else
    fprintf("File already exists, skip file processing.\n\n");
  endif

end

