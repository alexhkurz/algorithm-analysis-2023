/* mutex, first try, for 2 processes */

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



