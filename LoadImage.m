function [image, raw] = LoadImage(path, resize_dim, silence)
    if ~exist('silence', 'var') || isempty(silence)
        fprintf(1, '-loading %s...\n', path);
    end
    image = imread(path);

    %Returns Bounding Box values based on number of objects
    FDetect = vision.CascadeObjectDetector;
    BB = step(FDetect,image);
    % step(Detector,I) returns Bounding Box value that contains [x,y,Height,Width].

    % Somtimes the program will catch more than 1 face in a picture, such as irow==2, so we choose the second face only.
    [irow, ~] = size(BB);
    if irow == 2
        N = ndims(BB);
        if ~exist('silence', 'var') || isempty(silence)
      		fprintf(1, '--strange face number: %d\n', N);
        end
        image = imcrop(image,BB(2,:));
    else
        image = imcrop(image,BB);
    end
    
    raw = image;

    if ~exist('resize_dim', 'var') || isempty(resize_dim)
        resize_dim = [80 60];
    end
    
    image = imresize(image, resize_dim);          
    image = rgb2gray(image);
    [irow, icol] = size(image);

    image = reshape(image',irow*icol,1);  
end