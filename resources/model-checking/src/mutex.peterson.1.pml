/* mutex, Peterson */

bool	turn, flag[2];

active [2] proctype P()
{	pid me, other;

	me = _pid;
	other = 1 - _pid;

again:	flag[me]=1;
        turn=other;
wait:   ! (flag[other] && turn == other) ->

        /* begin critical section */
cs:	printf("critical section \n"); 
        /* end critical section */
        
        flag[me]=0;
          
	goto again
}

#define p P[0]@cs
#define q P[1]@cs

never {    /* []!(p/\q) */
accept_init:
T0_init:
        if
        :: (((! ((p))) || (! ((q))))) -> goto T0_init
        fi;
}
