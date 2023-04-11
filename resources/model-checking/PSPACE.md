# LTL Model Checking is PSPACE complete

(under construction ... dont read yet)

**Problem:** Given a finite state machine (model) $M$ and an LTL-formula $\phi$, determine whether all execution sequences of the model satisfy the formula, in symbols, whether $M\models\phi$.

**Theorem:** The LTL Model Checking problem is PSPACE-complete.

Let us unpack this. This will require quite a lot of definitions, but you will recognize them as variations of definitions we have seen when we discussed NP-completeness.

## PSPACE

**Definition:** A problem is in PSPACE if it is decidable in polynomial space on a deterministic Turing machine.

**Remark:** One can replace deterministic by non-determinstic without changing the class of problems, that is, NPSPACE=PSPACE (Savitch's Theorem).

**Definition:** A problem is PSPACE-hard if all problems in PSPACE are polynomial time reducible to it. A problem is PSPACE-complete if it is PSPACE-hard and in PSPACE.

To understand the class NP, we introduced the problem SAT (satisfiability of Boolean logic) and learned about Cook's theorem stating that SAT is NP-complete. QBF (satisfiability of quantified Boolean formulas) plays a similar role for PSPACE.

## QBF

**Definition:** Quantified Boolean logic ...

**Observation:** SAT reduces to QBF. Indeed, if $\phi$ is a Boolean formula with propositional variables $x,y,z$ then $\exists x\exists y\exists z\phi$ is a quantified Boolean formula and  $\phi$ is satisfiable if and only if $\exists x\exists y\exists z\phi$.

A similar observation shows that co-NP is in PSPACE. Indeed if $\phi$ is a Boolean formula with propositional variables $x,y,z$ then $\phi$ is a tautology if and only if $\forall x\forall y\exists z\phi$ satisfiable if and only if $\exists x\exists y\exists z\phi$.

QBF is in PSPACE essentially for the same reason that SAT is in NP: Whether a given valuation evaluates to true can be checked in polynomial space.

**Proposition:** Quantified Boolean logic is in PSPACE.

*Sketch of Proof:* The 

**Fact:** Satisfiability of quantified Boolean formulas is PSPACE-complete.



<!-->

## References

https://moves.rwth-aachen.de/wp-content/uploads/WS1920/MC/mc2019_handout_lec9.pdf
