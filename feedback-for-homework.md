# Feedback for Homework

## Week 6

... 

## Week 5

To prove that a problem L is NP-complete it suffices to 
- show that L is in NP (usually easy)
- reduce SAT to L (may require clever coding)

Alternatively, instead of SAT, one can use another problem known to be NP-complete.

Similarly, to prove that a problem L is undecidable, reduce the halting problem to L (not the other way round).


## Week 4

I was very happy with the homework on DHTs and key based routing. I gave some individual feedback on the discussions posts on the examples of DHT applications.

## Week 3

One of the aims of this week's homework was to practice executing algorithms pen-and-paper. It is important that after discussing the homework in class you go back to your work and revise it.

I gave the full 2 points for a reasonable effort to understand the algorithm. This does not necessarily mean that your solution is correct. You should revise your answers after the feedback session in class. See also lecture-by-lecture for links.

Recall that you can use Prolog to check the correctness of your solution (exception: Prolog does not implement the occurs-check).

### Unification

Don't forget to write out the MGU and the common instance.

Make sure to write out substitutions as we learned in class, eg $f(a,X)/Y$, not $Y/f(a,X)$.

### Resolution

Make sure that you follow the algorithm when drawing the trees. Also revise the examples, we have done in class.

## Week 2

In class, I went carefully through another example of converting an NFA to a DFA. The NFA was specified by: *All words that start and end with `a` or only consists of `b`.* We used this example to also review the whole process

    specification (language) -> NFA -> DFA -> implementation

I emphasized that one needs to first construct the DFA in table form and then draw it out as a picture.

We also discussed what consists only of `b`s means and revised the logical meaning of "for all" and "implication".

