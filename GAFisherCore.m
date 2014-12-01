function [Wopt, Mpj, Upj] = GAFisherCore(X, C)
%% function [Wopt, Mpj, Upj] = GAFisherCore(X, C)
% X: training image = [x1 x2 x3 ... xn] (kxn, k is the dimension of each image)
% C: class label = [c1 c2 c3 ... cn] (corresponding to X) (1xn or nx1)
%
% Wopt: optimal projection after GA-Fisher (kxp, k is the dim of each comp)
% Mpj: mean image of X after projection(kx1)
% Upj: mean image of each class after projection = [u1 u2 u3 ... uj] (kxj, j is the number of classes)
    
    fprintf(1, 'GA-Fisher Core\n');
    [M, U, Sw, Sb] = ScatterMat(X, C);
    % [~, ~, Wga, Lga] = GApca(X, U, M, Sw, Sb);
    [~, ~, Wga, Lga] = GApca(X, U, M, Sw, Sb, [], [], [], [20 40]); % test
    Wopt = Whiten(Sw, Sb, Wga, Lga);
    
    Mpj = Wopt.' * M;
    Upj = zeros(size(Wopt, 2), size(U, 2));
    for i = 1:size(U, 2)
        Upj(:,i) = Wopt.' * U(:,i);
    end
end