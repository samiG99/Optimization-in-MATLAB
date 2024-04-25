%% 1.1
s = [1 1 1 2 2 2 2 3 3 4 4 5];
t = [2 3 6 3 4 5 6 4 5 5 6 6];
weights = [18 13 15 17 5 6 12 14 3 9 11 10];
G = graph(s,t,weights);
p = plot(G,'EdgeLabel',G.Edges.Weight);

[T_prims,pred_prims] = minspantree(G) %prims som default

[T_kruskals,pred_kruskals] = minspantree(G,'Method','sparse')

%% 1.2
s = {'s' 's' 's' '1' '1' '2' '2' '2' '3' '3' '4' '4' '5' '5' '6' '6' '7' '7' '8' '8' '9'};
t = {'1' '2' '3' '2' '4' '3' '4' '7' '5' '8' '6' '7' '2' '7' '7' 't' '9' 't' '7' '9' 't'};
weights = [3 6 8 2 2 2 1 8 1 3 9 8 3 5 1 2 1 4 2 3 3];
G = digraph(s,t,weights);
p = plot(G,'EdgeLabel',G.Edges.Weight);

[path_st,d] = shortestpath(G,'s','t')
highlight(p,path_st,'EdgeColor','r')

[path_st,d] = shortestpath(G,'3','9')
highlight(p,path_st,'EdgeColor','g')

%% 1.3
A = [0 4 5 3 inf inf; 
    inf 0 inf inf -1 inf
    inf 4 0 1 inf 2
    inf inf inf 0 inf -1
    inf inf -2 inf 0 2
    inf inf inf inf inf 0]

[D p] = FloydWarshall(A)
% resultatet kan man läsa i första raden från matris P
% 0     1     5     3     2     (4)
% 0     1     5     (3)     2     4
% 0     1     (5)     3     2     4
% 0     1     5     3     (2)    4
% (0)     1     5     3     2     4

%% 1.4 primal
A = -[-1 1 0 0 0 0
    -1 0 1 0 0 0
    0 -1 1 0 0 0
    0 -1 0 1 0 0
    0 0 -1 0 1 0
    0 0 0 1 -1 0
    0 0 0 -1 0 1]; % VL

b = -[6 5 0 3 4 0 3]; % HL
f = [-1 0 0 0 0 1]; % funktion
[x, z_] = linprog(f,A,b) %löser Min problem

%% 1.5 dual
Aeq = [-1 -1 0 0 0 0 0
    1 0 -1 -1 0 0 0
    0 1 1 0 -1 0 0
    0 0 0 1 0 1 -1
    0 0 0 0 1 -1 0
    0 0 0 0 0 0 1]

beq = [-1 0 0 0 0 1]
f = -[6 5 0 3 4 0 3]
ln = [0 0 0 0 0 0 0]
A = [];
B = []; % tom matris för linprog
[x, z_] = linprog(f,A,B, Aeq, beq, ln) %löser Min problem
z = -z_

s = [1, 1, 2, 2, 3, 5, 4];
t = [2, 3, 3, 4, 5, 4, 6];
weights = -[6, 5, 0, 3, 4, 0, 3];
G = digraph(s,t,weights);
p = plot(G,'EdgeLabel',G.Edges.Weight);

[path_st,d] = shortestpath(G,1,6);
path_st
d = -d
highlight(p,path_st,'EdgeColor','r')