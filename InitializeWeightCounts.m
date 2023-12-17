function [weightCounts] = InitializeWeightCounts()
weightCounts = containers.Map;
weightCounts('0.5') = 0;
weightCounts('1') = 0;
weightCounts('5') = 0;
weightCounts('10') = 0;
weightCounts('20') = 0;
weightCounts('50') = 0;
weightCounts('100') = 0;
weightCounts('200') = 0;
weightCounts('-1') = 0;
end

