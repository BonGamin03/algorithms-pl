% Verification of Equivalence Relations
 
% Relations are represented as lists of pairs: [pair(a,b), pair(b,c), ...]

% Rules

% Main predicate: is_equivalence(Relation, Set)
% Checks if a relation is an equivalence relation over a given set

is_equivalence(R, S) :-
    is_reflexive(R, S),
    is_symmetric(R),
    is_transitive(R).

% Reflexive Check

% A relation is reflexive if for every element x in the set, pair(x,x) is in the relation
is_reflexive(R, S) :-
    \+ (member(X, S), \+ member(pair(X, X), R)).

% Symmetric Check

% A relation is symmetric if for every pair(x,y) in R, pair(y,x) is also in R
is_symmetric(R) :-
    \+ (member(pair(X, Y), R), \+ member(pair(Y, X), R)).

% Transitive Check

% A relation is transitive if whenever pair(x,y) and pair(y,z) are in R, 
% then pair(x,z) must also be in R
is_transitive(R) :-
    \+ (member(pair(X, Y), R), member(pair(Y, Z), R), \+ member(pair(X, Z), R)).

% Helper Predicates

% Extract all elements from a relation to form the set
get_elements([], []).
get_elements([pair(X, Y)|Rest], Elements) :-
    get_elements(Rest, RestElements),
    union([X, Y], RestElements, Elements).
 