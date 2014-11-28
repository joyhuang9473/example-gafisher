%Main
% close all
% clear all
% clc

train_nface = 6; % Choose how many pictures of one person to train.

while (1==1)
    choice=menu('Face Attendance System',...
                'Create Database of Faces',...
                'Delete DataBase',...
                'Train System',...
                'Face Recognition',...
                'Exit');
    if (choice ==1)
        CreateDatabase;
    end
    
    if (choice == 2)
        DeleteDatabase;
    end
    
    if (choice ==3)
        
        [m, A, Eigenfaces]=Trainit (train_nface);
    end
    if (choice == 4)
        if exist('train.mat');
            load train;
        end
        FaceRec(m, A, Eigenfaces, train_nface);
    end
   
    if (choice == 5)
        clear all;
        clc;
        close all;
        return;
    end    
    
end
