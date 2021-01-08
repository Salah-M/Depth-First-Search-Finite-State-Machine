fileID = fopen('tree_2.txt',"r");
formatSpec ='%s';
TR = textscan(fileID,formatSpec);
fclose(fileID);
TREE=str2double(TR{1}(1:end));
C = 4;%input to function
D = 8;%input to function
disp(TREE);
[out,out1]=dfs(TREE,D,C);
disp(out);
disp(out1);
