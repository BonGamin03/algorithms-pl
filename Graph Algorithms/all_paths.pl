% This code will find all path between two nodes 

% Use :                                              
% ?- all_paths(a, f, Paths).                                         
% Paths = [[a, b, d, f], [a, c, d, f], [a, c, e, f]]  



%Facts in this case edges

edge(a, b).
edge(a, c).
edge(b, d).
edge(c, d).
edge(c, e).
edge(d, f).
edge(e, f).

%----------------------- Rules --------------------------

%Function to find all paths betwen two nodes 
all_paths(X, Y, Paths) :-
    findall(Path, travel_all(X, Y, [X], Path), Paths).  



%Function to find the path recursively 
travel_all(X, Y, Visited, Path) :-
    edge(X, Y),
    reverse([Y|Visited], Path).


travel_all(X, Y, Visited, Path) :-
    edge(X, Z),
    \+ member(Z, Visited),                                                   
    travel_all(Z, Y, [Z|Visited], Path).

