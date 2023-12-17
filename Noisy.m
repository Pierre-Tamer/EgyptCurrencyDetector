function [filteredImage] = Noisy(I)
  % Separate the image into its color channels
  R = I(:,:,1);
  G = I(:,:,2);
  B = I(:,:,3);

  % Apply a median filter to each color channel
  filteredImage(:,:,1) = medfilt2(R,[5 5]);
  filteredImage(:,:,2) = medfilt2(G,[5 5]);
  filteredImage(:,:,3) = medfilt2(B,[5 5]);
end