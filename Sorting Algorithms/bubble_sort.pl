% Bubble Sort Algorithm
% Simple sorting algorithm that repeatedly steps through the list,
% compares adjacent elements and swaps them if theyre in wrong order
 

%  Rules 

% Main predicate: bubble_sort(List, Sorted)
% Sorts a list using the Bubble Sort algorithm

% Base case: Empty list is already sorted
bubble_sort([], []).

% Recursive case: Perform one pass and recursively sort
bubble_sort(List, Sorted) :-
    bubble_pass(List, List2, Swapped),
    (   Swapped = true
    ->  bubble_sort(List2, Sorted)
    ;   Sorted = List2
    ).

% bubble_pass(List, Result, Swapped)
% Performs one pass of bubble sort
% Swapped indicates if any swap was made

% Base case: Empty list
bubble_pass([], [], false).

% Base case: Single element
bubble_pass([X], [X], false).

% Recursive case: Swap if first element is greater than second
bubble_pass([X, Y|Rest], [Y|Result], true) :-
    X > Y,
    !,
    bubble_pass([X|Rest], Result, _).

% Recursive case: No swap needed
bubble_pass([X, Y|Rest], [X|Result], Swapped) :-
    X =< Y,
    bubble_pass([Y|Rest], Result, Swapped).