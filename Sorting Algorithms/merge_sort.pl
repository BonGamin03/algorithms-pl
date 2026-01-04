% Merge Sort Algorithm
% Divide-and-conquer sorting algorithm that divides the list into halves,
% recursively sorts them, and merges the sorted halves
 

%  Rules 

% Main predicate: merge_sort(List, Sorted)
% Sorts a list using the Merge Sort algorithm

% Base case: Empty list is already sorted
merge_sort([], []).

% Base case: Single element is already sorted
merge_sort([X], [X]).

% Recursive case: Split, sort, and merge
merge_sort(List, Sorted) :-
    List = [_, _|_],  % At least 2 elements
    split(List, Left, Right),
    merge_sort(Left, SortedLeft),
    merge_sort(Right, SortedRight),
    merge(SortedLeft, SortedRight, Sorted).

% split(List, Left, Right)
% Splits a list into two halves

split([], [], []).
split([X], [X], []).
split([X, Y|Rest], [X|Left], [Y|Right]) :-
    split(Rest, Left, Right).

% merge(Left, Right, Merged)
% Merges two sorted lists into a single sorted list

% Base case: One list is empty
merge([], Right, Right).
merge(Left, [], Left).

% Recursive case: Compare heads and merge
merge([X|RestX], [Y|RestY], [X|Merged]) :-
    X =< Y,
    merge(RestX, [Y|RestY], Merged).

merge([X|RestX], [Y|RestY], [Y|Merged]) :-
    X > Y,
    merge([X|RestX], RestY, Merged).
