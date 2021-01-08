function [pathmin,wpathmin] = dfs_opt(TREE,D,C)

    %initializations 
    STACK_ADRS = zeros(D,C);
    STACK_IX = (D);
    STACK_NUMEL = (D); 
    wpath = (D);
    path = (D);
    pathmin = (D);
    wpathmin=inf;
    nextk=1;
    STACK_IX(:)=1;
    STACK_NUMEL(:)=1;
    while nextk ~= 0
    k = nextk;
        if STACK_NUMEL(k) <= 0
    nextk = k - 1; % move up one level
    else
% read stack at current level
    ix = STACK_IX(k); 
    adrs = STACK_ADRS(k,ix); % read top of stack
    STACK_IX(k) = STACK_IX(k) + 1; % update index
    STACK_NUMEL(k) = STACK_NUMEL(k) - 1; % update numel left
% read info of node, update path and path-weight
w = TREE(adrs+1); 
parent = TREE(adrs+2); 
nc=TREE(adrs+3);
path(k) = adrs;
    if k==1, wpath(k) = w; 
    else 
        wpath(k) = wpath(k-1) + w; 
    end
    if wpath(k)>wpathmin, nextk= k-1;%if the weight of the path we are on now is more than the minimum no need to check more
    
    elseif nc==0 % current node is a leaf: update minimum
    if wpath(k) < wpathmin
                wpathmin = wpath(k); pathmin = path(1:k);
    end
   else % current node is NOT a leaf
    if nc==1
        c1 = TREE(adrs+4);
        nextk = k+1;
        STACK_ADRS(k+1,1)= [c1];
        STACK_IX(k+1)=1;
        STACK_NUMEL(k+1) = 1;
    elseif nc==2
        c1 = TREE(adrs+4);
        c2 = TREE(adrs+5);
        nextk = k+1;
        STACK_ADRS(k+1,1:2)= [c1,c2];
        STACK_IX(k+1)=1;
        STACK_NUMEL(k+1) = 2;
    elseif nc==3
        c1 = TREE(adrs+4);
        c2 = TREE(adrs+5);
        c3 = TREE(adrs+6);
        nextk = k+1;
        STACK_ADRS(k+1,1:3)= [c1,c2,c3];
        STACK_IX(k+1)=1;
        STACK_NUMEL(k+1) = 3;
    elseif nc==4
        c1 = TREE(adrs+4);
        c2 = TREE(adrs+5);
        c3 = TREE(adrs+6);
        c4 = TREE(adrs+7); 
        nextk = k+1;
        STACK_ADRS(k+1,1:4)= [c1,c2,c3,c4];
        STACK_IX(k+1)=1;
        STACK_NUMEL(k+1) = 4;

    end
    end
        end
    end
end