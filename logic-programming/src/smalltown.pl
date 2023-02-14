/*
    Route finding in Smalltown.
*/

%%% The map %%%

go(east, hospital, station).
go(east, cinema, high_st).
go(east, library, clock_tower).
go(east, ash_road, school).
go(east, station, park).
go(east, high_st, town_hall).
go(east, clock_tower, market).
go(east, school, dog_and_duck).
go(east, park, university).
go(east, town_hall, queens_st).
go(east, market, post_office).
go(east, dog_and_duck, church).

go(north, ash_road, library).
go(north, school, clock_tower).
go(north, dog_and_duck, market).
go(north, church, post_office).
go(north, library, cinema).
go(north, clock_tower, high_st).
go(north, market, town_hall).
go(north, post_office, queens_st).
go(north, cinema, hospital).
go(north, high_st, station).
go(north, town_hall, park).
go(north, queens_st, university).

go(west, X,Y) :- go(east, Y,X).
go(south,X,Y) :- go(north,Y,X).


%%% The near predicate %%%

near(X,Y) :- go(_,X,Y).
near(X,Y) :- perp(D1,D2), go(D1,X,Z), go(D2,Z,Y).

perp(north,east).
perp(north,west).
perp(south,east).
perp(south,west).


%%% Walk in one direction %%%

walk(_,X,X).
walk(Dir,X,Y) :- go(Dir,X,Z), walk(Dir,Z,Y).

walk1(Dir,X,Y) :- go(Dir,X,Y).
walk1(Dir,X,Y) :- go(Dir,X,Z), walk1(Dir,Z,Y).


%%% Walk in two orthogonal directions %%%

walk2(D1,D2,X,Y) :- perp(D1,D2), walk(D1,X,Z), walk(D2,Z,Y).


%%% Follow a given list of directions %%%

route(X,X,[]).
route(X,Y,[D|Ds]) :- go(D,X,Z), route(Z,Y,Ds).


%%% Find a list of directions %%%

steps(_,X,X,[]).
steps(D,X,Y,[D|Ds]) :- go(D,X,Z), steps(D,Z,Y,Ds).

steps2(X,Y,Ds) :- perp(D1,D2), steps(D1,X,Z,Bs), steps(D2,Z,Y,Cs),
                  append(Bs,Cs,Ds).


%%%%%%%%%%%
%%% End %%%
%%%%%%%%%%%
