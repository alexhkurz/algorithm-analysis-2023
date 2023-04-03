/* mutex, Peterson */

bool	turn, flag[2];

active [2] proctype P(){	
pid me, other;

	me = _pid;
	other = 1 - _pid;

again:	flag[me]=1;
turno:  turn=other; /* In Spin: 
                       label names must differ from variable names */
wait:   ! (flag[other] && turn == other) ->

        /* begin critical section */
cs:     skip;
	/* end critical section */
        
        flag[me]=0;
          
rest:	goto again
}

#define	p0atagain (P[0]@again)
#define	p1atagain (P[1]@again)

#define	p0atturn (P[0]@turno)
#define	p1atturn (P[1]@turno)

#define	p0atwait (P[0]@wait)
#define	p1atwait (P[1]@wait)

#define	p0atcs (P[0]@cs)
#define	p1atcs (P[1]@cs)

#define	p0atrest (P[0]@rest)
#define	p1atrest (P[1]@rest)

/*

1.

check '[](p0atagain-><>p0atturn)' mutex.peterson.ltl 

  or

check '!<>[]p0atagain' mutex.peterson.ltl

  yield a counterexample.

  Note that 

check '[](p0atagain-><>p0atturn)<->!<>[]p0atagain' mutex.peterson.ltl 

  proves that the two properties are equivalent (for mutex.peterson.ltl).
  And similarly for 2 and 3 below.

2.

check '[](p0atturn-><>p0atwait)' mutex.peterson.ltl

  verifies the property.
      
3.

check '!<>[]p0atcs' mutex.peterson.ltl

  verifies the property.

4.
       
check '[](p0atwait && !p1atwait && !p1atcs ->!(!p0atcs U p1atcs))' mutex.peterson.ltl    

*/



