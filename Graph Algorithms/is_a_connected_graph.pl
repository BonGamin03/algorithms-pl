%Facts in this case edges 
edge(a, b).
edge(a, c).
edge(b, d).
edge(c, d).
edge(c, e).
edge(d, f).
edge(e, f).


%------------------------------ Rules -------------------------------------
%Find all nodes in the graph 
nodes(Nodes) :-
    findall(Node, (edge(Node, _); edge(_, Node)), NodeList),   
    sort(NodeList, Nodes).                                     

%Main function
is_connected :-
    nodes(Nodes),                                             
    check_all_paths(Nodes).

%Function for check all paths between nodes 

check_all_paths([]).
check_all_paths([Node|Nodes]) :-
    path_to_all(Node, Nodes),                            
    check_all_paths(Nodes).     

%Function for check paths from one node to all other nodes 

path_to_all(_, []).
path_to_all(Node, [OtherNode|Nodes]) :-
    path(Node, OtherNode),                                    
    path_to_all(Node, Nodes).                                 

%Funtion to find a path between two nodes 

path(X, Y) :-
    travel(X, Y, [X]).



%Travel function 

travel(X, Y, _) :-
    % Base case
    edge(X, Y).

travel(X, Y, Visited) :-
    edge(X, Z),                                       
    \+ member(Z, Visited),                                     
    travel(Z, Y, [Z | Visited]).
