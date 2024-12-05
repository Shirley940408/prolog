:- op(500, xfx, has).
:- op(400, xfy, and).

% 定义 Mary 拥有 talent
mary has talent and big hopes and high ambitions.

% 定义 if_then_else 结构
if_then_else(Condition, ThenClause, ElseClause) :-
    (Condition -> ThenClause ; ElseClause).

% 使用 if_then_else 判断较大值
max_value(X, Y, Z) :-
    if_then_else(X > Y, Z = X, Z = Y).
