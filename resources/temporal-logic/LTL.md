# Linear Temporal Logic (LTL)

Last week, in the analysis of the Needham-Schroeder protocol, we have seen how to use temporal logic to express the property that

***always, if both Alice and Bob executed their protocol successfully then, then the partner of Alice is Bob if and only if the partner of Bob is Alice***

(This property states that a man-in-the-middle-attack is not possible.)

This week, we will take a deeper look at the algorithm that allowed us to first find the man-in-the-middle attack on the Needham-Schroeder protocol and then to prove that such an attack on the Needham-Schroeder-Lowe protocol is not possible.

Moreover, this week can be seen as central to this course for a variety of reasons.

For example, this lecture brings together most of the topics of the course.

- From automata theory we take finite state machines (Week 2) as models both of distributed protocols and as models of LTL-formulas.
- From concurrency we take the domains to which we apply LTL (Week 4, 7,9).
- From logic we take the idea that model checking, like query answering (Week 3) and SAT-solving (Week 6), is a particular case of satisfiability. Also remember that satisfiability played a major role in NP-completeness (Week 5).

Moreover, we will encounter again the idea of modelling concurrency via non-determinism (Week 9) and we will see an important example of the complexity class PSPACE (Week 8).

## Introduction

Recall from our earlier work on satisfiability of propositional logic (indirect truth tables, propositional tableaux) that a formula $\phi$ is valid ...