
% Use                                              
% ?- neighbors(c, Neighbors).                                       
% Neighbors = [a, d, e, f] 

%Facts in this case edges
edge(a, b).
edge(a, c).
edge(b, d).
edge(c, d).
edge(c, e).
edge(d, f).
edge(e, f).

%---------------------------------- Rules -------------------------------------------

% Function to find all neighbors of a node.
neighbors(Node, Neighbors) :-
    findall(Neighbor, (edge(Node, Neighbor); edge(Neighbor, Node)), NeighborsList),            
    sort(NeighborsList, Neighbors).                                                             
