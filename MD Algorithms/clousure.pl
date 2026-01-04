% Computation of Closures for Binary Relations
% Computes reflexive, symmetric, and transitive closures
% Relations are represented as lists of pairs: [pair(a,b), pair(b,c), ...]

%------------------------------ Reflexive Closure -------------------------------------

% reflexive_closure(Relation, Set, Closure)
% Adds all pairs (x,x) for each element x in the set
reflexive_closure(R, S, Closure) :-
    findall(pair(X, X), member(X, S), ReflexivePairs),
    union(R, ReflexivePairs, Closure).

%------------------------------ Symmetric Closure -------------------------------------

% symmetric_closure(Relation, Closure)
% For each pair(x,y) in R, adds pair(y,x) if not already present
symmetric_closure(R, Closure) :-
    findall(pair(Y, X), member(pair(X, Y), R), InversePairs),
    union(R, InversePairs, Closure).

%------------------------------ Transitive Closure -------------------------------------

% transitive_closure(Relation, Closure)
% Computes the transitive closure using Warshalls algorithm
% Adds pair(x,z) whenever pair(x,y) and pair(y,z) exist

transitive_closure(R, Closure) :-
    transitive_step(R, R1),
    (R = R1 -> Closure = R ; transitive_closure(R1, Closure)).

% One step of transitive closure computation
transitive_step(R, R1) :-
    findall(pair(X, Z), 
            (member(pair(X, Y), R), member(pair(Y, Z), R)),
            NewPairs),
    union(R, NewPairs, R1).

%------------------------------ Complete Closure -------------------------------------

% equivalence_closure(Relation, Set, Closure)
% Computes the smallest equivalence relation containing R
% (reflexive + symmetric + transitive closure)

equivalence_closure(R, S, Closure) :-
    reflexive_closure(R, S, R1),
    symmetric_closure(R1, R2),
    transitive_closure(R2, Closure).

%------------------------------ Helper Predicates -------------------------------------

% union/3 - Standard list union (no duplicates)
union([], L, L).
union([H|T], L, R) :-
    member(H, L), !,
    union(T, L, R).
union([H|T], L, [H|R]) :-
    union(T, L, R).