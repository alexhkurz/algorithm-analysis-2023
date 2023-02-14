/* family.pl Family tree */

parent(arthur,george).
parent(harriet,george).
parent(george,richard).
parent(george,amelia).
parent(george,susan).
parent(matilda,richard).
parent(matilda,amelia).
parent(victoria,susan).
parent(richard,sophie).
parent(richard,joseph).
parent(ellen,sophie).
parent(ellen,joseph).
parent(susan,charles).
parent(walter,charles).

male(arthur).
male(george).
male(richard).
male(joseph).
male(walter).
male(charles).

female(harriet).
female(matilda).
female(victoria).
female(amelia).
female(susan).
female(ellen).
female(sophie).


%%% Defined realtionships %%%

mother(X,Y):- parent(X,Y), female(X).

grandparent(X,Y) :- parent(X,Z), parent(Z,Y).

sibling(X,Y) :- parent(Z,X), parent(Z,Y), X\=Y.

/*

Add some more of your own, and test them out!!

*/

ancestor4(X,Y):-ancestor4(X,Z),parent(Z,Y).
ancestor4(X,Y):-parent(X,Y).

/*

Write ancestor2 and  ancestor3 by ordering the predicates differently and run them on different examples in Prolog. Try to explain the different outputs. Use trace to verify your explanations.

*/

%%%%%%%%%%%
%%% End %%%
%%%%%%%%%%%
