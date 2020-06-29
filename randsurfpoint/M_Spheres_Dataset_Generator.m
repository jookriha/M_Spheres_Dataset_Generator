%
% M-Spheres Dataset Generator
%
clear, close all;
Nk = 1000; % #observations per cluster
M = 1000;  % #dimensions
K = 10;   % #clusters
dc = 0.1;   % nearest center distance
dr = 1;   % radius of M-sphere

%
% Generate cluster centers
%
C = zeros(K,M);

if(K > 1)
    C(2,:) = randsurfpoint(C(1,:),dc);
    k = 2;
end

if(K > 2)
    while k < K
        i = randi(k);
        c_cand = randsurfpoint(C(i,:),dc);
        [~,i_min] = min(pdist2(c_cand,C(1:k,:),'euclidean'));
        if(i_min == i)
            k = k + 1;
            C(k,:) = c_cand;
        end
    end
end


%
% Generate observations using the cluster centers
%
X = zeros(Nk*K,M); 
labels = zeros(Nk*K,1);
for k = 1:K
    for n = 1:Nk
        drs = rand*dr;
        X(n+(k-1)*Nk,:) = randsurfpoint(C(k,:),drs);
        labels(n+(k-1)*Nk) = k;
    end
end

% figure
% hold
% [~,score,~] = pca(X);
% scatter3(score(:,1),score(:,2),score(:,3),'.k')

save(['K' num2str(K) '_Nk' num2str(Nk) '_M' num2str(M) '_SPEHERES_dc' num2str(dc) '.mat'],'X','labels','C')