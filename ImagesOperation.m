% Function to process an image based on the provided mode
function [count] = ImagesOperation(inputImage, mode)
   templates_path = 'TestCases\Temp';
   
%    Determine Mode
   if (mode == 'N')
       inputImage = Noisy(inputImage);
       [labeledImage, numRegions ,filteredIndices, labeledRegions] = DetectRectangles(inputImage);
   end
   if(mode == 'D')
       [labeledImage, numRegions, filteredIndices, labeledRegions] = DetectRectangles(inputImage);
   elseif (mode == 'S') 
       [labeledImage, numRegions ,filteredIndices, labeledRegions] = SeparateRectangles(inputImage);
   end      
   
   % Initialize output image and weight Counts
   outputImage = zeros(size(inputImage));
   weightCounts = InitializeWeightCounts();
   totalCount = 0;
   
   % Loop through each region in the image
   for i = 1: numRegions
       if(ismember(i,filteredIndices)) % If the region is a rectangle
           regionPixels = labeledImage == i; % Get the pixels of the region in the image
           
           % Add the region to the output image
           outputImage(:,:,1) = (uint8(regionPixels).*inputImage(:,:,1));
           outputImage(:,:,2) = (uint8(regionPixels).*inputImage(:,:,2));
           outputImage(:,:,3) = (uint8(regionPixels).*inputImage(:,:,3));
           
           % Crop the region from the output image
           boundingBox = labeledRegions(i).BoundingBox;
           croppedImage = imcrop(outputImage,[boundingBox(1),boundingBox(2),boundingBox(3),boundingBox(4)]);
           
           % Detect the currency in the cropped image
           maxAccuracy = 0;
           maxFileName = "";
           files = GetImages(templates_path);
           for j = 1: size(files,1)
               template = imread(char(files(j)));
               accuracy = 1 - CompareHistograms(template,uint8(croppedImage));
               if accuracy > maxAccuracy
                  maxAccuracy = accuracy;
                  maxFileName = char(files(j));
               end
           end
           
           disp(maxFileName);
           type = MainPounds(maxFileName);
           totalCount = totalCount + type;
           weightCounts(num2str(type)) = weightCounts(num2str(type)) + type;
       end
   end
   
   % Display the count map
keys = {'0.5', '1', '5', '10', '20', '50', '100', '200'};
for i = 1:length(keys)
 key = keys{i};
 disp([key, ' pound found ', num2str(weightCounts(key)/str2double(key)), ' times']);
end
   count = totalCount;
end
