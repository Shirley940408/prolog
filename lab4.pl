% mycount(List,Count) which is true if Count is the number of items of the list.
mycount([], 0).
mycount([_|T], N):-
    mycount(T, N1),
    N is N1 + 1.

% nth(N,List,Item) which is true if Item is the Nth item in list List.
nth(1, [H|_], H).
nth(N, [_|T], Item):-
    nth(N1, T, Item),
    N is N1 + 1.

% myinsert(Item,List,Position,Result) which is true if Result is the list formed by inserting Item into List at position Position.
% base case is the place is the Head that we to put.
myinsert(Item, List, 1, [Item|List]).

% the Position in the whole list fo this Item is Position1 located in Tail plus the Head, which is One.
myinsert(Item, [H|T], Position, [H|Result]):-
    myinsert(Item, T, Position1, Result),
    Position is Position1 + 1.

/*
% 基线情况：空列表，插入到第 1 个位置
myinsert(Item, [], 1, [Item]).

% 插入位置为 1, 直接在列表头部插入元素
myinsert(Item, List, 1, [Item|List]).

% 递归处理插入位置大于 1 的情况
myinsert(Item, [H|T], Position, [H|Result]):-
    Position > 1,
    Position1 is Position - 1,
    myinsert(Item, T, Position1, Result).
*/

% mydelete(N,List,Result) which is true if Result is the list formed by deleting the Nth element of List。
mydelete(1, [_|T], T).
mydelete(N, [H|T], [H|Result]):-
    N > 1,
    N1 is N - 1,
    mydelete(N1, T, Result).