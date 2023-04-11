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
	user-defined names starting with a lower-case letter (propositional variables)

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

$$\phi::= p\mid \neg\phi \mid \phi\wedge\phi\mid \Box\phi \mid \Diamond\phi$$

where $p$ is a propositional variable (such as `success` or `aliceBob` or `bobAlice`) chosen from a given set $\mathbb P$.

**Remark:** All other Boolean operators such as disjunction and implication can be defined from $\neg$ and $\wedge$. 

**Precedence rules:** To save brackets, we say
that the unary operators bind stronger than $\wedge,\vee$ which bind stronger than $\to$ which binds
stronger than $\leftrightarrow$. For example, $$\neg p\wedge \Box
r \wedge s \to t \leftrightarrow u$$
is bracketed as $$(((\neg p\wedge \Box r) \wedge s) \to t) \leftrightarrow u$$

**Remark:** (I had planned to explain the following from [LTL syntax according to the Spin manual](http://spinroot.com/spin/Man/ltl.html) but then skipped it. To summarize: The next-time operator `X` is useful for the understanding and implementation of LTL, but not so useful for applications to software engineering.)

```
NOTES
If the Spin sources are compiled with the preprocessor directive -DNXT, the set of temporal operators is extended with one additional unary operator: X (next). The X operator asserts the truth of the subformula that follows it for the next system state that is reached. The use of this operator can void the validity of the partial order reduction algorithm that is used in Spin, if it changes the stutter invariance of an LTL formula. For the partial order reduction strategy to be valid, only LTL properties that are stutter invariant can be used. Every LTL property that does not contain the X operator is guaranteed to satisfy the required property. A property that is not stutter invariant can still be checked, but only without the application of partial order reduction.
```

## Semantics of LTL

The semantics of LTL-formulas is defined by recursion over the structure of formulas. This means that for each case of the syntax definition

$$\phi::= p \mid \neg\phi \mid \phi\wedge\phi \mid \Box\phi \mid \Diamond\phi$$

we will have a corresponding case for the semantics definition.

Before we can give the definition of the semantics, we need to define what a sequence of states (or execution sequence) is. 

**Convention:** $\mathbb N=\{0,1,2\ldots\}$ denotes the set of
  natural numbers; $(v_n)_{n\in\mathbb N}$, or $(v_n)$, is short
  for $(v_0,v_1,v_2\ldots)$.

**Remark:** In logic, we call  **model** the data needed to evaluate a formula. In Boolean logic, a model is an assignment 

$$v: \mathbb P \to \mathbb 2$$

from the set of propositional variables $\mathbb P$ to the set of truth values $\mathbb 2=\{0,1\}$.  In linear temporal logic, a model is a sequence 

$$v_n: \mathbb P \to \mathbb 2$$

of such valuations, with the $n\in\mathbb N$ being understood as points in time.

In general, given a model $M$ and a formula $\phi$, we write

$$M\models \phi$$

to say that $\phi$ evaluates to true in the model $M$.

**Semantics of LTL:** Let $S=(v_n)_{n\in\mathbb N}$
be a sequence of valuations $v_n:\mathbb P\to \mathbb 2$.
- $S,n\models p $ if $v_n(p)=1$,
- $S,n\models \neg \phi\quad$ if not $S,n\models\phi$,
- $S,n\models \phi\wedge\psi\quad$ if $S,n\models\phi$ and $S,n\models\psi$,
- $S,n\models\Box\phi\quad$ if $S,m\models\phi$ for all $m\ge n$,
- $S,n\models\Diamond\phi\quad$ if $S,m\models\phi$ for some $m\ge n$.

The first item can be understood as looking up the value of $p$ in memory at time $n$. Items 2 and 3 are essentially the truth tables for negation and conjunction. Items 4 and 5 make precise what we mean by "always" ($\Box$) and "eventually" ($\Diamond$).

So far we defined $\models$ in the case where a model is a sequence of valuations plus a point in time. If we don't specify a point in time, we take the initial point $0$:

$$S\models\phi \stackrel{\rm def}{\ \Leftrightarrow \ } S,0\models\phi$$

Finally, if we have a program `prog.pml`, then we define 

$${\tt prog.pml}\models\phi \stackrel{\rm def}{\ \Leftrightarrow \ } S\models\phi \textrm{\quad for all execution sequences S of {\tt prog.pml}}$$


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
- $\Box\Diamond p\to\Diamond\Box p$


To answer the questions above, we reason with infinite sequences. It is not immediately clear how one can turn this into an algorithm but it is possible because, in each of the problems, all relevant infinite sequences are generated by a finite state machine. We will come back to this below.

## Model Checking LTL-formulas with Spin

Spin can be considered as a SAT-solver for temporal logic, which, in addition, also takes into account a finite state machine (model). Let us recall from the Needham-Schroeder example last week:

- The protocol was formalized as the model `ns.pml`.
- The property in question was formalized as `[](success -> (bobAlice -> aliceBob))`
- The attack was a an execution sequence that both "satisfied" the model (protocol) and the LTL-formula `![]](success -> (bobAlice -> aliceBob))` (note the negation).

Let us check that the following commands allow us to find the attack on `ns.pml`:

```
spin -f '![](success && bobAlice -> aliceBob)' > neverclaim
spin -N neverclaim -a ns.pml  
cc -o pan pan.c
./pan -a
```

(With `spin -M -t ns.pml` we can verify that we found the familiar man-in-the-middle attack.)

With what we learned about LTL now, we can have a look under the hood. 

For historical reasons, Spin's internal representations of LTL-formulas are known as *never claims*. `spin -f` translates a formula into this internal representation. In our case I decided to call it `neverclaim` and we can inspect it.

```c
never  {    /* ![](success && bobAlice -> aliceBob) */
T0_init:
	do
	:: atomic { (! ((aliceBob)) && (bobAlice) && (success)) -> assert(!(! ((aliceBob)) && (bobAlice) && (success))) }
	:: (1) -> goto T0_init
	od;
accept_all:
	skip
}
```

This is a finite state machine that is in an infinite loop from which it can only escape in a state in which `! ((aliceBob)) && (bobAlice) && (success))` is true. In this case, `assert` is trying to assert a formula that is false (which breaks the loop) and Spin outputs the execution sequence it found at that point.

## Satisfiability Checking of LTL-formulas with Spin

One can adapt the previous section to the case where one has no model and only a formula. One way of doing this is to create a model that does not restrict the set of all execution sequences.

For example, if the formula only uses propositional variables `p`, we can use [`allp.pml`](../model-checking/src/allp.pml)

```c
bool p; 

active proctype all() {
    do
    :: true -> p = !p; printf("p: %d\n", p);
    :: true -> skip; printf("p: %d\n", p);
    od;
}
```

and then go through the exercise above, replacing `formula` below accordingly.

```
spin -f '!formula' > neverclaim
spin -N neverclaim -a allp.pml  
cc -o pan pan.c
./pan -a
```

For example, to prove that $\Diamond\Box p \to \Box\Diamond p$ is valid, we run

```
spin -f '!(<>[]p -> []<>p)' > neverclaim
spin -N neverclaim -a allp.pml  
cc -o pan pan.c
./pan -a 
```

Or, to show that $\Box\Diamond p\to\Diamond\Box p$ is not valid, run

```
spin -f '!([]<>p-><>[]p)' > neverclaim
spin -N neverclaim -a allp.pml  
cc -o pan pan.c
./pan -a 
```

The counter-example in `all.pml.trail` can be inspected with `spin -t all.pml`. In the example above it looks like

```
  <<<<<START OF CYCLE>>>>>
          p: 1
          p: 0
```

**Exercise:** Why is that a counter-example to $\Box\Diamond p\to\Diamond\Box p$?

