/* mutex, second try, for 2 processes, simplified */

bool	turn;

active proctype P0()
{
l1:	turn = 1;       /* "it is P1's turn" */
l2:     ! (turn==1);    /* "if it is not P1's turn then go otherwise wait" */
l3:     goto l1         /* We think of "at l3" as being in the critical section */
}

active proctype P1()
{
l1:	turn = 0;       /* "it is P0's turn" */
l2:     ! (turn==0);    /* "if it is not P0's turn then go otherwise wait" */
l3:     goto l1         /* We think of "at l3" as being in the critical section */
}



