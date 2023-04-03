/* mutex, first try, for 2 processes */

bool	flag[2];
byte	cnt;

active [2] proctype P1()
{	pid me, other;

	me = _pid;
	other = 1 - _pid;

again:	atomic{flag[me] = true; 
               printf("flags=(%d,%d)\n",flag[0],flag[1])} 
	! flag[other] ->

        /* begin critical section */
	cnt++;
	printf("flags=(%d,%d), cnt=%d \n",cnt); 
        assert(cnt == 1); 
        cnt--;
	/* end critical section */

	atomic{flag[me] = false;
               printf("flags=(%d,%d)\n",flag[0],flag[1])} 
	goto again
}



