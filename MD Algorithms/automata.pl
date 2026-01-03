
% Simulation of Non-Deterministic Finite Automata (NFA)
% An automaton accepts a string if there exists a path from the initial state
% to a final state that consumes the entire input string

% Define final states
final(e3).


% Define transitions: transition(FromState, Symbol, ToState)
transition(e1, a, e1).
transition(e1, a, e2).
transition(e1, b, e1).
transition(e2, b, e3).
transition(e3, b, e4).


% Define epsilon (null) transitions: null(FromState, ToState)
null(e2, e4).
null(e3, e1).


%------------------------------ Rules -------------------------------------

% Main predicate: accept(State, List)
% Checks if the automaton accepts the input list starting from the given state

% Base case: Empty list is accepted if current state is final
accept(E, []) :-
    final(E).

% Recursive case: Consume a symbol and transition to next state
accept(E, [X|L]) :-
    transition(E, X, E1),
    accept(E1, L).

% Epsilon transition case: Move to another state without consuming input
accept(E, L) :-
    null(E, E1),
    accept(E1, L).

