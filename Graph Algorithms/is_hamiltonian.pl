
% Check if a Graph is Hamiltonian
% A graph is Hamiltonian if it contains a Hamiltonian cycle:
% a cycle that visits every vertex exactly once and returns to the starting vertex

% Define edges of the graph
edge(a, b).
edge(a, c).
edge(b, c).
edge(b, d).
edge(c, d).
edge(d, a).


%------------------------------ Rules -------------------------------------

% Find all nodes in the graph
nodes(Nodes) :-
    findall(Node, (edge(Node, _); edge(_, Node)), NodeList),
    sort(NodeList, Nodes).

% Check if there is an edge between two nodes (undirected)
connected(X, Y) :-
    edge(X, Y).
connected(X, Y) :-
    edge(Y, X).

% Find a Hamiltonian path starting from a node
hamiltonian_path(Start, Path) :-
    nodes(Nodes),
    length(Nodes, N),
    hamiltonian_path_helper(Start, [Start], N, Path).

% Base case: We have visited all nodes
hamiltonian_path_helper(_, Visited, N, Path) :-
    length(Visited, N),
    reverse(Visited, Path).

% Recursive case: Visit next unvisited node
hamiltonian_path_helper(Current, Visited, N, Path) :-
    length(Visited, Len),
    Len < N,
    connected(Current, Next),
    \+ member(Next, Visited),
    hamiltonian_path_helper(Next, [Next|Visited], N, Path).

% Find a Hamiltonian cycle starting from a node
hamiltonian_cycle(Start, Cycle) :-
    nodes(Nodes),
    length(Nodes, N),
    hamiltonian_cycle_helper(Start, Start, [Start], N, Cycle).

% Base case: We have visited all nodes and can return to start
hamiltonian_cycle_helper(Start, Current, Visited, N, Cycle) :-
    length(Visited, N),
    connected(Current, Start),
    reverse([Start|Visited], Cycle).

% Recursive case: Visit next unvisited node
hamiltonian_cycle_helper(Start, Current, Visited, N, Cycle) :-
    length(Visited, Len),
    Len < N,
    connected(Current, Next),
    \+ member(Next, Visited),
    hamiltonian_cycle_helper(Start, Next, [Next|Visited], N, Cycle).

% Main predicate: Check if the graph has a Hamiltonian cycle
has_hamiltonian_cycle :-
    nodes(Nodes),
    Nodes \= [],
    member(Start, Nodes),
    hamiltonian_cycle(Start, _).

% Main predicate: Check if the graph has a Hamiltonian path
has_hamiltonian_path :-
    nodes(Nodes),
    Nodes \= [],
    member(Start, Nodes),
    hamiltonian_path(Start, _).

% Main predicate: Check if graph is Hamiltonian (has a Hamiltonian cycle)
is_hamiltonian :-
    has_hamiltonian_cycle.

