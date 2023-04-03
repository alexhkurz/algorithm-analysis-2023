/* mutex, second try with assertion, for 2 processes */

bool	turn;
byte	cnt;

active [2] proctype P1()
{	pid me, other;

	me = _pid;
	other = 1 - _pid;

again:	turn = other;
        ! (turn==other) ->

        /* begin critical section */
	cnt++;
	printf("in the critical section, cnt==%d\n",cnt); 
        assert(cnt == 1); 
        cnt--;
	/* end critical section */

	goto again
}



