function [distance] = CompareHistograms(inputImage1, inputImage2)
  % Define the size of the filter
  filterSize = 15;

  % Apply the filter to the images
  filteredImage1 = imfilter(inputImage1, fspecial('average', [filterSize filterSize]));
  filteredImage2 = imfilter(inputImage2, fspecial('average', [filterSize filterSize]));

  % Convert the images to grayscale
  grayImage1 = filteredImage1(:,:,1);
  grayImage2 = filteredImage2(:,:,1);

  % Compute the histograms
  [histogram1] = imhist(grayImage1);
  [histogram2] = imhist(grayImage2);

  % Normalize the histograms
  normalizedHistogram1 = histogram1 / size(grayImage1, 1) / size(grayImage1, 2);
  normalizedHistogram2 = histogram2 / size(grayImage2, 1) / size(grayImage2, 2);

  % Compute the distance between the histograms
  distance = pdist2(normalizedHistogram1', normalizedHistogram2', 'cosine');
end
