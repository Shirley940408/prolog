% Fluents
% location(Ella, Place) - discribes current location (e.g., bed, bed_location, car, school)

% Actions
action(get_out_of_bed).
action(go_from_bed_to_car).
action(drive_to_school).


% Precondition Axioms define when an action is possible:

% Ella can get out of bed if she is in bed
poss([get_out_of_bed | S]) :-
    fluent(location(Ella, bed), S).

% Ella can go from bed to car if she is in bed and not already in the car
poss([go_from_bed_to_car | S]) :-
    fluent(location(Ella, bed_location), S).

% Ella can drive to school if she is in the car
poss([drive_to_school | S]) :-
    fluent(location(Ella, car), S).

% Successor State Axioms define how fluents change after an action:

% If Ella gets out of bed, her location remains "bed" but indicates she is no longer sleeping
fluent(location(Ella,bed_location), [get_out_of_bed | S]) :-
    fluent(location(Ella, bed), S).

% If Ella gets out of bed, her location changes to "car"
fluent(location(Ella, car), [go_from_bed_to_car | S]) :-
    fluent(location(Ella, bed_location), S).

% If Ella drives to school, her location changes to "school"
fluent(location(Ella, school), [drive_to_school | S]) :-
    fluent(location(Ella, car), S).

% Initial state: Ella starts in bed
initial_state([]). % Empty action history
fluent(location(Ella, bed), []).

% Goal: Ella is at school
goal(S) :- fluent(location(Ella, school), S).

/* BFS code */
%plan(g(S),S) is true when g(S) is a formula (the goal state depending on S) that is true, and S is an action history (the plan)
plan(Goal,Plan):-bposs(Plan),Goal.

%bposs(S) is true when S is a sequence of possible actions considering shortest sequences first
bposs(S) :- tryposs([],S). 
% tryposs(S,S) is true when S is a sequence of possible actions considering shortest sequences first (breadth first search for possible action sequences)
tryposs(S,S) :- poss(S).
tryposs(X,S) :- tryposs([_|X],S).