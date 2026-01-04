% Chromatic Number Calculation
% The chromatic number is the minimum number of colors needed to color
% the vertices of a graph such that no two adjacent vertices have the same color

% Use:
% ?- chromatic_number(a, ChromaticNum).
% ChromaticNum = 2

% Facts - Graph edges (same as all_paths.pl)
edge(a, b).
edge(a, c).
edge(b, d).
edge(c, d).
edge(c, e).
edge(d, f).
edge(e, f).

% Make edges bidirectional for undirected graphs
connected(X, Y) :- edge(X, Y).
connected(X, Y) :- edge(Y, X).

%----------------------- Rules --------------------------

% Main predicate: chromatic_number(StartNode, ChromaticNumber)
% Finds the minimum number of colors needed
chromatic_number(Start, ChromaticNum) :-
    get_all_nodes(Start, Nodes),
    length(Nodes, MaxColors),
    between(1, MaxColors, K),
    can_color_with_k(Nodes, K),
    !,
    ChromaticNum = K.

%----------------------- Helper Predicates --------------------------

% Get all reachable nodes from a starting node
get_all_nodes(Start, Nodes) :-
    findall(Node, reachable(Start, Node, []), NodesWithDups),
    list_to_set([Start|NodesWithDups], Nodes).

% Check if a node is reachable
reachable(X, X, _).
reachable(X, Y, Visited) :-
    connected(X, Z),
    \+ member(Z, Visited),
    reachable(Z, Y, [X|Visited]).

% can_color_with_k(Nodes, K)
% Checks if the graph can be colored with K colors
can_color_with_k(Nodes, K) :-
    color_graph(Nodes, K, []).

% color_graph(Nodes, MaxColor, ColorAssignment)
% Assigns colors (1 to MaxColor) to all nodes
color_graph([], _, _).
color_graph([Node|Rest], MaxColor, Colored) :-
    between(1, MaxColor, Color),
    \+ conflicts(Node, Color, Colored),
    color_graph(Rest, MaxColor, [color(Node, Color)|Colored]).

% conflicts(Node, Color, ColoredNodes)
% Checks if assigning Color to Node conflicts with neighbors
conflicts(Node, Color, Colored) :-
    connected(Node, Neighbor),
    member(color(Neighbor, Color), Colored).

%----------------------- Get Coloring Assignment --------------------------

% get_coloring(StartNode, NumColors, ColorAssignment)
% Returns a valid coloring assignment
get_coloring(Start, NumColors, ColorAssignment) :-
    get_all_nodes(Start, Nodes),
    color_graph(Nodes, NumColors, ColorAssignment).

%----------------------- Optimal Coloring --------------------------

% optimal_coloring(StartNode, ChromaticNum, ColorAssignment)
% Finds chromatic number and returns the coloring
optimal_coloring(Start, ChromaticNum, ColorAssignment) :-
    chromatic_number(Start, ChromaticNum),
    get_coloring(Start, ChromaticNum, ColorAssignment).