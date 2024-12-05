/*
1. what fluents/predicates
Fluents are logical predicates that describe the state of the world. In the blocks domain:
- cup_on_position(Position, Situation)
- kettle_filled(yes|no, Situation)
- water_boiled(yes|no,Situation)
- water_in_cup(yes|no, Situation)
- coffee_in_cup(yes|no, Situation)
- coffee_stirred(yes|no, Situation)
- coffee_is_ready(yes|no, Situation)
*/
/*cup(cup).
position(shelf).
position(counter).
in_position(kettle_location).
in_position(cup_location).
kettle(kettle).
water(water).
coffee(coffee).
*/
/*
2. what are the things that can happen(actions)?
- place_cup_on_counter()
- fill_kettle()
- boil_water()
- pour_hot_water_to_cup()
- add_coffee_to_cup()
- stir_coffee_cup()
*/

/*
3. write down a precondition axiom for each action(Precondition Axiom)
- cup is currently at From(shelf).
- shelf and counter are valid and different positions.
- kettle is currently not filled.
- water is currently not boiled.
- coffee is currently not in the cup.
- cup is currently not stirred.
*/
poss([place_cup_on_counter()| S]):-
    cup_on_position(shelf, S),
    \+ cup_on_position(counter, S).
poss([fill_kettle()| S]):-
    kettle_filled(no, S).
poss([boil_water()| S]):-
    kettle_filled(yes, S),
    water_boiled(no, S).
poss([pour_hot_water_to_cup()| S]):-
    cup_on_position(counter, S),
    water_boiled(yes, S).
    water_in_cup(no, S).
poss([add_coffee_to_cup()| S]):-
    cup_on_position(counter, S),
    coffee_in_cup(no, S).
poss([stir_coffee_cup()| S]):-
    water_in_cup(yes, S),
    coffee_in_cup(yes, S),
    coffee_stirred(no, S).

/*
4. foreach fluent write down successor state axiom.
    successor state axiom:
*/
cup_on_position(shelf, []).
cup_on_position(counter, [A|S]):-
    poss([A|S]),
    (
        %becomming true with A
        A = place_cup_on_counter();
        %was true and not becomming false
        cup_on_position(counter, S)
    ).
cup_on_position(shelf, [A|S]):-
    poss([A|S]),
    (
        %was true and not becomming false
        cup_on_position(shelf, S),
        %becomming true with A
        A \= place_cup_on_counter()
    ).

kettle_filled(no, []).
kettle_filled(yes, [A|S]) :-
    poss([A|S]),
    (
        %becomming true with A
        A = fill_kettle();
        %was true and not becomming false
        kettle_filled(yes, S)
    ).
kettle_filled(no, [A|S]) :-
    poss([A|S]),        
    (
        % was true and not becomming false
        kettle_filled(no, S),
        A \= fill_kettle()
    ).
water_boiled(no, []).
water_boiled(yes, [A|S]) :-
    poss([A|S]),
    (
        %becomming true with A
        A = boil_water();
        % was true and not becomming false
        water_boiled(yes, S)
    ).
water_boiled(no, [A|S]) :-    
    poss([A|S]),
    (
        %becomming true with A
        A \= boil_water(),
        % was true and not becomming false
        water_boiled(no, S)
    ).
coffee_in_cup(no, []).
coffee_in_cup(yes, [A|S]):-
    poss([A|S]),
    (
        %becomming true with A
        A = add_coffee_to_cup();
        % was true and not becomming false
        coffee_in_cup(yes, S)
    ).
coffee_in_cup(no, [A|S]):-
    poss([A|S]),
    % was true and not becomming false
    coffee_in_cup(no, S),
    A \= add_coffee_to_cup().
water_in_cup(no, []).
water_in_cup(yes, [A|S]):-
    poss([A|S]),        
    (
        %becomming true with A
        A = pour_hot_water_to_cup();
        % was true and not becomming false
        water_in_cup(yes, S)
    ).
water_in_cup(no, [A|S]):-
    poss([A|S]),
    ( 
        %becomming true with A
        A \= pour_hot_water_to_cup(),
        % was true and not becomming false
        water_in_cup(no, S)
    ).
coffee_stirred(no, []).
coffee_stirred(yes, [A|S]) :-
    poss([A|S]),
    (
        %becomming true with A
        A = stir_coffee_cup();
        % was true and not becomming false
        coffee_stirred(yes, S)
    ).
coffee_stirred(no, [A|S]) :-
    poss([A|S]),
    (
        %becomming true with A
        A \= stir_coffee_cup(),
        % was true and not becomming false
        coffee_stirred(no, S)
    ).

/* BFS code */
%plan(g(S),S) is true when g(S) is a formula (the goal state depending on S) that is true, and S is an action history (the plan)
plan(Goal,Plan):-bposs(Plan),Goal.

%bposs(S) is true when S is a sequence of possible actions considering shortest sequences first
bposs(S) :- tryposs([],S). 
% tryposs(S,S) is true when S is a sequence of possible actions considering shortest sequences first (breadth first search for possible action sequences)
tryposs(S,S) :- poss(S).
tryposs(X,S) :- tryposs([_|X],S).

g(S) :- coffee_stirred(yes, S).