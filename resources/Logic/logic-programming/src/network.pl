addr(a,d).
addr(a,b).
addr(b,c).
addr(c,a).

serv(b).

conn(X,Y):- addr(X,Y).
conn(X,Y):- addr(X,Z), serv(Z), addr(Z,Y).

twoway(X,Y):- conn(X,Y), conn(Y,X).