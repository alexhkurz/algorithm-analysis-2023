/* mutex, second try, for 2 processes */

bool	turn;

active [2] proctype P1()
{	pid me, other;

	me = _pid;
	other = 1 - _pid;

again:	turn = other;
        ! (turn==other) ->

        /* begin critical section */
	printf("in the critical section\n"); 
	/* end critical section */

	goto again
}



