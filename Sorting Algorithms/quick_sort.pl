% QuickSort Algorithm
% Divide-and-conquer sorting algorithm that picks a pivot element
% and partitions the array around it, then recursively sorts the partitions
 

%  Rules 

% Main predicate: quick_sort(List, Sorted)
% Sorts a list using the QuickSort algorithm

% Base case: Empty list is already sorted
quick_sort([], []).

% Base case: Single element is already sorted
quick_sort([X], [X]).

% Recursive case: Partition around pivot and recursively sort
quick_sort([Pivot|Rest], Sorted) :-
    partition(Pivot, Rest, Smaller, Greater),
    quick_sort(Smaller, SortedSmaller),
    quick_sort(Greater, SortedGreater),
    append(SortedSmaller, [Pivot|SortedGreater], Sorted).

% partition(Pivot, List, Smaller, Greater)
% Partitions a list into elements smaller than and greater than/equal to Pivot

% Base case: Empty list
partition(_, [], [], []).

% Recursive case: Element is smaller than pivot
partition(Pivot, [X|Rest], [X|Smaller], Greater) :-
    X =< Pivot,
    partition(Pivot, Rest, Smaller, Greater).

% Recursive case: Element is greater than pivot
partition(Pivot, [X|Rest], Smaller, [X|Greater]) :-
    X > Pivot,
    partition(Pivot, Rest, Smaller, Greater).