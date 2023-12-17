function [labeledImage, numRegions, filteredIndices, labeledRegions] = DetectRectangles(O)
   % Convert the input image to grayscale
   grayImage = rgb2gray(O);
   
   % Create a binary image where all pixels with intensity >= 250 are set to 1
   binaryImage = grayImage >= 250;
   
   % Apply a median filter to the binary image
   filteredImage = medfilt2(binaryImage, [15 15]);
   
   % Invert the binary image
   invertedImage = ~filteredImage;
   
   % Erode the inverted image
   erodedImage = imerode(invertedImage, strel('rectangle', [20 20]));
   
   % Fill the holes in the eroded image
   filledImage = imfill(erodedImage, 'holes');
   
   % Get the properties of the regions in the filled image
   regions = regionprops(filledImage, 'Area', 'BoundingBox');
   
   % Get the area of each region
   area = [regions.Area];
   
   % Get the bounding box of each region
   boundingBox = vertcat(regions(:).BoundingBox);
   
   % Calculate the area of each bounding box
   boundingBoxArea = boundingBox(:,3) .* boundingBox(:,4);
   
   % Filter the regions based on their area
   areaFilter = (area ./ boundingBoxArea) >= 0.95;
   
   % Find the indices of the regions that pass the filter
   filteredIndices = find(areaFilter);
   
   % Label the regions in the filled image
   [labeledImage, numRegions] = bwlabel(filledImage);
   
   % Get the properties of the regions in the labeled image
   labeledRegions = regionprops(labeledImage, 'BoundingBox', 'Area');
   
end
