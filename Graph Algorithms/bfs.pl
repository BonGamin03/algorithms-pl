% Breadth-First Search (BFS)
% BFS explores nodes level by level, visiting all neighbors of a node
% before moving to the next level
% Uses a queue (FIFO) to manage the order of node exploration

 

% Facts - Graph edges
edge(a, b).
edge(a, c).
edge(b, d).
edge(c, d).
edge(c, e).
edge(d, f).
edge(e, f).

%  Rules 

% Main predicate: bfs(Start, Goal, Path)
% Finds a path from Start to Goal using BFS
bfs(Start, Goal, Path) :-
    bfs_search([[Start]], Goal, ReversePath),
    reverse(ReversePath, Path).

% bfs_search(Queue, Goal, Path)
% Queue contains paths to explore: [[current_path], [other_path], ...]
% The first element of each path is the current node

% Base case: Goal found
bfs_search([[Goal|Rest]|_], Goal, [Goal|Rest]).

% Recursive case: Expand the first path in queue
bfs_search([[Current|Path]|OtherPaths], Goal, Solution) :-
    findall([Next, Current|Path],
            (edge(Current, Next), \+ member(Next, [Current|Path])),
            NewPaths),
    append(OtherPaths, NewPaths, UpdatedQueue),
    bfs_search(UpdatedQueue, Goal, Solution).

%  BFS Traversal 

% bfs_traversal(Start, Order)
% Returns the order in which nodes are visited using BFS
bfs_traversal(Start, Order) :-
    bfs_traverse([[Start]], [Start], OrderReversed),
    reverse(OrderReversed, Order).

% bfs_traverse(Queue, Visited, Order)
% Queue: paths to explore
% Visited: nodes already visited
% Order: final traversal order (accumulated in reverse)

% Base case: Queue is empty
bfs_traverse([], Visited, Visited).

% Recursive case: Process first path in queue
bfs_traverse([[Current|_]|OtherPaths], Visited, Order) :-
    findall([Next],
            (edge(Current, Next), \+ member(Next, Visited)),
            NewPaths),
    findall(Next,
            (edge(Current, Next), \+ member(Next, Visited)),
            NewNodes),
    append(Visited, NewNodes, UpdatedVisited),
    append(OtherPaths, NewPaths, UpdatedQueue),
    bfs_traverse(UpdatedQueue, UpdatedVisited, Order).