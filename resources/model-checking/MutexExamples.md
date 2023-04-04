# Model Checking with Spin - Tutorial 1 (Mutual Exclusion)

(some general introduction about model checking in class ... testing/simulation vs verification ...)

## Introduction

We start this tutorial with programs that are easy, so that we can learn the behaviour of the tool on simple examples 
([mutex.try1.pml](src/mutex.try1.pml), [mutex.try2.pml](src/mutex.try2.pml)). 
Here it is important to understand that we can use SPIN in simulation mode and in verification mode (see below).
We finish the tutorial with two examples that are less simple, namely <a href="src/mutex.peterson-a.pml">mutex.peterson-a.pml</a> and 
<a href="src/mutex.peterson-b.pml">mutex.peterson-b.pml</a>. They look almost the same, but are they both correct? 

## Installing Spin

[Spin](https://spinroot.com/spin/whatispin.html) is an award-winning software tool, a so-called model checker, created by [Gerard Holzman](https://spinroot.com/gerard/). (Btw, I recommend his book "The Early History of Data Networks".) 

To follow this lecture it is not required to [install Spin](https://spinroot.com/spin/Man/README.html#S1). But it is more fun if you do. Download the latest `tar.gz` at https://spinroot.com/spin/Archive/. Then

```
gunzip *.tar.gz
tar -xf *.tar
cd Src*
make
```

Run `spin` (or `./spin`) to check whether the executable has been generated. Put it in your path or simply copy the executable `spin` into a working directory.

Also copy the `.pml` files from [src](src) in your working directory. 

Run `spin mutex.try1.pml` and `spin mutex.try2.pml` for testing (you may have to replace `spin` by `./spin`). (Use control-c to terminate an infinite simulation.)

What do you observe?

## Mutual Exclusion - First Try

(some general background to the mutual exclusion problem in class)

Our first try of programming mutual exclusion is translated into
Promela as [mutex.try1.pml](src/mutex.try1.pml) (There is
also a slightly different implementation, [mutex.try1-simplified.pml](src/mutex.try1-simplified.pml), of the same algorithm.) 

Promela is a pretty straightforward programming language with some special features
for concurrency/non-determinism, which I will summarise now. Looking at [mutex.try1-simplified.pml](src/mutex.try1-simplified.pml)

```C
bool	flag[2];

active [2] proctype P1()
{	pid me, other;

	me = _pid;
	other = 1 - _pid;

again:	flag[me] = true; 
	! flag[other] ->

        /* begin critical section */
	printf("process %d is in the critical section\n",me); 
	/* end critical section */

	flag[me] = false;
	goto again
}
```

you see 

- 2 active processes. All active processes will be executed in parallel (instead of "in parallel" one also says "concurrently"); if several processes have an enabled command, one of the processes is scheduled (chosen) non-deterministically. 
    - It is important to understand that the program above is an abstract model. The aim of the model is to make sure that not both processes can be in the *critical section* at the same time.
    - It is important to understand how the model uses non-determinism to model parallelism/concurrency. 
    - We will learn more about when commands are enabled later. For now it is enough to know that assignments and gotos are always enabled. 
- `_pid` is the process identifier, in the example its value is either 0 or 1. Comparing with [this simplified version](src/mutex.try1-simplified.pml), note how the pid is used cleverly so that the same code can be used for both processes. </li>
- A process has to wait if the current command is an expression such as "! flag[other]" and the expression evaluates to zero. (In other words, if the expression evaluates to zero, then the expression, seen as a command, is not enabled.) This may happen here before the `->`.
    - The symbol "-&gt;" has here the same meaning as ";" but is used, as a matter of style, to indicate that a process may be forced to wait.
    - If all processes have to wait, that is, if no process is enabled, then SPIN sets the predefined variable `timetout` to true. Note that SPIN has no realtime features and `timeout` only means that no process is enabled.

To summarize: 
- The idea of this protocol is that `! flag[other] ->` is false and I have to wait if the other process indicated that it also wants to enter its critical section (that is if `flag[other]==1`). 
- As explained in the [Spin Manual](https://spinroot.com/spin/Man/Manual.html#P): *A condition can only be executed (passed) when it holds. If the condition does not hold, execution blocks until it does.* If all processes block **deadlock** occurs.

**Discussion:** What does this program do? What is good and what is bad? 

These questions can be answered by carefully reading the program and also by using Spin.

## Running Spin in Simulation Mode

(if you installed Spin you can follow along on your machine ... run several simulations and compare)

```
spin mutex.try1.pml
          process 1 is in the critical section
      process 0 is in the critical section
          process 1 is in the critical section
      process 0 is in the critical section
      process 0 is in the critical section
      timeout
#processes: 2
                flag[0] = 1
                flag[1] = 1
 31:    proc  1 (P1) line  13 "mutex.try1.pml" (state 4)
 31:    proc  0 (P1) line  13 "mutex.try1.pml" (state 4)
2 processes created
```

**Remark:**

- Spin without any option is doing a simulation run. Repeating the execution will (probably) result in a different simulation.
- The output of the program is produced by the `printf` statement in the code. Each process that is created receives a number (`pid`), the first process created has pid 0, the second 1, etc. By default, Spin formats
the output of the processes in columns, the indentation being proportional to the value of pid.
- `timeout` means that no process is enabled, that is, all process are blocked (in this case: deadlock)

## Running Spin in Verification Mode

()

```
spin -a mutex.try1.pml
cc -o pan pan.c
./pan 
    pan:1: invalid end state (at depth 7)
    pan: wrote mutex.try1.pml.trail

    (Spin Version ... IGNORE ALL THE OUTPUT FOLLOWING FROM HERE ...
```

**Remark:**

- the option `-a` runs Spin in verification mode (the <a href="http://www.spinroot.com/spin/Man/Spin.html">list of options</a> for spin). It produces a C-file pan.c, which is then compiled. The **verifier** is then run using "./pan" as opposed to "pan", since the latter may (on some systems) execute a different program of the same name.
- "invalid end state" is SPIN terminology for deadlock (what
would be valid endstates?)
- the example execution (error trace) leading to the deadlock is contained in  the file `mutex.try1.pml.trail`

Before we look at the error trace let us check whether there is a shorter execution sequence.

```
cc -DREACH -o pan pan.c
./pan -i -m7
    error: max search depth too small
    pan:1: invalid end state (at depth 3)
    pan: wrote mutex.try1.pml.trail
    pan: reducing search depth to 4
```

**Remark:**
- `-D` allows to compile with different options (also called
  directives), see <a href="http://www.spinroot.com/spin/Man/Pan.html#B">the manual</a> for a list of options for pan. `REACH` arranges for the verifier to record the depth a reachable state is found at and the option -i sees to it that this information is used to iteratively search for the shortest error trace. `-m7` sets a limit of `7` to the maximum search depth.
-  `error: ...` there exist executions longer than the depth limit of 14 steps (this can be ignored)
- `pan: ...` an error trace of length 4 is found and stored in the file `mutex.try1.pml`

Now let us look at the error trace.

```
spin -p -t mutex.try1.pml
  1:	proc  1 (P1:1) mutex.try1.pml:8 (state 1)	[me = _pid]
  1:	proc  1 (P1:1) mutex.try1.pml:9 (state 2)	[other = (1-_pid)]
  2:	proc  0 (P1:1) mutex.try1.pml:8 (state 1)	[me = _pid]
  2:	proc  0 (P1:1) mutex.try1.pml:9 (state 2)	[other = (1-_pid)]
  3:	proc  1 (P1:1) mutex.try1.pml:11 (state 3)	[flag[me] = 1]
  4:	proc  0 (P1:1) mutex.try1.pml:11 (state 3)	[flag[me] = 1]
spin: trail ends after 4 steps
#processes: 2
		flag[0] = 1
		flag[1] = 1
  4:	proc  1 (P1:1) mutex.try1.pml:12 (state 4)
  4:	proc  0 (P1:1) mutex.try1.pml:12 (state 4)
2 processes created
```

**Remark:**
- `-t` performs a guided simulation following the error trace in the corresponding `.trail` file (`t` for trail or trace).
- `-p` is responsible for all of the output apart from the last line (`p` for print). This also works in simulation mode: try `spin -p mutex.try1.pml`
- If you want to dig into the details, you should read the output of Spin next to the program and match the two. Can you explain all the details of the output? For example, what is called "state" by Spin is the program counter local to each process. To see this more clearly, run [mutex.try1-simplified.pml](src/mutex.try1-simplified.pml) instead and compare the numbers of the states in the output of Spin with the numbers of the labels of the program.

## Mutual Exclusion - Second Try

The second try solves the problem of the first one, but has its own shortcomings.

```c
bool    turn;

active [2] proctype P1()
{       pid me, other;

        me = _pid;
        other = 1 - _pid;

again:  turn = other;
        ! (turn==other) ->

        /* begin critical section */
        printf("in the critical section\n");
        /* end critical section */

        goto again
}

```

What does this program do? What is good and what is bad? 

**Discussion:** Discuss the respective (dis)advantages of the two tries. What ideas to make progress on the problem does this suggest?

## Analysing the Second Try with Spin

The idea is to repeat the anlysis from the previous section [mutex.try2.pml](src/mutex.try2.pml). 

```
spin mutex.try2.pml | more
          in the critical section
      in the critical section
          in the critical section
      in the critical section
          in the critical section
```

**Remark**
- `| more` stops the display of output when the terminal is full. To exit `more` type `q`, to see more of the output use the return key.
- The different indentations show that the two processes alternate in accessing the critical section.

**Discussion:** Interpret the output of the simulation.

**Question:** The simulation suggests, but does not prove, that mutual exclusion is guaranteed. Can we use Spin's verification mode to verify that mutual exclusion is guaranteed in **all** executions?

The answer is "yes" and the idea how to do it is to insert an assertion into the program. This insertion can then be verified by Spin.

**Discussion:** Explain the purpose of the `assert` in [`mutex.try2.2.pml`](src/mutex.try2.2.pml). What is the variable `count` counting? What is the assertion asserting? Here is the code:
```c
bool	turn;
byte	count;

active [2] proctype P1()
{       pid me, other;

        me = _pid;
        other = 1 - _pid;

again:	turn = other;
        ! (turn==other) ->

        count++;
        printf("in the critical section, count==%d\n",count); 
        assert(count == 1); 
        count--;

        goto again
}
```

Ok, let us run a simulation first:

```
spin mutex.try2.2.pml | more
          in the critical section, count==1
      in the critical section, count==1
          in the critical section, count==1
      in the critical section, count==1
          in the critical section, count==1
```

**Question:** What can we observe about the value of `count`?

But this is not a proof that `count` will always be `1`. From what we have seen so far, there still could be an execution (simulation) in which `count` is greater than `1`.

So let us run Spin in verification mode:

```
spin -a mutex.try2.2.pml
cc -o pan pan.c        
./pan

(Spin Version 6.5.1 -- 20 December 2019)
```

No assertion violation is recorded. **This proves that none of the infinitely many execution sequences of [`mutex.try2.2.pml`](src/mutex.try2.2.pml) violates mutual exclusion.** To see what happens if there is some execution sequence that violates the assertion, let us compare this with [`mutex.stupid.pml`](src/mutex.stupid.pml).

```c
spin -a mutex.stupid.pml
cc -o pan pan.c
./pan                   
    pan:1: assertion violated (cnt==1) (at depth 7)
    pan: wrote mutex.stupid.pml.trail

    (Spin Version 6.5.1 -- 20 December 2019)
```

To summarise the above, we have seen examples of how to use Spin in order to prove that no "bad" execution sequence exists.  Now we will look in more detail on how to find a "bad" execution sequence and how to use it to debug our code.

The idea is to use mutex.try1, which guarantees mutual exclusion but can deadlock, together with mutex.try2, which is used to resolve the deadlock in case both processes want to enter their critical section simultaneously.

## Mutual Exclusion - Third and Fourth Try

It is tempting to think that, as both `mutex.try1` and `mutex.try2` guarantee mutual exclusion and as their defiencies are orthogonal, one may obtain a correct algorithm by combining the two into one. But careful, there are (at least) two different possibilities, namely [mutex.peterson-a.pml](src/mutex.peterson-a.pml) and [mutex.peterson-b.pml](src/mutex.peterson-b.pml).

**Exercise:** Use the methodology learned in this lecture to analyse the two versions above and determine which works and why. Can you give a pen-and-paper proof for the correctness of the one that works as expected?

Here are some ideas to guide your analysis: 
- Run simulations first. 
- Describe your findings.
- Use the verifier. 
- Produce a shortest error trail. 
- Explain the error trail by simultaneously reading the error trail and the program. 
- Explain the differences of the programs. 
- Explain how such a small difference in the code can lead to such different behaviour.




## Summary of Commands


```
# simulation run

spin mutex.try1.pml

############################################
# verification mode with option -a
# produces a C program pan.c 
# which is compiled with cc into a file pan
# and executed via ./pan

spin -a mutex.try1.pml
cc -o pan pan.c
./pan 

############################################
# first three lines are as above
# the next two find the shortest error trace
# (the `7` is derived from the output of `.pan`)
# the last line displays the error trace

spin -a mutex.try1.pml
cc -o pan pan.c
./pan 
cc -DREACH -o pan pan.c
./pan -i -m7
spin -p -t mutex.try1.pml
```

## References

Gerard Holzmann. [The Spin Model Checker](https://spinroot.com/spin/Doc/Book_extras/index.html), Chapter 2.






