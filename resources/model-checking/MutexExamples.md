# Model Checking with Spin - Tutorial 1 (Mutual Exclusion)

<b>We start this tutorial with programs that are easy, so that we can learn the behaviour of the tool on simple examples 
([mutex.try1.pml](src/mutex.try1.pml), [mutex.try2.pml](src/mutex.try2.pml)). 
Here it is important to understand that we can use SPIN in simulation mode and in verification mode (see below).
We finish the tutorial with two examples that are less simple, namely <a href="src/mutex.peterson-a.pml">mutex.peterson-a.pml</a> and 
<a href="src/mutex.peterson-b.pml">mutex.peterson-b.pml</a>. They look almost the same, but are they both correct? </b>

Our first try of programming mutual exclusion is translated into
Promela as [mutex.try1.pml](src/mutex.try1.pml) (There is
also a slightly different implementation, [mutex.try1-simplified.pml](src/mutex.try1-simplified.pml), of the same algorithm.) 

Promela is a pretty straightforward programming language with some special features
for non-determinism, which I will summarise now. Looking at [mutex.try1-simplified.pml](src/mutex.try1-simplified.pml)

```c
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

- 2 active processes. All active processes will be executed in
parallel (instead of "in parallel" one also says "concurrently"); if
several processes have an enabled command, one of the processes is
scheduled (chosen) non-deterministically. 
- It is very important to
understand the concept of non-determinism here. (You already have
learned a non-determinstic algorithm in the course, namely
propositional semantic tabeleau.) You may also look at <a href="http://en.wikipedia.org/wiki/Nondeterministic_algorithm">Wikipedia's
article</a>.</li>



