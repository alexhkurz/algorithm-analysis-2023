# Lecture by lecture

## Week 1: Introduction 

[Outline of the course](https://hackmd.io/@alexhkurz/BkmoBQUui) and [List of Projects](https://hackmd.io/@alexhkurz/B1BVO6Bjj).

## Week 2: DFAs and NFAs 

(automata)

As a scaffolding for the lectures on DFAs and NFAs I use my notes entitled [A Short Introduction to Automata](https://hackmd.io/@alexhkurz/HylLKujCP). These notes are not self-contained so attending the lectures is essential. If anything is unclear ask questions in class or office hours. Assignment available on Canvas.

## Week 3: Knowledge Representation and Logic Programming

(logic)

Questions of knowledge representation underly many areas such as data bases, expert systems, semantic web, ontologies, automated reasoning. This week we will learn the *query-answering algorithm* of the best-known logic programming language, Prolog.

I believe my notes linked below explain all the technicalities relevant for the assignment, but for motivation, background and general information you need to come to the lectures. The assignment is pen-and-paper, but for the full experience I recommend to [download and install](https://www.swi-prolog.org/download/stable) Prolog. You can follow along and run [the example programs](resources/Logic/logic-programming/src) I use in class. 

[Introduction to Logic Programming](resources/Logic/logic-programming/slides/LP1-introduction-to-logic-programming.pdf) explains the basics. To follow the question-answering algorithm step-by-step learn [How to Trace an Execution](resources/Logic/logic-programming/trace.pdf) using SWI-Prolog. From [Function Symbols and Lists](resources/Logic/logic-programming/slides/LP2-function-symbols-and-lists.pdf) we only need the first slide, the rest is optional.

To explain the algorithms, unification and resolution, in a short and concise way we *create a problem specific language*,  see [Definitions](resources/Logic/logic-programming/slides/LP3-definitions.pdf) and Slides 1-3  of [Unification](resources/Logic/logic-programming/slides/LP4-unification.pdf). The unification algorithm itself you find on Slides 4-5, followed by some examples.

To convince you that the *problem specific language* we created occupies the sweet spot between problem and implementation, compare Slides 4-5 above with Slides 2-3 of an [Implementation of Unification in Haskell](resources/Logic/logic-programming/slides/LP4b-unification.pdf). The point here is that up to small syntactic details, the Haskell code matches the pseudo code almost exactly (and, of course, the Haskell code runs). To drive it home, after creating the right *problem specific language* it is possible to write a complete Prolog interpreter in just a few lines of code.

Finally, we learn how [resolution](resources/Logic/logic-programming/slides/LP5-resolution.pdf) works and how to draw SLD-trees. The algorithm is described on slides 1-5, followed by a number of examples.
    
To test your understanding of unification and resolution answer the questions of the [Worksheet](resources/Logic/logic-programming/worksheet.pdf).

## Week 4: Distributed Hash Tables

(concurrency)

- L 4.1:
    - Review of and [feedback on the homework](feedback-for-homework.md) on finite automata.
    - [Introduction to IPFS](https://hackmd.io/@alexhkurz/rJMmmc-0o).
- L 4.2: [Slides](https://hackmd.io/@alexhkurz/S1pML4xCs#). 

## Week 5: Undecidability and NP-Completeness  

(automata)

- L 5.1: [Computability, Turing Machines, Undecidability](https://hackmd.io/@alexhkurz/SyD42sbRs) ... [The Proof of the Undecidability of the Halting Problem](resources/Automata/Halting%20Problem.pdf)

- L 5.2: [Complexity Theory, P vs NP](https://hackmd.io/@alexhkurz/Hk0O2lPCj)

## Week 6: SAT-solvers

(logic)

- L 6.1: We started with [feedback for homework week 3](feedback-for-homework.md) and spent some time revising unification and resolution. 

  - [unifiation exercises](resources/Logic/logic-programming/unification-exercises.pdf), with [solutions](resources/Logic/logic-programming/unification-solutions.pdf);  
  - [resolution exercises](resources/Logic/logic-programming/resolution-exercises.pdf), with [solutions](resources/Logic/logic-programming/resolution-solutions.pdf); 

  We emphasized how, at a high level of abstraction, the topics of Week 2 (Database Query Answering), Week 5 (NP-completeness) and Week 6 (SAT-solvers) are the same.

- L 6.2: How to use propositional logic to [encode and solve Sudoku with a SAT-solver](https://users.aalto.fi/~tjunttil/2020-DP-AUT/notes-sat/solving.html). We also learned how to execute pen-and-paper a simple algorithm for SAT known as [indirect truth tables](https://hackmd.io/@alexhkurz/ByaOUajy2).

## Week 7: The CAP Theorem 

(concurrency)

History is the science of how societies change. If you want to be able to look beyond the hype of the day and see the long-term trends it is important to get a sense of the history of a subject. We use the topic of this week to practice some methods that help us to gain a deeper historical understanding of distributed systems.

- L 7.1: Based on the list of publications of [Leslie Lamport](https://lamport.azurewebsites.net/pubs/pubs.html) I made some remarks on the early history of concurrency and distributed systems. We then read in some detail parts of [Time, Clocks and the Ordering of Events in a Distributed System](resources/Concurrency/Lamport-time-clocks.pdf) (ignore the highlights which I only made to help me structure the lecture.)

- L 7.2: Most of the lecture was based on [Susan Davidson etal](resources/Concurrency/CAP%20theorem/Susan%20Davidson%20etal%20-%20Consistency%20in%20a%20Partitioned%20Network-A%20Survey%201984.pdf) (read Introduction and Sections 1 and 2). We had a brief look at [Brewer](resources/Concurrency/CAP%20theorem/Eric%20Brewer-Towards%20robust%20distributed%20systems.pdf) and [Gilbert and Lynch](resources/Concurrency/CAP%20theorem/Gilbert%20Lynch%20CAP%20theorem.pdf).

  For further reading I recommend Brewer's [CAP Twelve Years Later: How the "Rules" Have Changed](https://www.infoq.com/articles/cap-twelve-years-later-how-the-rules-have-changed/).

## Week 8: Big-O and Time Complexity

(automata)

- L 8.1: We started with feedback for [HW6](https://hackmd.io/@alexhkurz/ByaOUajy2) and also presented another version of satisfiability called [propositional tableaux](resources/Logic/logicnotes-tableaux.pdf). After that we introduced the [Big-O notation](resources/Automata/logicnotes-big-O.pdf) at the hand of [Bubble Sort](https://hackmd.io/@alexhkurz/rk314el-n).

- L 8.2 was based on these notes on [Complexity Theory](https://hackmd.io/@alexhkurz/rJCjGUz-3).

## Week 9: Model Checking

(concurrency and logic)

- L 9.1: [Model Checking with Spin - Tutorial 1 (Mutual Exclusion)](resources/model-checking/MutexExamples.md).
- L 9.2: [Model Checking with Spin - Tutorial 2 (Needham-Schroeder)](resources/model-checking/Needham-Schroeder.md).

## Week 10: Temporal Logic and Space Complexity

(logic and automata)

- L 10.1: [Satisfiability of Linear Temporal Logic](resources/model-checking/LTL.md)
- L 10.2: [LTL Model Checking is PSPACE-complete](https://hackmd.io/@alexhkurz/rkGoxQSz3)

## Week 11: Regular Expressions

(automata)

- L 11.1: [Composing Automata](https://hackmd.io/@alexhkurz/HyDaYbnzn)
- L 11.2: [Regular Expressions](https://hackmd.io/@alexhkurz/rJEjuGhMn)

## Week 12: Concurrent Algorithms and Data Structures

(concurrency and logic)

- L 12.1: [Atomicity, Sequential Consistency and Weak Memory](https://hackmd.io/@alexhkurz/ryEdSuVXh). We exhibit a program showing that the memory model of Java is not sequentially consistent, that is, may reorder instructions in a way that allows "impossible" or "inconsistent" results.
- L 12.2: [Safety, Liveness, Fairness](https://hackmd.io/@alexhkurz/SkndPww7n). 

## Week 13: Semantic Web 

(logic and concurrency)

How does the WWW work? What is the Semantic Web? What is the business model of platforms and to what do they owe their success? Is censorship unavoidable in a centralized system? What can be decentralized? 

The [slides](https://hackmd.io/@alexhkurz/HyjfN2pmn) only scratch the surface of these questions. From a technical point of view we learn about RDF and SPARQL and briefly mention ontologies. The lectures also hinted at (existing and potential) ramifications of this technology in business and society. (While, in these lectures, we steer clear of blockchain technologies they do play an important role in addressing the wider questions.)

## Week 14: Project Presentations






