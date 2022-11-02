search(X, [X|_]).
search(X, [_|Xs]) :- search(X, Xs).