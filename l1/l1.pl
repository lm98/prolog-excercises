
% 1.1) search(Elem, List)
search(X, [X|_]).
search(X, [_|Xs]) :- search(X, Xs).

% 1.2) search2(Elem, List)
search2(X, [X, X|_]).
search2(X, [_|Xs]):- search2(X, Xs).

% 1.3) search_two(Elem, List).
% Looks for two occurrences of Elem with any element in between

search_two(X, [X, _, X|_]).
search_two(X, [_|Xs]) :- search_two(X, Xs).

% 1.4) search_anytwo(Elem, List)
% Looks for any Elem that occurs two times, anywhere

search_anytwo(X, [X|Xs]) :- search(X, Xs).
search_anytwo(X, [_|Xs]):- search_anytwo(X, Xs).

% 2.1) size(List, Size)
% Size will contain the number of elements in List

size([], 0).
size([_|Xs], N) :- size(Xs, N2), N is N2 + 1.

% size2(List, Size)
% Size will contain the number of elements in List ,
% written using notation zero , s( zero ), s(s( zero ))

size2([], zero).
size2([_|Xs], N) :- size2(Xs, N2), N = s(N2).

% 2.3) sum(List, Sum)
% Sum will contain the sum of all the numbers inside List

sum([], 0).
sum([X|Xs], Sum) :- sum(Xs, Sum2), Sum is X + Sum2.

% 2.4) average(List, Average)
% it uses average(List, Count, Sum, Average)

average(List, A) :- average(List, 0, 0, A).
average([], C, S, A) :- A is S/C.
average([X|Xs], C, S, A) :- 
	C2 is C+1,
	S2 is S+X,
	average(Xs, C2, S2, A).

% 2.5) max(List, Max)
% Max is the biggest element in List
% Suppose the List has at least one element

max([X|Xs], M) :- max(Xs, M, X).
max([], M, TM):- M is TM.
max([X|Xs], M, TM) :- X > TM, TM2 is H, max(Xs, M, TM2).
max([X|Xs], M, TM) :- X < TM, max(Xs, M, TM).