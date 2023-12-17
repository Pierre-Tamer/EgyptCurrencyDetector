% Function to separate rectangles in an image
function [labeledImage, numRegions, filteredIndices, labeledRegions] = SeparateRectangles(inputImage)
   % Convert the input image to grayscale
   grayImage = rgb2gray(inputImage);

   % Create a binary image where all pixels with intensity >= 0.99 are set to 1
   binaryImage = imbinarize(grayImage, 0.99);

   % Apply a Canny edge detector to the binary image
   edgeImage = edge(binaryImage, 'canny');
   
   % Fill the holes in the edge image
   filledImage = imfill(edgeImage, 'holes');
   
   % Erode the filled image
   erodedImage = imerode(filledImage, strel('rectangle', [180 180]));
   
   % Get the properties of the regions in the eroded image
   regions = regionprops(erodedImage, 'Area', 'BoundingBox');
   
   % Get the area of each region
   area = [regions.Area];
   
   % Get the bounding box of each region
   boundingBox = vertcat(regions(:).BoundingBox);
   
   % Calculate the area of each bounding box
   boundingBoxArea = boundingBox(:,3) .* boundingBox(:,4);
   
   % Filter the regions based on their area
   areaFilter = (area ./ boundingBoxArea) >= 0.5;
   
   % Find the indices of the regions that pass the filter
   filteredIndices = find(areaFilter);
   
   % Label the regions in the eroded image
   [labeledImage, numRegions] = bwlabel(erodedImage);
   
   % Get the properties of the regions in the labeled image
   labeledRegions = regionprops(labeledImage, 'BoundingBox', 'Area');
end


