% Find Minimum Spanning Tree Using Kruskals Algorithm  
% Define edges with weights

edge(a, b, 4).
edge(a, c, 3).
edge(b, d, 2).
edge(c, d, 5).
edge(c, e, 1).
edge(d, f, 3).
edge(e, f, 2).

% The predicate to find the minimum spanning tree (MST)

mst(Edges) :-
    findall((W, X, Y), edge(X, Y, W), EdgesList),    % Collect all edges with weights.
    sort(EdgesList, SortedEdges),                    % Sort the edges by weight.
    kruskal(SortedEdges, [], Edges).                 % Use Kruskal algorithm to find the MST.

% Kruskal algorithm to construct the MST

kruskal([], MST, MST).
kruskal([(W, X, Y)|Edges], Acc, MST) :-
    (forms_cycle(X, Y, Acc) -> kruskal(Edges, Acc, MST)     % Check if adding the edge forms a cycle.
    ; kruskal(Edges, [(W, X, Y)|Acc], MST)
    ).


% The predicate to check if adding an edge forms a cycle

forms_cycle(X, Y, Edges) :-
    path(X, Y, Edges).