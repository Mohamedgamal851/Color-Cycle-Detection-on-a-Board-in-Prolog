% board([ [yellow, yellow, yellow, red], 
% [blue, yellow, blue, yellow], 
% [blue, blue, blue, yellow],
%  [blue, blue, blue, yellow] ]).
% Define the colors
color(red).
color(yellow).
color(blue).
% Design moves
% Define the moves (adjacent cells)
move((X,Y), (X1,Y)) :- X1 is X + 1. % Define a move to the right
move((X,Y), (X1,Y)) :- X1 is X - 1. % Define a move to the left
move((X,Y), (X,Y1)) :- Y1 is Y + 1. % Define a move down
move((X,Y), (X,Y1)) :- Y1 is Y - 1. % Define a move up
% Check if two positions are adjacent and have the same color
adjacent_same_color(Position1, Position2, Board) :-
    move(Position1, Position2), % Check if Position2 is a valid move from Position1
    valid_position(Position2, Board), % Check if Position2 is a valid position on the board
    get_color(Position1, Board, Color), % Get the color of Position1
    get_color(Position2, Board, Color). % Check if the color of Position2 is the same as that of Position1
% Design state representation
% Check if a position is valid on the board
valid_position((X,Y), Board) :-
    length(Board, Rows), % Get the number of rows in the board
    nth0(0, Board, FirstRow), % Get the first row of the board
    length(FirstRow, Cols), % Get the number of columns in the board
    X >= 0, X < Rows, % Check if X is within the valid range
    Y >= 0, Y < Cols. % Check if Y is within the valid range
% Get the color of a cell
get_color((X,Y), Board, Color) :-
    nth0(X, Board, Row), % Get the row at index X
    nth0(Y, Row, Color). % Get the color at index Y in the row
% Design output
% Print the cycle along with its color
print_cycle(Path, Color) :-
    writeln(['Cycle found:', Path, 'Color:', Color]), % Print the cycle and its color
    true.

% Perform depth-first search to find cycles
dfs_cycle(Start, End, Visited, Board) :-
    adjacent_same_color(Start, Next, Board), % Find an adjacent cell with the same color
    \+ member(Next, Visited), % Check if the cell has not been visited yet
    dfs_cycle(Next, End, [Next|Visited],  Board). % Continue the search from the new cell
dfs_cycle(Start, Start, Visited, Board) :-
    length(Visited, Len), % Get the number of visited cells
    Len >= 4, % Check if there are at least 4 cells in the cycle
    reverse(Visited, PathReversed), % Reverse the path to get it in the correct order
    [First|_] = PathReversed, % Get the first cell in the path
    last(PathReversed, Last), % Get the last cell in the path
    move(Last, First), % Check if the last cell is adjacent to the first one
    get_color(Start, Board, Color), % Get the color of the cycle
    print_cycle(PathReversed, Color), % Print the cycle
    !, % Cut to stop the search after finding the first cycle
    assert(found_cycle(true)). % Assert that a cycle has been found

% Entry point
% Design input
main(Board) :-
    retractall(found_cycle(_)), % Clear the found_cycle flag
    assert(found_cycle(false)), % Initialize the found_cycle flag to false
    find_cycle(Board), % Start the search for a cycle
    found_cycle(true), % Check if a cycle has been found
    !. % Cut to stop the program after finding the first cycle
main(_) :- writeln('No cycles found.'), fail. % If no cycle has been found, print a message and fail

% Start DFS from each cell
find_cycle(Board) :-
    nth0(X, Board, _), % For each row X in the board
    nth0(Y, Board, Row), % For each cell Y in the row
    nth0(Y, Row, _), % Get the color of the cell
    dfs_cycle((X,Y), _, [(X,Y)],Board), % Start a DFS from the cell
    found_cycle(true). % Check if a cycle has been found

% Run the program
% main([[yellow, yellow, yellow, red], [blue, yellow, blue, yellow], [blue, blue, blue, yellow], [blue, blue, blue, yellow]]).
% main([[yellow, yellow, yellow, yellow], [red, red, red, red], [blue, blue, blue, blue], [yellow, yellow, yellow, yellow]]).
