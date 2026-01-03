% Check if a Graph is Eulerian
% A graph is Eulerian if:
% 1. It is connected
% 2. All vertices have even degree (for Eulerian Circuit)
% OR exactly two vertices have odd degree (for Eulerian Path)

% Define edges of the graph
edge(a, b).
edge(a, c).
edge(b, c).
edge(b, d).
edge(c, d).


%------------------------------ Rules -------------------------------------

% Find all nodes in the graph
nodes(Nodes) :-
    findall(Node, (edge(Node, _); edge(_, Node)), NodeList),
    sort(NodeList, Nodes).

% Count the degree of a node (number of edges connected to it)
degree(Node, Degree) :-
    findall(N, (edge(Node, N); edge(N, Node)), Neighbors),
    length(Neighbors, Degree).

% Count how many nodes have odd degree
count_odd_degrees(Nodes, Count) :-
    findall(Node, (member(Node, Nodes), degree(Node, Deg), Deg mod 2 =:= 1), OddNodes),
    length(OddNodes, Count).

% Check if the graph is connected (simplified version)
is_connected :-
    nodes(Nodes),
    Nodes \= [],
    Nodes = [Start|_],
    reachable_from(Start, Reachable),
    sort(Reachable, SortedReachable),
    SortedReachable = Nodes.

% Find all nodes reachable from a starting node
reachable_from(Start, Reachable) :-
    findall(Node, can_reach(Start, Node, [Start]), ReachableList),
    sort([Start|ReachableList], Reachable).

% Check if we can reach a node from another
can_reach(X, Y, _) :-
    edge(X, Y).
can_reach(X, Y, _) :-
    edge(Y, X).
can_reach(X, Y, Visited) :-
    (edge(X, Z); edge(Z, X)),
    \+ member(Z, Visited),
    can_reach(Z, Y, [Z|Visited]).

% Main predicate: Check if graph has Eulerian Circuit (all vertices have even degree)
has_eulerian_circuit :-
    is_connected,
    nodes(Nodes),
    count_odd_degrees(Nodes, 0).

% Main predicate: Check if graph has Eulerian Path (exactly 2 vertices have odd degree)
has_eulerian_path :-
    is_connected,
    nodes(Nodes),
    count_odd_degrees(Nodes, 2).

% Main predicate: Check if graph is Eulerian (has circuit or path)
is_eulerian :-
    has_eulerian_circuit.
is_eulerian :-
    has_eulerian_path.