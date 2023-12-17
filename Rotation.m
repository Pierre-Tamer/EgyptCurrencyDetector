function counter = Rotation(directory)
    weights = [0.5, 1, 5 , 10, 20, 50, 100, 200];
    sides = ["-Front.jpg", "-Back.jpg"];
    counter = 0;
    
    for weight = weights
     for side = sides
       weightStr = num2str(weight);
       sideStr = strrep(side, '-Front.jpg', 'Front');
       sideStr = strrep(sideStr, '-Back.jpg', 'Back');
       weightImagePath = strcat("TestCases\Temp\", weightStr, side);
       weightImage = rgb2gray(imread(weightImagePath));
       weightImageCorners = detectSURFFeatures(weightImage);
       [weightFeatures] = extractFeatures(weightImage, weightImageCorners);
       
       InputImage=rgb2gray(imread(directory));
       InputImageCorners = detectSURFFeatures(InputImage);
       [features] = extractFeatures(InputImage,InputImageCorners);
       
       indexPairsMatched=matchFeatures(weightFeatures,features);
       minMatches=50;
       if(size(indexPairsMatched,1)>=minMatches)
           disp(strcat(weightStr, " pounds has been found on the ", sideStr))
           counter = counter + weight;
           disp(counter);
       end
     end
    end
end