%% test
s = [10 10 10 1 1 2 2 2 3 3 4 4 5 6 6 7 7 8 8 9];
t = [1 2 3 2 4 3 4 7 5 8 6 7 7 7 11 11 9 7 9 11];
weights = [3 6 8 2 2 2 1 8 1 3 9 8 5 1 2 4 1 2 3 3];

G = digraph(s,t,weights);
p = plot(G,'EdgeLabel',G.Edges.Weight);

[path_st,d] = shortestpath(G,10,11)
highlight(p,path_st,'EdgeColor','r')

[path_st,d] = shortestpath(G,3,9)
highlight(p,path_st,'EdgeColor','g')

%% 1
s = [1 1 1 2 2 2 2 3 3 4 4 5];
t = [2 3 6 3 4 5 6 4 5 5 6 6];
weights = [18 13 15 17 5 6 12 14 3 9 11 10];
G = graph(s,t,weights);
p = plot(G,'EdgeLabel',G.Edges.Weight);

[T_prims,pred_prims] = minspantree(G) %prims som default

[T_kruskals,pred_kruskals] = minspantree(G,'Method','sparse')
plot(T_prims,'EdgeLabel',T_prims.Edges.Weight)
%% 2
s = {'s' 's' 's' '1' '1' '2' '2' '2' '3' '3' '4' '4' '5' '5' '6' '6' '7' '7' '8' '8' '9'};
t = {'1' '2' '3' '2' '4' '3' '4' '7' '5' '8' '6' '7' '2' '7' '7' 't' '9' 't' '7' '9' 't'};
weights = [3 6 8 2 2 2 1 8 1 3 9 8 3 5 1 2 1 4 2 3 3];
G = digraph(s,t,weights);
p = plot(G,'EdgeLabel',G.Edges.Weight);

[path_st,d] = shortestpath(G,'s','t')
highlight(p,path_st,'EdgeColor','r')

[path_39,d] = shortestpath(G,'3','9')
highlight(p,path_39,'EdgeColor','g')

%% 3
A = [0 4 5 3 inf inf; 
    inf 0 inf inf -1 inf
    inf 4 0 1 inf 2
    inf inf inf 0 inf -1
    inf inf -2 inf 0 2
    inf inf inf inf inf 0]

[D p] = FloydWarshall(A)
path1 = findpath(p, 1, 6)


%%  4 primal
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

%%  4 dual
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

%% uppgif 4 optimization tool primal
prim = optimproblem('ObjectiveSense','min');
x1 = optimvar('t1');
x2 = optimvar('t2');
x3 = optimvar('t3');
x4 = optimvar('t4');
x5 = optimvar('t5');
x6 = optimvar('t6');

z = x6 - x1;
prim.Objective = z;
prim.Constraints.c1 = x2 - x1 >= 6
prim.Constraints.c2 = x3 - x1 >= 5
prim.Constraints.c3 = x3 - x2 >= 0
prim.Constraints.c4 = x4 - x2 >= 3
prim.Constraints.c5 = x5 - x3 >= 4
prim.Constraints.c6 = x4 - x5 >= 0
prim.Constraints.c7 = x6 - x4 >= 3

[sol,fval] = solve(prim)

%% uppgif 4 optimization tool dual
dual = optimproblem('ObjectiveSense','max');
x12 = optimvar('t12','LowerBound', 0);
x13 = optimvar('t13','LowerBound', 0);
x23 = optimvar('t23','LowerBound', 0);
x24 = optimvar('t24','LowerBound', 0);
x35 = optimvar('t35','LowerBound', 0);
x54 = optimvar('t54','LowerBound', 0);
x46 = optimvar('t46','LowerBound', 0);

z = 6*x12 + 5*x13 + 0*x23 + 3*x24 + 4*x35 + 0*x54 + 3*x46
dual.Objective = z;
dual.Constraints.c1 = -x12 - x13 == -1
dual.Constraints.c2 = x12 - x23 - x24 == 0
dual.Constraints.c3 = x13 + x23 - x35 == 0
dual.Constraints.c4 = x24 + x54 - x46 == 0
dual.Constraints.c5 = x35 - x54 == 0
dual.Constraints.c6 = x46 == 1

[sol,fval] = solve(dual)

%%
s = [1, 1, 2, 2, 3, 5, 4];
t = [2, 3, 3, 4, 5, 4, 6];
weights = -[6, 5, 0, 3, 4, 0, 3];
G = digraph(s,t,weights);
p = plot(G,'EdgeLabel',G.Edges.Weight);

[path_st,d] = shortestpath(G,1,6)
highlight(p,path_st,'EdgeColor','r')

function [path] = findpath(p, x, y) % hittar väg givet startnod och slutnod
curr_path = {y}; % cell för att spara element
element = p(x, y); % försista element 
l = length(p(1,:)); % storlek på matrisen (en rad eller en kolumn)
for i=1:l-1 % iterera en gång mindre för att sista element finns redan sparad
    curr_path{end+1} = element; % spara element i cellen
    element = p(x, element); % gå till föregående element i vägen
end
path = flip(curr_path); % vänd på element för rätt ordning
end