/* mutex, first try, for 2 processes, simplified */

bool	flag0,flag1;

active proctype P0()
{
l1:	flag0 = true; 
l2:	! flag1 ->      /* if P1 not flagged then go otherwise wait */
l3:	flag0 = false;  /* we think of "at l3" as the critical section */ 
l4:	goto l1; 
}

active proctype P1()
{
l1:	flag1 = true; 
l2:	! flag0 ->      /* if P0 not flagged then go otherwise wait */
l3:	flag1 = false;  /* we think of "at l3" as the critical section */
l4:	goto l1; 
}



