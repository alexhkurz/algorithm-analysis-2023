%  Figure 4.7  Program 1 for the eight queens problem.


% solution( BoardPosition) if
%   BoardPosition is a list of non-attacking queens

solution( [] ).

solution( [X/Y | Others] )  :-      % First queen at X/Y, other queens at Others
  solution( Others),
  member( Y, [1,2,3,4,5,6,7,8] ),
  noattack( X/Y, Others).           % First queen does not attack others

noattack( _, [] ).                  % Nothing to attack

noattack( X/Y, [X1/Y1 | Others] )  :-
  Y =\= Y1,                         % Different Y-coordinates
  Y1-Y =\= X1-X,                    % Different diagonals
  Y1-Y =\= X-X1,
  noattack( X/Y, Others).


% A solution template

template( [1/Y1,2/Y2,3/Y3,4/Y4,5/Y5,6/Y6,7/Y7,8/Y8] ).


% Overall solver

solve( S ) :- template( S ), solution ( S ).

