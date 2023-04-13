# LTL Model Checking is PSPACE-complete

(under construction ... dont read yet)

**Problem:** Given a finite state machine (model) $M$ and an LTL-formula $\phi$, determine whether all execution sequences of the model satisfy the formula, in symbols, whether $M\models\phi$.

**Theorem:** The LTL Model Checking problem is PSPACE-complete.

Let us unpack this. This will require quite a lot of definitions, but you will recognize them as variations of definitions we have seen [when we discussed NP-completeness](https://hackmd.io/@alexhkurz/Hk0O2lPCj).

## PSPACE

**Definition:** A problem is in PSPACE if it is decidable in polynomial space on a deterministic Turing machine.

**Remark:** (Savitch's Theorem) One can replace deterministic by non-determinstic without changing the class of problems, that is, NPSPACE=PSPACE (Sipser, Theorem 8.5, page 306). The proof of this result contains a surprise, because it shows that if the non-determinstic TM (NTM) uses $O(f(n))$ space then there is a determinstic TM (DTM) that uses not more than $O(f^2(n))$ space. [^Savitch]

[^Savitch]: At first, it seems that turning an NTM into a DTM creates an exponential blow-up. Indeed, if the NTM runs in $f(n)$ space it can make up to $2^{f(n)}$ steps. Now assume for simplicity that at each step it has a binary choice. To turn the non-deterministic computation into a determinstic one, the DTM has to remember up to $2^{f(n)}$ choices, that is, it incurs an exponential blow-up in space.

    Now we come to Savitch's trick. The DTM recursively divides the problem into two smaller subproblems, where it checks if the NTM can get from the starting configuration c1 to an intermediate configuration cm within t/2 steps, and if the NTM can get from the intermediate configuration cm to the final configuration c2 within t/2 steps. 

    To understand the space usage of the DTM, let's analyze the algorithm's depth and space usage at each level of the recursion.

    1. Depth of recursion: Since the algorithm divides the problem in half at each level of recursion, the maximum depth of the recursion is $O(\log t)$. 
    2. Space usage at each level: The DTM reuses the space for both recursive calls, hence the space usage at each level of recursion is $f(n)$.

    The total space used by the DTM can be calculated by multiplying the space usage at each level by the depth of the recursion:

    Total space used = Space usage at each level × Depth of recursion = $f(n) \cdot O(\log t) = f(n) \cdot O(\log 2^{O(f(n))}) = O(f(n)^2)$.

**Example:** SAT can be solved in linear space (hence is in PSPACE).

**Example:** All NP-problems are in PSPACE. Intuitively, this is because even if the size of a tree is exponential in the size of the problem, depth-first search never needs to store more than one branch which only requires polynomial space.

**Definition:** A problem is PSPACE-hard if all problems in PSPACE are polynomial time reducible to it. A problem is PSPACE-complete if it is PSPACE-hard and in PSPACE.

To understand the class NP, we introduced the problem SAT (satisfiability of Boolean logic) and learned about Cook's theorem stating that SAT is NP-complete. QBF (satisfiability of quantified Boolean formulas) plays a similar role for PSPACE.

**Remark:** $$\sf P \subseteq NP\subseteq PSPACE=NPSPACE\subseteq EXPTIME$$ and $$P\not= EXPTIME$$

## QBF

**Definition:** Quantified Boolean logic ...

**Observation:** SAT reduces to QBF. Indeed, if $\phi$ is a Boolean formula with propositional variables $x,y,z$ then $\exists x\exists y\exists z\phi$ is a quantified Boolean formula and  $\phi$ is satisfiable if and only if $\exists x\exists y\exists z\phi$.

A similar observation shows that co-NP is in PSPACE. Indeed if $\phi$ is a Boolean formula with propositional variables $x,y,z$ then $\phi$ is a tautology if and only if $\forall x\forall y\exists z\phi$ satisfiable if and only if $\exists x\exists y\exists z\phi$.

QBF is in PSPACE essentially for the same reason that SAT is in NP: Whether a given valuation evaluates to true can be checked in polynomial space.

**Proposition:** Quantified Boolean logic is in PSPACE.

*Sketch of Proof:* The 

**Fact:** Satisfiability of quantified Boolean formulas is PSPACE-complete.


## References

Michael Sipser (2006). [Introduction to the Theory of Computation](https://fuuu.be/polytech/INFOF408/Introduction-To-The-Theory-Of-Computation-Michael-Sipser.pdf), 2nd edition, Chapter 8.3.

https://moves.rwth-aachen.de/wp-content/uploads/WS1920/MC/mc2019_handout_lec9.pdf

<!--
Sipser, Theorem 8.5, Proof Idea:

We need to simulate an f(n) space NTM deterministically. A naive approach is to proceed by trying all the branches of the NTM's computation, one by one. The simulation needs to keep track of which branch it is currently trying so that ti is able to go on to the next one. But a branch that uses f(n) space may run for 2^{O(f(n))) steps, and each step may be a nondeterministic choice Exploring the branches sequentially would require recording all the choices used on a particular branch in order to be able to find the next branch. Therefore this approach may use 2^{O(f(n)))  space, exceeding our goal of O(f^2(n)) space.

Instead, we take a different approach by considering the following more general problem. We are given two configurations of the NTM, c1 and c2, together with a number t, and we must test whether the NTM can get from c1 to c2 within t steps. We call this problem the yieldability problem. By solving the yieldability problem where c1 is the start configuration, c2 is the accept configuration,and t is the maximum number of steps that the nondeterministic machine can use, we can determine whether the machine accepts its input.

We give a deterministic, recursive algorithm that solves the yieldability problem. It operates by searching for an intermediate configuration cm, and recursively testing whether (1) c can get to cm within t/2 steps, and (2) whether cm can get to c2 within t/2 steps. Reusing the space for each of the two recursive tests allows a significant saving of space.

-->
