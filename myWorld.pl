even(2).
even(4).

int(1).
int(2).
int(3).
int(4).
int(5).

favorite(X) :- \+even(X), int(X), X > 2, X < 4.