% x1=0, x2=5, x3=1, z=-19

% inlinprog hittar optimala heltal lösningen direkt
f = [2 -3 -4];
intcon = 2;
A = [-1 1 3;
    3 2 -1];
b = [8 10];
lb = [0 0 0];
ub =  [inf inf inf];

[x z] = intlinprog(f, intcon, A, b, [], [], lb, ub)

%% Exempel 1: p0   x2 först   Strategi -> BFS, x2->x3->x1
f = [2 -3 -4];  
A = [-1 1 3;
    3 2 -1];
b = [8 10];
lb = [0 0 0];  % x1, x2, x3 >= 0
ub =  [inf inf inf]; % ingen övergräns

[xp0 zp0] = linprog(f, A, b, [], [], lb, ub)

% p1 optimal
f = [2 -3 -4];
A = [-1 1 3;
    3 2 -1];
b = [8 10];
lb = [0 0 0];
ub =  [inf 5 inf];  % x2 <= 5

[xp1 zp1] = linprog(f, A, b, [], [], lb, ub)

% p2 inga tillåtna lösningar
f = [2 -3 -4];
A = [-1 1 3;
    3 2 -1];
b = [8 10];
lb = [0 6 0]; % x2 >= 6
ub =  [inf inf inf];

[xp2 zp2] = linprog(f, A, b, [], [], lb, ub)

%% Exempel 2: p0   x3 först  Strategi -> BFS, x3->x1->x2
f = [2 -3 -4];
A = [-1 1 3;
    3 2 -1];
b = [8 10];
lb = [0 0 0]; % x1, x2, x3 >= 0
ub =  [inf inf inf]; % ingen övergräns

[x z] = linprog(f, A, b, [], [], lb, ub)

% p1 tillåten lösning
f = [2 -3 -4];
A = [-1 1 3;
    3 2 -1];
b = [8 10];
lb = [0 0 0];
ub =  [inf inf 0]; % x3 <= 0

[xp1 zp1] = linprog(f, A, b, [], [], lb, ub)

% p2
f = [2 -3 -4];
A = [-1 1 3;
    3 2 -1];
b = [8 10];
lb = [0 0 1]; % x3 >= 1
ub =  [inf inf inf];

[xp2 zp2] = linprog(f, A, b, [], [], lb, ub)

% p3 optimal lösning
f = [2 -3 -4];
A = [-1 1 3;
    3 2 -1];
b = [8 10];
lb = [0 0 1]; % x1 <= 0
ub =  [0 inf inf];

[xp3 zp3] = linprog(f, A, b, [], [], lb, ub)

% p4 sämre lösning än p3 -> kapa här
f = [2 -3 -4];
A = [-1 1 3;
    3 2 -1];
b = [8 10];
lb = [1 0 1]; % x1 >= 1
ub =  [inf inf inf];

[xp4 zp4] = linprog(f, A, b, [], [], lb, ub)
