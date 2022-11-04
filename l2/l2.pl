% 1.1) dropAny(?Elem, ?List, ?Outlist)
% Drops any occurrence of the element

dropAny(X, [X|T], T).
dropAny(X, [H|Xs], [H|L]) :- dropAny(X, Xs, L).

% 1.2) dropFirst(?Elem, ?List, ?Outlist)
% Drops the first occurrence of the element

% dropFirst(X, L, OL) :- dropAny(X, L, OL), !.
dropFirst(X, [X|T], T) :- !.
dropFirst(X, [H|Xs], [H|L]) :- dropFirst(X, Xs, L).

% 1.3) dropLast(?Elem, ?List, ?OList)
% Drops the last occurrence of the element

dropLast(X, [X], []) :- !.
dropLast(X, [H|Xs], [H|L]) :- dropLast(X, Xs, L).

% 1.4) dropAll(?Elem, ?List, ?OList)
% Drops all the occurrences of the element