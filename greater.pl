% Define the successor/2 predicate
successor(two, one).
successor(three, two).
successor(four, three).
successor(five, four).
successor(six, five).
successor(seven, six).
successor(eight, seven).

% Define the greater/2 predicate
greater(Y, X) :- successor(Y, X).
greater(Y, X) :- successor(Z, X),greater(Y, Z).

/*
assume successor is defined, 
write the following recursive predicate.
*/