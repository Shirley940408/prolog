/*
- go(Monkey, From, To)
- push(Monkey, Box, From, To)
- climbUp(Monkey, Box, From_box_position)
- climbDown(Monkey, Box, From_box_position)
- grab(Monkey, Banana, From_box_position)
*/
/*
write down a precondition axiom for each action(Precondition Axiom)
- The block is clear(clear(Block, S))
- The destination (To) is clear
- Both From and To are valid positions or blocks.
- The block is currently at From.
go:
- Monkey is currently at From
- Monkey is not at the top of Box
push:
- Monkey is currently at From
- Box is currently at From
- the destination (To) is clear
climbUp:
 - Monkey is currently at From
 - Box is currently at From
climbDown:
 - Monkey is currently at Box
 - Box is currently at From
grab:
 - Monkey is currently at Box
 - Box is currently at From 
 - Banana is currently at From
*/
box(x).
position(p1).
position(p2).
position(p3).
banana(b).
monkey(k).

% Poss([go(Monkey, From, To)|S]) is true if Block B could be moved from Position X to % Position Y based % on the situation S
poss([go(Monkey, From, To)|S]):- monkey(Monkey), position(From), position(To),
    dif(From,To),
	on(Monkey, From, S).

poss([push(Monkey, Box, From, To)|S]):-monkey(Monkey), box(Box), position(From), position(To),
    dif(From, To),
    on(Box, From, S),
    on(Monkey, From, S),
    \+on(_, To, S).

poss([climbUp(Monkey, Box, From)|S]):- 
monkey(Monkey), 
box(Box), 
position(From),
on(Box, From, S),
on(Monkey, From, S).

poss([climbDown(Monkey, Box, From)|S]):-
monkey(Monkey),
box(Box),
position(From),
on(Monkey, Box, S),
on(Box, From, S).

poss([grab(Monkey, Box, Banana, From_box_position)|S]):-
monkey(Monkey),
box(Box),
banana(Banana),
position(From_box_position),
on(Monkey, Box, S),
on(Box, From_box_position, S),
on(Banana, From_box_position, S).

%hasBanana(YorN, S) means that the monkey has the bananas (YorN) in S.

hasBanana(n,[]).
hasBanana(y,[A|S]):- 
poss([A|S]),
 (A = grab(Monkey, Box, Banana, From_box_position)
  ;
  hasBanana(y, S)
 ).

  
% on(B, X, S) means that a Box, or Monkey is on Position or Box X in Situation S, or a Banana is on the top of Position X in Situation S.
on(k, p1, []).
on(x, p2, []).
on(b, p3, []).

on(X, Position, [A|S]):-
    poss([A|S]),
    (monkey(X),
        (A = go(X, _, Position);
            (on(X, Position, S), A \= go(X, Position, _))
        )
    );
    (monkey(X),
        (A = climbUp(X, Position, Box);
            (on(X, Box, S),A \= climbDown(X, Box, _))
        )    
    );
    (box(X),
        A = push(Monkey, X, _, Position);
            (on(X, Position, S),A \= push(Monkey, X, Position,_))
    );
    (banana(X),on(X, Position, S),A \= grab(Monkey, X, Position, _)).
    

/* BFS code */
%plan(g(S),S) is true when g(S) is a formula (the goal state depending on S) that is true, and S is an action history (the plan)
plan(Goal,Plan):-bposs(Plan),Goal.

%bposs(S) is true when S is a sequence of possible actions considering shortest sequences first
bposs(S) :- tryposs([],S). 
% tryposs(S,S) is true when S is a sequence of possible actions considering shortest sequences first (breadth first search for possible action sequences)
tryposs(S,S) :- poss(S).
tryposs(X,S) :- tryposs([_|X],S).
/*
%?- plan(on(k, x, [grab(k,x,b,p3),climbUp(k,x,p3),push(k,x,p2,p3),go(k, p1, p2)]),[grab(k,x,b,p3),climbUp(k,x,p3),push(k,x,p2,p3),go(k, p1, p2)]).
true .
?- plan(on(k, x, S), S).
?- plan(hasBanana(y,S),S).
*/