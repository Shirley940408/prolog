% define the parent/2 relation where parent(x,y) means x is the parent of y.
parent(bill, joe).
parent(susan, joe).
parent(susan, sally).
parent(joe, chri).
parent(joe, jeff).
parent(jeff, jack).

% rule: everybody who is a parent of someone else is also a parent
educated(X) :- parent(_, X).

% sibling(X, Y) is true if X and Y share at least one parent, and X is not the same as Y.
sibling(X, Y) :- 
    parent(P, X),  % P is a parent of X
    parent(P, Y),  % P is a parent of Y
    X \= Y.        % X and Y are different individuals

% X is poor if X has a child C who has a sibling _.
poor(X) :- parent(X, C), sibling(C, _).

% grandparent(X, Y) is true if X is the grandparent of Y.
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

% Define male/1 and female/1 relations for each person.
male(bill).
male(joe).
male(chri).
male(jeff).
male(jack).

female(susan).
female(sally).

% Define sister/2 relation
sister(X, Y) :- parent(Z, X), parent(Z, Y), female(X), X \= Y.

% Define aunt/2: X is the aunt of Y if X is the sister of one of Y's parents
aunt(X, Y) :- sister(X, Z), parent(Z, Y).