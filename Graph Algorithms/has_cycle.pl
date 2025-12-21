
% Detect Cycles in a Directed Graph
% Define edges of the graph

edge(a, b).
edge(a, c).
edge(b, d).
edge(c, d).
edge(c, e).
edge(d, f).
edge(e, f).
edge(f, c).


% The predicate to check if the graph has any cycle.
has_cycle :-
    edge(X, _),                                                 % Start from each node with an outgoing edge.
    cycle(X, [X]).                                              % Check for cycles starting from node X.
