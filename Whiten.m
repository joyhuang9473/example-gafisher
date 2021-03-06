function [Wopt] = Whiten(Sw, Sb, Wga, Lga, Wconj, S)
%% Process a whitening procedure

    %% turn Lga to diag matrix
    Wga_whiten = Wga * diag(Lga .^ (-1/2));

    %% Computing Wlda
    fprintf(1, 'eig(Sb,Sw)');
    if ~exist('Wconj', 'var') || isempty(Wconj)
        %% Computing Wconj...
        eigTstart = tic();
        fprintf(1, '... please wait');
        [Wconj, S] = eig(Sb, Sw);
        % save(sprintf('eig-%dx%d.mat', size(Wga,1), size(Wga,2)), 'Wconj', 'S');
        fprintbackspace(4+6+5);
        eigTCost = calctime(toc(eigTstart));
    end
    fprintf(1, ': %d x %d\n', size(Wconj,1), size(Wconj,2));
    if exist('eigTCost', 'var')
        fprintf(1, '\b (%s)\n', eigTCost);
    end
    [~, inx] = sort(diag(S),1,'descend');
    [M, ~] = size(Wga);
    M = min(M, length(inx));
    Wconj = Wconj(:,inx(1:M));
    % Wlda = Wga_whiten^(-1) * Wconj;
    Wlda = pinv(Wga_whiten) * Wconj;

    %% Get optimal projection for GA-Fisher
    Wopt_transpose = Wlda' * Wga_whiten';
    Wopt = Wopt_transpose';
    fprintf(1, 'Wopt: %d x %d\n', size(Wopt, 1), size(Wopt, 2));
end
