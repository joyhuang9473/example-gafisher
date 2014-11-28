function T = TrainDatabase(TrainDatabasePath, train_nface)
% Align a set of face images (the training set T1, T2, ... , TM )
%
% Description: This function reshapes all 2D images of the training database
% into 1D column vectors. Then, it puts these 1D column vectors in a row to 
% construct 2D matrix 'T'.
%  
% 
% Argument:     TrainDatabasePath      - Path of the training database
%
% Returns:      T                      - A 2D matrix, containing all 1D image vectors.
%                                        Suppose all P images in the training database 
%                                        have the same size of MxN. So the length of 1D 
%                                        column vectors is MN and 'T' will be a MNxP 2D matrix.
%
%%%%%%%%%%%%%%%%%%%%%%%% File management

%  no_folder=size(dir([TrainDatabasePath,'\*']),1)-size(dir([TrainDatabasePath,'\*m']),1)-2;
no_folder = 49;
%%%%%%%%%%%%%%%%%%%%%%%% Construction of 2D matrix from 1D image vectors
T = [];
disp('Loading Faces');

 %To detect Face
    FDetect = vision.CascadeObjectDetector;
nface = train_nface;    % Choose how many pictures of one person to train.
for i = 1 : no_folder
    stk = int2str(i);
    disp(stk);
    stk = strcat('\',stk,'\*bmp');
    folder_content = dir ([TrainDatabasePath,stk]);
%     nface = size (folder_content,1);
    
    disp(nface);
for j = 1 :  nface
    str = int2str(j);
    str = strcat('\',str,'.bmp');
    str = strcat('\',int2str(i),str);
    str = strcat(TrainDatabasePath,str); 
   
    img = imread(str);

    %Returns Bounding Box values based on number of objects
    BB = step(FDetect,img);
    % step(Detector,I) returns Bounding Box value that contains [x,y,Height,Width].

    %因為偶爾會跑出 irow==2 的情況，有可能同一張圖上抓到兩張臉，所以先暫時去掉，只取第二個臉
    [irow icol] = size(BB);
    if irow==2
        N = ndims(BB)
        img = imcrop(img,BB(2,:));
        save bb;
    else
        img = imcrop(img,BB);
    end
    
    img = imresize(img, [250 250]);          
    img = rgb2gray(img);
    [irow icol] = size(img);
   
    temp = reshape(img',irow*icol,1);   % Reshaping 2D images into 1D image vectors
    T = [T temp]; % 'T' grows after each turn                    
end

end

end
