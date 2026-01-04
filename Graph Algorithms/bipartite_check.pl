% Bipartite Graph Verification
% A graph is bipartite if its vertices can be divided into two disjoint sets
% such that every edge connects a vertex in one set to a vertex in the other set
% Equivalent to checking if the graph is 2-colorable (chromatic number = 2)
 

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

% Rules 

% Main predicate: is_bipartite(StartNode)
% Checks if the graph is bipartite starting from a given node
is_bipartite(Start) :-
    bipartite_color(Start, 0, []).

% bipartite_color(Node, Color, Visited)
% Tries to color the graph with two colors (0 and 1)
% Visited list stores pairs: [color(Node, Color), ...]

% Base case: Node already colored, check if color matches
bipartite_color(Node, Color, Visited) :-
    member(color(Node, Color), Visited), !.

% Fail if node has different color
bipartite_color(Node, Color, Visited) :-
    member(color(Node, OtherColor), Visited),
    Color \= OtherColor, !,
    fail.

% Recursive case: Color current node and all neighbors with opposite color
bipartite_color(Node, Color, Visited) :-
    \+ member(color(Node, _), Visited),
    NextColor is 1 - Color,  % Flip color (0->1, 1->0)
    findall(Neighbor, connected(Node, Neighbor), Neighbors),
    color_neighbors(Neighbors, NextColor, [color(Node, Color)|Visited]).

% Helper: Color all neighbors
color_neighbors([], _, _).
color_neighbors([Neighbor|Rest], Color, Visited) :-
    bipartite_color(Neighbor, Color, Visited),
    color_neighbors(Rest, Color, Visited).

% Alternative: Get Partition Sets 

% get_partition(StartNode, Set1, Set2)
% Returns the two partition sets if graph is bipartite
get_partition(Start, Set1, Set2) :-
    bipartite_color_all(Start, 0, [], ColoredNodes),
    findall(N, member(color(N, 0), ColoredNodes), Set1),
    findall(N, member(color(N, 1), ColoredNodes), Set2).

% Accumulator version to collect all colored nodes
bipartite_color_all(Node, Color, Visited, Result) :-
    member(color(Node, Color), Visited), !,
    Result = Visited.

bipartite_color_all(Node, Color, Visited, Result) :-
    member(color(Node, OtherColor), Visited),
    Color \= OtherColor, !,
    fail.

bipartite_color_all(Node, Color, Visited, Result) :-
    \+ member(color(Node, _), Visited),
    NextColor is 1 - Color,
    findall(Neighbor, connected(Node, Neighbor), Neighbors),
    color_neighbors_all(Neighbors, NextColor, [color(Node, Color)|Visited], Result).

color_neighbors_all([], _, Visited, Visited).
color_neighbors_all([Neighbor|Rest], Color, Visited, Result) :-
    bipartite_color_all(Neighbor, Color, Visited, Temp),
    color_neighbors_all(Rest, Color, Temp, Result).
