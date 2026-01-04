% Depth-First Search (DFS)
% DFS explores as far as possible along each branch before backtracking
% Uses a stack (LIFO) to manage the order of node exploration
% In Prolog, the natural recursion provides the stack behavior


% Facts - Graph edges
edge(a, b).
edge(a, c).
edge(b, d).
edge(c, d).
edge(c, e).
edge(d, f).
edge(e, f).

%  Rules 

% Main predicate: dfs(Start, Goal, Path)
% Finds a path from Start to Goal using DFS
dfs(Start, Goal, Path) :-
    dfs_search(Start, Goal, [Start], ReversePath),
    reverse(ReversePath, Path).

% dfs_search(Current, Goal, Visited, Path)
% Current: current node being explored
% Goal: target node
% Visited: list of visited nodes (to avoid cycles)
% Path: accumulated path (in reverse order)

% Base case: Goal found
dfs_search(Goal, Goal, Visited, Visited).

% Recursive case: Explore neighbors depth-first
dfs_search(Current, Goal, Visited, Path) :-
    edge(Current, Next),
    \+ member(Next, Visited),
    dfs_search(Next, Goal, [Next|Visited], Path).

%  DFS Traversal 

% dfs_traversal(Start, Order)
% Returns the order in which nodes are visited using DFS
dfs_traversal(Start, Order) :-
    dfs_traverse(Start, [Start], OrderReversed),
    reverse(OrderReversed, Order).

% dfs_traverse(Current, Visited, Order)
% Current: current node being explored
% Visited: nodes already visited
% Order: final traversal order (accumulated in reverse)

% Base case: No more neighbors to explore
dfs_traverse(Current, Visited, Visited) :-
    \+ (edge(Current, Next), \+ member(Next, Visited)).

% Recursive case: Explore next unvisited neighbor
dfs_traverse(Current, Visited, Order) :-
    edge(Current, Next),
    \+ member(Next, Visited),
    dfs_traverse(Next, [Next|Visited], Order).

% Alternative: Continue with remaining neighbors after backtracking
dfs_traverse(Current, Visited, Order) :-
    edge(Current, Next),
    \+ member(Next, Visited),
    dfs_traverse(Next, [Next|Visited], PartialOrder),
    % Continue exploring other branches from Current
    (   edge(Current, Another),
        \+ member(Another, PartialOrder)
    ->  dfs_traverse(Another, PartialOrder, Order)
    ;   Order = PartialOrder
    ).
