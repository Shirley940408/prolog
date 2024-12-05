%length(L,N) means that the leangth of the list L is N
length([], 0).
length([_|T], N) :- 
length(T, N1),
N is N1 + 1. % this line must follow(at last).

/*
1. simplest case possible - base case.
2. do a recursive call - with a smaller problem

Why it did not create the infinite loop? - because it split to a smaller problem. -> to the base case, and then to the recursive call. And the first line actually is not directly recursive, it is matching with [_|T], which is calculated T.
length([], 0).
length(L, N) :- 
L = [_|T],
length(T, N1),
N is N1 + 1. % this line must follow.
*/

/*
why we don't need cut?
cut is not logical. - which would generate wrong answers.
*/