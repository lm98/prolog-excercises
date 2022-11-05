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
% se l' elemento è in testa mangio la testa e proseguo, altrimenti lo cerco in coda.
dropAll(X, [X|T], L) :- dropAll(X, T, L), !.
dropAll(X, [H|Xs], [H|L]) :- dropAll(X, Xs, L).
dropAll(X, [], []).

% 2.1) fromList(+List, -Graph)
% It obtains a graph from a list.
% A graph is a list of couples: e.g. [e(1,2),e(2,3),e(1,3)]

fromList([_], []).
fromList([H1,H2|T], [e(H1, H2)|L]) :- fromList([H2|T], L).

% 2.2) fromCircList(+List, -Graph)
% It obtains a graph from a circular list

fromCircList([H], G) :- fromCircList([H], H, G).
fromCircList([H1,H2|T],[e(H1, H2)|L]) :- fromCircList([H2|T], H1, L).
fromCircList([H1,H2|T], H0,[e(H1, H2)|L]) :- fromCircList([H2|T], H0, L).
fromCircList([H], H0, [e(H, H0)]).

% 2.3) inDegree(+Graph, +Node, -Deg)
% Deg is the number of edges leading into Node

inDegree(G, N, D):- inDegree(G, N, D, 0).
inDegree([], N, D, TD) :- D is TD.
inDegree([e(H1,N)|L], N, D, TD) :- TD2 is TD + 1, inDegree(L, N, D, TD2).
inDegree([e(H1, H2)|L], N, D, TD) :- inDegree(L, N, D, TD).