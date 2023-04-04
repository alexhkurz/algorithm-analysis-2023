/* 

The following algorithm is intended to guarantee the mutual exclusion,
that is, it should guarantee that it is impossible for both processes
to be in the critical section at the same time.

But there maybe further correctness criteria. 

Is the algorithm correct? 

*/

bool	turn, flag[2];
byte	cnt;

active [2] proctype P1()
{	pid me, other;

	me = _pid;
	other = 1 - _pid;

again:	
        turn=other;
        flag[me]=1;
        while (flag[other] && turn == other) do {skip};

        /* critical section */
        
        flag[me]=0;
          
	goto again
}
