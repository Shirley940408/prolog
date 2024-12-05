% Write the procedures described below, using the following functors:
% point/2
% seg/2
% triangle/3
% rectangle/2

% point(X,Y) is true if X and Y are two different points in your grid.
point(1, 1).
point(2, 2).
point(1, 3).

% seg(X,Y) is true if X and Y are two different points in your grid.
/*seg(point(X1,Y1), point(X2,Y2)) :-
    point(X1,Y1),
    point(X2,Y2),
   dif(point(X1,Y1),point(X2,Y2)).
*/

seg(X, Y) :-
    X = point(_, _),X,
    Y = point(_, _),Y,
    dif(X, Y).


% P = point(X,Y) is true if X and Y are two different points in your grid. 
/*
?- P = point(X,Y), P.
P = point(1, 1),
X = Y, Y = 1 ;
P = point(2, 2),
X = Y, Y = 2 ;
P = point(3, 3),
X = Y, Y = 3 ;
P = point(1, 4),
X = 1,
Y = 4 ;
P = point(4, 5),
X = 4,
Y = 5.
*/

% find_point/1 is true if P is a point in your point set. Or use the query in the terminal.
find_point(P) :- point(X, Y), P = point(X, Y).

%triangle(X,Y,Z) is true if X, Y, and Z  exist in your point set, and form a triangle

triangle(X, Y, Z):-
    X = point(X1, Y1), X,
    Y = point(X2, Y2), Y,
    Z = point(X3, Y3), Z,
    dif(X, Y),
    dif(X, Z),
    dif(Y, Z),
    M1 is (Y2 - Y1) * (X3 - X2), 
    M2 is (Y3 - Y2) * (X2 - X1),
    dif(M1, M2). % this is for slope not equal, which means they are not collinear. but for the condition of X2 - X1 == 0 or X3 - X2 == 0, it might still be triangle, so use cross multiplication to check instead.

/*
?- :triangle(point(1,1), point(2,2), point(3,3)).
true . 
?- triangle(point(1,1), point(1,4), point(1,7)).
false.
*/

% procedure to find all triangles among your points
% ?- triangle(X, Y, Z), X = point(_,_),X, Y = point(_,_),Y, Z = point(_,_),Z.
% Use your procedure to find all triangles with a vertical side
% ?- triangle(X, Y, Z), X = point(X1,_),X, Y = point(X2,_),Y, Z = point(X3,_),Z, X1 = X2; X1 = X3; X2 = X3.

% vertical_seg/2 is true if the two points are on the same vertical line.
vertical_seg(point(X, Y1), point(X, Y2)) :-
    point(X, Y1),  % 确保点存在
    point(X, Y2),  % 确保点存在
    Y1 \= Y2.      % Y 坐标不同，形成竖直线段

% length_seg/3 means to calculate the length of the vertical line
length_seg(point(_, Y1), point(_, Y2), Length) :-
    Length is abs(Y2 - Y1).  % 计算 Y 坐标的差值（绝对值）

% min/3 means to return the minimum of two numbers
min(X, Y, X) :- X =< Y.
min(X, Y, Y) :- X > Y.

% rectangle is true if X and Y are vertical segments and X and Y have the same length and the bottom point of X is at the same level as the bottom point of Y.
rectangle(SegX, SegY) :-
    % SegX 和 SegY 都是竖直线段
    SegX = seg(point(X1, Y1), point(X1, Y2)), SegX,  % 线段 X 的两个点
    SegY = seg(point(X2, Y3), point(X2, Y4)), SegY,  % 线段 Y 的两个点
    
    % SegX 和 SegY 的长度相同
    length_seg(point(X1, Y1), point(X1, Y2), LengthX), 
    length_seg(point(X2, Y3), point(X2, Y4), LengthY),
    LengthX = LengthY,

    % SegX 和 SegY 的底部点处于同一水平
    min(Y1, Y2, BottomPointX),  % 线段 X 的底部点
    min(Y3, Y4, BottomPointY),  % 线段 Y 的底部点
    BottomPointX = BottomPointY.  % 确保两个线段的底部点相同

% test cases
/*
?- rectangle(seg(point(1, 1), point(1, 3)), seg(point(4, 2), point(4, 4))).
false.
?- rectangle(seg(point(1, 1), point(1, 3)), seg(point(4, 1), point(4, 3))).
true .
*/