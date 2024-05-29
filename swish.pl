% Define the initial state and the goal state
initial_state([w, w, w, w, w]).
goal_state([e, e, e, e, e]).

% Define constraints
illegal_state([e, w, w, R, e]).
illegal_state([w, e, e, R, w]).
illegal_state([w, X, e, e, w]).
illegal_state([e, X, w, w, e]).


% Define legal state
legal_state(State) :-
    \+ illegal_state(State).

% Define legal moves
legal_move([w, w, G, R, w], cross_fox, [e, e, G, R, e]).
legal_move([w, X, w, R, w], cross_goose, [e, X, e, R, e]).
legal_move([w, X, G, w, w], cross_grain, [e, X, G, e, e]).
legal_move([e, e, G, R, e], cross_fox, [w, w, G, R, w]).
legal_move([e, X, e, R, e], cross_goose, [w, X, w, R, w]).
legal_move([e, X, G, e, e], cross_grain, [w, X, G, w, w]).
legal_move([w, X, G, R, w], cross_alone, [e, X, G, R, e]).
legal_move([e, X, G, R, e], cross_alone, [w, X, G, R, w]).

% Plan(L): L is a list of moves from the initial state to a goal state.
plan(L) :- initial_state(I), goal_state(G), write('Initial state: '), writeln(I), reach(I, G, [], L), write('Plan: '), writeln(L).
% Check if an element is a member of a list
is_member(_, []) :- fail.
is_member(Element, [Element|_]).
is_member(Element, [_|Rest]) :-
    is_member(Element, Rest).

reach(S, S, _, []).
reach(S1, S3, Visited, [Move|Moves]) :-
    legal_move(S1, Move, S2),
    \+ is_member(S2, Visited), % Check if S2 is already visited
    \+ illegal_state(S2), % Check if S2 is not illegal
    write('Move: '), writeln(Move),
    write('Next state: '), writeln(S2),
    reach(S2, S3, [S2|Visited], Moves).
