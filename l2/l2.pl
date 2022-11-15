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

% 2.4.1) dropAllCopy(E, L, Ol)
% A version of dropAll that copies the term we want to drop.
% Useful for dropping terms that contain wildcards

dropAllCopy(X, [], []).
dropAllCopy(X, [X2|Xs], L) :- copy_term(X, X2), dropAllCopy(X, Xs, L), !.
dropAllCopy(X, [H|T], [H|L]) :- dropAllCopy(X, T, L).

% 2.4.2) dropNode(+ Graph , +Node , -OutGraph )
% Drop all edges starting and leaving from a Node

dropNode(G, N, OG) :- dropAllCopy(e(N,_), G, G2), dropAllCopy(e(_,N), G2, OG).

% 2.5) reaching(+Graph, +Node, -List)
% List contains all the nodes that can be reached in 1 step from Node

% without member or findall:
%reaching([], N, []).
%reaching([e(N,M)|T], N, [M|L]) :- reaching(T, N, L), !.
%reaching([e(N0,_)|T], N, L) :- reaching(T, N, L).

reaching(G, N, L) :- findall(H2,member(e(N,H2), G), L).

% 2.6) anypath(+Graph, +Node1, +Node2, -ListPath)
% A path from Node1 to Node2.
% If there are many paths, they are showed 1-by-1.
anypath(G, N1, N2, L) :- anypath(G, N1, N2, L, G).
anypath([e(N1, N3)|T], N1, N2, [e(N1,N3)|L], G) :- anypath(G, N3, N2, L, G).
anypath([e(N3,N4)|T], N1, N2, L, G) :- anypath(T, N1, N2, L, G).
anypath([e(N1,N2)|T], N1, N2, [e(N1,N2)], G).

% 2.7) allreaching(+Graph, +Node, -List)
% List contains all nodes that can be reached from Node

allreaching(G, N ,L) :- anypath(G, N, _, L1), !, findall(H2,member(e(_,H2), L1), L).


% 3.0) 
% MODEL
%player
player(x).
player(o).

% table --> [cell(1,1,o),cell(1,2,x),...]
row(1).
row(2).
row(3).
col(1).
col(2).
col(3).
cell(X, Y, P) :- row(X), col(Y), player(P).

%result
result(nothing).
result(even).
result(win(P)) :- player(P).

% ALGORITHMS
searchCell([C|_], C) :- !.
searchCell([H|T], C) :- searchCell(T, C).

addCell([], X, Y, P, [cell(X, Y, P)]) :- cell(X,Y,P).
addCell([H|T], X, Y, P, [H|T1]) :- 
	cell(X,Y,P),
	H \= cell(X,Y,_),
	addCell(T, X, Y, P, T1).

% 3.1) next(@Table, @Player, -Result, -NewTable)
%la prossima mossa di player è una qualunque in una cella libera.
next(T, P, nothing, NT) :- player(P), addCell(T, X, Y, P, NT).

% 3.2) game(@Table, @Player, -Result, -TableList)