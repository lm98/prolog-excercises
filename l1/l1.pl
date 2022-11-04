
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
max([X|Xs], M, TM) :- X > TM, TM2 is X, max(Xs, M, TM2).
max([X|Xs], M, TM) :- X < TM, max(Xs, M, TM).

% 2.6) maxmin(List, Max, Min)
% Max is the biggest element in List
% Min is the smallest element in List
% Suppose that List has at least one element

maxmin([X|Xs], Max, Min) :- maxmin(Xs, Max, Min, X, X).
maxmin([], Max, Min, Tmax, Tmin) :- Max is Tmax, Min is Tmin.
maxmin([X|Xs], Max, Min, Tmax, Tmin) :- X >= Tmax, Tma2 is X, maxmin(Xs, Max, Min, Tma2, Tmin).
maxmin([X|Xs], Max, Min, Tmax, Tmin) :- X < Tmax, X > Tmin, maxmin(Xs, Max, Min, Tmax, Tmin).
maxmin([X|Xs], Max, Min, Tmax, Tmin) :- X =< Tmin, Tmi2 is X, maxmin(Xs, Max, Min, Tmax, Tmi2).

% 3.1) same(List1, List2)
% are the two lists exactly the same?

same([],[]).
same([X|Xs], [X|Ys]) :- same(Xs, Ys).

% 3.2) all_bigger(List1, List2)
% all elements in List1 are bigger than those in List2, 1 by 1

all_bigger([],[]).
all_bigger([X|Xs], [Y|Ys]) :- X > Y, all_bigger(Xs, Ys).

% 3.3) sublist(List1, List2)
% List1 should contain elements all also in List2

sublist([], List2).
sublist([X|Xs], List2) :- search(X, List2), sublist(Xs, List2).

% 4.1) seq(N, List)
% example: seq(5, [0,0,0,0,0]).

seq(0,[]).
seq(N, [0|T]) :- N2 is N - 1, seq(N2, T).

% 4.2) seqR(N, List)
% example: seqR(4, [4, 3, 2, 1, 0]).

seqR(-1, []).
seqR(N, [N|Ns]) :- N2 is N - 1, seqR(N2, Ns).

% 4.3.1) last(L, N, L2)
% example: last([1, 2, 3], 5, [1, 2, 3, 5]).

last([], N, [N]).
last([X], N, [X, N]).
last([X|Xs], N, [X|Ys]) :- last(Xs, N, Ys).

% 4.3.2) seqR2(N, List)
% example: seqR2(4, [0,1,2,3,4]).
seqR2(-1, []).
seqR2(N, L) :- last(PL, N, L), N2 is N - 1, seqR2(N2, PL).