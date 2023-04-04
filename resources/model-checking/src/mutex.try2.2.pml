/* mutex, second try with assertion, for 2 processes */

bool	turn;
byte	count;

active [2] proctype P1()
{	    pid me, other;

	    me = _pid;
	    other = 1 - _pid;

again:	turn = other;
        ! (turn==other) ->

        /* begin critical section */
	    count++;
	    printf("in the critical section, count==%d\n",count); 
        assert(count == 1); 
        count--;
	    /* end critical section */

	    goto again
}



