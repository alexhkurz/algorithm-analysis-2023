# Lecture by lecture

## Week 1: Introduction 

[Outline of the course](https://hackmd.io/@alexhkurz/BkmoBQUui) and [List of Projects](https://hackmd.io/@alexhkurz/B1BVO6Bjj).

## Week 2: DFAs and NFAs 

As a scaffolding for the lectures on DFAs and NFAs I use my notes entitled [A Short Introduction to Automata](https://hackmd.io/@alexhkurz/HylLKujCP). These notes are not self-contained so attending the lectures is essential. If anything is unclear ask questions in class or office hours. Assignment available on Canvas.

## Week 3: Knowledge Representation and Logic Programming

Questions of knowledge representation underly many areas such as data bases, expert systems, semantic web, ontologies, automated reasoning. In this section we will learn a the query-answering algorithm of logic programming. 

I believe my notes linked below explain all the technicalities you need to know, but for motivation, background and general information you need to come to the lectures. The assignment is pen-and-paper, but for the full experience I recommend to [download and install](https://www.swi-prolog.org/download/stable) Prolog. You can follow along and run [the example programs](https://github.com/alexhkurz/algorithm-analysis-2023/tree/main/logic-programming/src) I use in class. 

You find the basics in [Introduction to Logic Programming](logic-programming/slides/LP1-introduction-to-logic-programming.pdf). To follow the question-answering algorithm step-by-step learn [How to Trace an Execution](logic-programming/trace.pdf) using SWI-Prolog.From [Function Symbols and Lists](logic-programming/slides/LP2-function-symbols-and-lists.pdf) we only need the first slide, the rest is optional.

To explain the algorithms, unification and resolution, in a short and concise way we *create a problem specific language*, which we do in [Definitions](logic-programming/slides/LP3-definitions.pdf) and in Slides 1-3 [Unification](logic-programming/slides/LP4-unification.pdf). The unification algorithm itself you find on Slides 4-5, followed by some examples.

To convince you that the *problem specific language* we created occupies the sweet spot between problem and implementation, compare Slides 4-5 above with Slides 2-3 of [Implementation of Unification in Haskell](logic-programming/slides/LP4b-unification.pdf)

Finally, we learn how resolution works and how to draw SLD-trees in [Resolution](logic-programming/slides/LP5-resolution.pdf).
    
[Worksheet](logic-programming/worksheet.pdf)

---

Upcoming:

- Week 4: Distributed Hash Tables



