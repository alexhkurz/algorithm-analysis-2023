/* mutex, Peterson right or wrong? */

bool	turn, flag[2];
byte	cnt;

active [2] proctype P1()
{	pid me, other;

	me = _pid;
	other = 1 - _pid;

again:	
        turn=other;
        flag[me]=1;
        ! (flag[other] && turn == other) ->

        /* begin critical section */
	cnt++;
	printf("cnt=%d \n", cnt); 
        assert(cnt == 1); 
        cnt--;
	/* end critical section */
        
        flag[me]=0;
          
	goto again
}
