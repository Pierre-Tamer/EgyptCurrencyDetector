method = input("Enter the method: ",'s');

if method == "single"
  processImages('TestCases\1. Upright front-back Single', 'D');
elseif method == "all"
  processImages('TestCases\2. Upright front-back all-in-one none-intersect', 'D');
elseif method == "rotate"
  processRotatedImages('TestCases\3. Rotated-none-intersect');
elseif method == "b_all"
  processImages('TestCases\Bonus\4. All-in-one intersect', 'S');
elseif method == "b_rotate"
  processRotatedImagesBonus('TestCases\Bonus\5. Rotated-All-in-one intersect');
elseif method == "b_noise"
  processImages('TestCases\Bonus\6. Noisy', 'N');
else
  error('Invalid method')
end

function processImages(directory, mode)
  images = GetImages(directory);
  for k = 1 : length(images)
      I = imread(images{k});
      count = ImagesOperation(I, mode);
      displayImage(I, count);
  end
end

function processRotatedImages(directory)
  images = GetImages(directory);
  for k = 1 : length(images)
      I = imread(images{k});
      count = Rotation(images{k});
      displayImage(I, count);
  end
end

function processRotatedImagesBonus(directory)
  images = GetImages(directory);
  for k = 1 : length(images)
      I = imread(images{k});
      count = Rotation_Bonus(images{k});
      displayImage(I, count);
  end
end

function displayImage(I, count)
  figure, imshow(I), title("Total Count : " + count);
end

