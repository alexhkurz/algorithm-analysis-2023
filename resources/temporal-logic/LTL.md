# Linear Temporal Logic (LTL)

Last week, in the analysis of the Needham-Schroeder protocol, we have seen how to use temporal logic to express the property that

***always, if both Alice and Bob executed their protocol successfully, then the partner of Alice is Bob if and only if the partner of Bob is Alice.***

(This property states that a man-in-the-middle-attack is not possible.)

This week, we will take a deeper look at the algorithm that allowed us to first find the man-in-the-middle attack on the Needham-Schroeder protocol and then to prove that such an attack on the Needham-Schroeder-Lowe protocol is not possible.

Moreover, this week can be seen as central to this course for a variety of reasons.

For example, this lecture brings together most of the topics of the course.

- From automata theory we take finite state machines (Week 2) as models both of distributed protocols and as models of LTL-formulas.
- From concurrency we take the domains to which we apply LTL (Week 4, 7, 9).
- From logic we take the idea that model checking, like query answering (Week 3) and SAT-solving (Week 6), is a particular case of satisfiability. Also remember that satisfiability played a major role in NP-completeness (Week 5).

Moreover, we will encounter again the idea of modelling concurrency via non-determinism (Week 9) and we will see an important example of the complexity class PSPACE (Week 8).

## Introduction

Recall from our earlier work on satisfiability of propositional logic (indirect truth tables, propositional tableaux) that a formula $\phi$ is valid iff (if and only if) $\neg\phi$ is not satisfiable. We then looked at algorithms (truth tables, indirect truth tables, propositional tableaux) that, given an arbitrary formula $\phi$ find a valuation (also known as a model) that satisfies $\phi$.

To extend this program to LTL, we need to 
- define the language (syntax) of LTL
- define the semantics of LTL (how to evaluate LTL-formulas)
- describe an algorithm for checking the satisfiability of LTL-formulas

## Syntax of LTL

The [LTL syntax according to the Spin manual](http://spinroot.com/spin/Man/ltl.html). I copy over the excerpt that we are going to use.

```
SYNTAX
Grammar:
	ltl ::= opd | ( ltl ) | ltl binop ltl | unop ltl

Operands (opd):
	true, false, user-defined names starting with a lower-case letter

Unary Operators (unop):
	[]	(the temporal operator always)
	<>	(the temporal operator eventually)
	! 	(the boolean operator for negation)

Binary Operators (binop):
	&&	(the boolean operator for logical and)
	||	(the boolean operator for logical or)
	/\	(alternative form of &&)
	\/	(alternative form of ||)
	->	(the boolean operator for logical implication)
	<->	(the boolean operator for logical equivalence)
```

**Remark:** The definition above is in the style typically used in programming languages. There is also a shorter math-style which reads as follows. (Why are we allowed to drop $\to$ and $\leftrightarrow$?)

$$\phi::=\top \mid \bot \mid p \mid \neg\phi \mid
\phi\wedge\phi \mid \phi\mid \Box\phi \mid \Diamond\phi$$

**Precedence rules:** To save brackets, we say
that the unary operators bind stronger than $\wedge,\vee$ which bind stronger than $\to$ which binds
stronger than $\leftrightarrow$. For example, $$\neg p\wedge \Box
r \wedge s \to t \leftrightarrow u$$
is bracketed as $$(((\neg p\wedge \Box r) \wedge s) \to t) \leftrightarrow u$$



We also explained the following remark in [LTL syntax according to the Spin manual](http://spinroot.com/spin/Man/ltl.html). (To summarize: The next-time operator `X` is useful for the understanding and implementation of LTL, but not so useful its applications to software engineering.)

```
NOTES
If the Spin sources are compiled with the preprocessor directive -DNXT, the set of temporal operators is extended with one additional unary operator: X (next). The X operator asserts the truth of the subformula that follows it for the next system state that is reached. The use of this operator can void the validity of the partial order reduction algorithm that is used in Spin, if it changes the stutter invariance of an LTL formula. For the partial order reduction strategy to be valid, only LTL properties that are stutter invariant can be used. Every LTL property that does not contain the X operator is guaranteed to satisfy the required property. A property that is not stutter invariant can still be checked, but only without the application of partial order reduction.
```



## Semantics of LTL

The semantics of LTL-formulas is defined by recursion over the structure of formulas. This means that for each case of the syntax definition

$$\phi::=\top \mid \bot \mid p \mid \neg\phi \mid
\phi\wedge\phi \mid \Box\phi \mid \Diamond\phi$$

we will have a corresponding case for the semantics definition.

Before we can give the definition of the semantics, we need to define what a sequence of states (or execution sequence) is. 

**Convention:** $\mathbb N=\{0,1,2\ldots\}$ denotes the set of
  natural numbers; $(v_n)_{n\in\mathbb N}$, or $(v_n)$, is short
  for $(v_0,v_1,v_2\ldots)$.

**Semantics of LTL:** Let $M=(v_n)_{n\in\mathbb N}$
be a sequence of valuations $v_n:\mathbb P\to \mathbb 2$.
- $M,n\models\top$,
- $M,n\models p $ if $v_n(p)=1$,
- $M,n\models \neg \phi\quad$ if not $M,n\models\phi$,
- $M,n\models \phi\wedge\psi\quad$ if $M,n\models\phi$ and $M,n\models\psi$,
- $M,n\models\Box\phi\quad$ if $M,m\models\phi$ for all $m\ge n$,
- $M,n\models\Diamond\phi\quad$ if $M,m\models\phi$ for some $m\ge n$,



## Checking Satisfiability of LTL

This is similiar to the homework on [indirect truthtables](https://hackmd.io/@alexhkurz/ByaOUajy2) (and also to [propositional tableaux](https://github.com/alexhkurz/algorithm-analysis-2023/blob/main/resources/Logic/logicnotes-tableaux.pdf)), but now extended to temporal logic.

Why are the following valid? Can you prove validity by adapting the indirect truth table from propositional logic? 

- $\Box p \to \Diamond p$
- $\Box\Box p \to \Box p$
- $\Box p \wedge \Box q \to \Box(p \wedge q)$
- $\Diamond\Box p \to \Box\Diamond p$

Give a counter-example to the following.

- $\Diamond p \to \Box p$
- $p \to \Box p$
- $\Diamond p \wedge \Diamond q \to \Diamond(p \wedge q)$

To answer the questions above, we reason with infinite sequences. It is not immediately clear how one can turn this into an algorithm but it is possible because, in each of the problems, all relevant infinite sequences are generated by a finite state machine. We will come back to this below.

## Checking LTL-formulas with Spin

...

## Equivalence between formulas and automata

...

### The automaton of a formula

...

### The formula of an automaton

...



