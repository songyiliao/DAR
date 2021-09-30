function ldd = getLDD(insts1, instsBase, knn)
data = [insts1 instsBase];
[data,~] = mapminmax(data);
[m,n] = size(insts1);
insts1 = data(:,1:n);
instsBase = data(:,n+1:end);
%---------
[m,n] = size(instsBase);
%if n>m
instsBase = instsBase';
insts1 = insts1';
deleteID = zeros(size(insts1, 1),1);
numBase = size(instsBase, 1);
nanb = knnsearch([instsBase; insts1], instsBase,'K',knn+1);%knnsearch requires each row represents one sample
na = sum(nanb<=numBase,2);
nb = sum(nanb>numBase,2);
ldd =((na./size(instsBase, 1)) - nb./size(insts1, 1));
[~,rela_point_nonLoop] = sort(ldd, 'descend');
deleteVec = [1:1:size(instsBase,1)];
ldd = rela_point_nonLoop;














