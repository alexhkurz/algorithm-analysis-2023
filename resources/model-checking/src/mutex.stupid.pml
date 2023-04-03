/* mutex, stupid (no exclusion), for 2 processes */

byte	cnt;

active [2] proctype P1()
{	

again:	/* begin critical section */
	cnt++;
	printf("in the critical section, cnt==%d\n",cnt); 
        assert(cnt == 1); 
        cnt--;
	/* end critical section */

	goto again
}



