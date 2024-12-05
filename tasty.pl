% define a vegetables/1 predicate that is true of the following: carrot cucumber
% define a bread/1 predicate that is true of the following: rye wheat
% define a cake predicate that is true of the following: carrot chocolate
% define a tasty/1 predicate that is true of something if it is a type of vegetable 
% and a type of cake
% Depending on how you format your code, this program should be about 7 or 8 lines long

% Define a vegetables/1 predicate
vegetables(carrot).
vegetables(cucumber).

% Define a bread/1 predicate
bread(rye).
bread(wheat).

% Define a cake/1 predicate
cake(carrot).
cake(chocolate).

% Define a tasty/1 predicate
tasty(X):-vegetables(X),cake(X).