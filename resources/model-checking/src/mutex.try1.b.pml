/* mutex, first try, for 2 processes */

bool	flag[2];

active [2] proctype P1()
{
again:	flag[_pid] = 1; 
	! flag[1-_pid] ->

        /* begin critical section */
	printf("process %d is in the critical section\n",_pid); 
	/* end critical section */

	flag[_pid] = false;
	goto again
}



