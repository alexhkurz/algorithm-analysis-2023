# Model Checking with Spin - Tutorial 1 (Mutual Exclusion)

<b>We start this tutorial with programs that are easy, so that we can learn the behaviour of the tool on simple examples 
([mutex.try1.pml](src/mutex.try1.pml), [mutex.try2.pml](src/mutex.try2.pml)). 
Here it is important to understand that we can use SPIN in simulation mode and in verification mode (see below).
We finish the tutorial with two examples that are less simple, namely <a href="src/mutex.peterson-a.pml">mutex.peterson-a.pml</a> and 
<a href="src/mutex.peterson-b.pml">mutex.peterson-b.pml</a>. They look almost the same, but are they both correct? </b>

<p>Our first try of programming mutual exclusion is translated into
Promela as <a href="file:///Users/alexanderkurz/Documents/leicester--CO7209/Material/mutex.try1.pml">mutex.try1.pml</a>. (There is
also a slightly different implementation, 
<a href="file:///Users/alexanderkurz/Documents/leicester--CO7209/Material/mutex.try1-simplified.pml">mutex.try1-simplified.pml</a>, of
the same algorithm.) Promela is a
pretty straightforward programming language with some special features
for non-determinism, which I will summarise now. Looking at the <a href="file:///Users/alexanderkurz/Documents/leicester--CO7209/Material/mutex.try1.pml">mutex.try1.pml</a>, you see 
</p><ul>
<li> 2 active processes. All active processes will be executed in
parallel (instead of "in parallel" one also says "concurrently"); if
several processes have an enabled command, one of the processes is
scheduled (chosen) non-deterministically. 
<ul>
<li>It is very important to
understand the concept of non-determinism here. (You already have
learned a non-determinstic algorithm in the course, namely
propositional semantic tabeleau.) You may also look at <a href="http://en.wikipedia.org/wiki/Nondeterministic_algorithm">Wikipedia's
article</a>.</li>



