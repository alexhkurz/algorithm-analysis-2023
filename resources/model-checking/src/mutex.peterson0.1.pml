/* mutex, Peterson wrong */

bool	turn, flag[2];

active [2] proctype P1()
{	pid me, other;

	me = _pid;
	other = 1 - _pid;

again:	turn=other;
        flag[me]=1;
wait:   ! (flag[other] && turn == other) ->

        /* begin critical section */
cs:	printf("critical section \n"); 
	/* end critical section */
        
        flag[me]=0;
          
	goto again
}
