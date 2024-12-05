% mymember(X,L) is true if X is an element of list L
% this first clause says H is a member of the list (second argument) 
% if H is the first element of the second argument.
mymember(H,[H|_]). % Base case
% this second clause says that H is a member of the list if H is a member of the tail of the list
mymember(H,[_|T]):- % do a recursive call with a smaller problem.
  mymember(H,T).

