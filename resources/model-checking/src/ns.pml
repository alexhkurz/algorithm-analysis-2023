/* The Needham-Schroeder public-key protocol, as a Promela model */

/* There are three agents: Alice, Bob, and Intruder, who communicate 
   via a common network. Initially, each agent has a (non-corrupted) 
   pair of keys and has made up a nonce.

   Agents Alice and Bob are the initiator and responder, respectively, 
   who try to establish a common secret, represented by their pair of
   nonces. The goal of the protocol is to try and convince each other
   of their presence and identity. The intruder may participate in runs
   of the protocol just as any other agent, but may also fake
   messages, using information intercepted from network traffic.
   However, even Intruder cannot break the cryptographic algorithm, 
   that is, he cannot decipher messages encrypted with a key other
   than his own.

   The Needham-Schroeder protocol between agents A and B is as
   follows:

     1: A -> B: {N(A), A}_B
     2: B -> A: {N(A), N(B)}_A
     3: A -> B: {N(B)}_B

   Here, N(A) and N(B) denote the nonces of agents A and B, and
   {M}_A represents the message M encrypted with the public key of A
   (so that it can be decrypted only by A, using its private key).

   Note: This simplified version of the protocol assumes public keys
   to be known to all clients. The original version includes messages
   to request keys from a key server.
*/

mtype = {msg1, msg2, msg3, alice, bob, intruder, 
         nonceA, nonceB, nonceI, keyA, keyB, keyI, ok};

typedef Crypt { /* the encrypted part of a message */
  mtype key, d1, d2;
}

/* A message in transit is modelled as a tuple
     msg# ( receiver, encrypted_data )
   The receiver field identifies the intended recipient, although an
   attacker may intercept any message sent on the network.
*/
chan network = [0] of {mtype, /* msg# */
                       mtype, /* receiver */
                       Crypt};

/* The partners successfully identified (if any) by initiator
   and responder, used in correctness assertion.
*/
mtype partnerA, partnerB;
mtype statusA, statusB;

/* Knowledge about nonces gained by the intruder. */
bool knowNA, knowNB;

/* --------------------------------------------------------------- */

active proctype Alice() { /* honest initiator for one protocol run */
  mtype  partner_key, partner_nonce;
  Crypt  data;

  atomic {
    if /* nondeterministically choose a partner for this run */
    :: partnerA = bob; partner_key = keyB;
    :: partnerA = intruder; partner_key = keyI;
    fi;
  }

  d_step {
    /* Construct msg1 and send it to chosen partner */
    data.key = partner_key;
    data.d1 = alice;
    data.d2 = nonceA;
  }
  network ! msg1(partnerA, data);

  /* wait for msg2 to arrive */
  network ? msg2(alice, data);
  end_errA:
    /* make sure that the message is encrypted with A's key
       and that the first nonce matches, otherwise block. */
  (data.key == keyA) && (data.d1 == nonceA);
  partner_nonce = data.d2;

  d_step {
    /* respond with msg3 and declare success */
    data.key = partner_key;
    data.d1 = partner_nonce;
    data.d2 = 0;
  }
  network ! msg3(partnerA, data);
  statusA = ok;
} /* proctype Alice() */

/* --------------------------------------------------------------- */

active proctype Bob() { /* honest responder for one run */
  mtype partner_key, partner_nonce;
  Crypt data;

  /* wait for msg1, identifying partner */
  network ? msg1(bob, data);
  end_errB1: 
  /* try to decrypt the message; block on wrong key */
  (data.key == keyB);
  partnerB = data.d1;
  partner_nonce = data.d2;

  d_step {
    /* lookup the partner's public key */
    if
    :: (partnerB == alice) -> partner_key = keyA;
    :: (partnerB == bob) -> partner_key = keyB;  /* cannot happen */
    :: (partnerB == intruder) -> partner_key = keyI;
    fi;
    /* respond with msg2 */
    data.key = partner_key;
    data.d1 = partner_nonce;
    data.d2 = nonceB;
  }
  network ! msg2(partnerB, data);

  /* wait for msg3, check the key and the nonce, and declare success */
  network ? msg3(bob, data);
  end_errB2: 
  (data.key == keyB) && (data.d1 == nonceB);
  statusB = ok;
} /* proctype Bob() */

/* --------------------------------------------------------------- */

active proctype Intruder() {
  /* The intruder doesn't follow a fixed protocol (we want the
     modelchecker to find the attack!), we simply list the different
     actions it can perform.
  */
  mtype msg, rcpt;
  Crypt data, intercepted;

  do
  :: /* Receive or intercept a message. If possible, extract nonces. */
     network ? msg (_, data) ->
     if /* Perhaps store the data field for later use */
     :: d_step {
	  intercepted.key = data.key; 
	  intercepted.d1 = data.d1;
	  intercepted.d2 = data.d2;
	}
     :: skip;
     fi;
     atomic {
       if /* Try to decrypt the message if possible */
       :: (data.key == keyI) -> /* Have we learnt a new nonce? */
	  if
	  :: (data.d1 == nonceA || data.d2 == nonceA) -> knowNA = true;
	  :: else -> skip;
	  fi;
	  if
	  :: (data.d1 == nonceB || data.d2 == nonceB) -> knowNB = true;
	  :: else -> skip;
	  fi;
       :: else -> skip;
       fi;
     }
  :: /* Replay or send a message */
     atomic {
       if /* choose message type */
       :: msg = msg1;
       :: msg = msg2;
       :: msg = msg3;
       fi;
       if /* choose recipient */
       :: rcpt = alice;
       :: rcpt = bob;
       fi;
     }
     if /* either replay intercepted message or construct a fresh message */
     :: network ! msg(rcpt, intercepted);
     :: atomic {
          if /* choose key */
	  :: data.key = keyA;
	  :: data.key = keyB;
	  :: data.key = keyI;
	  fi;
	  if /* assemble message; note: most combinations are rubbish */
	  :: msg == msg1 --> data.d1 = alice;
	  :: msg == msg1 --> data.d1 = bob;
	  :: msg == msg1 --> data.d1 = intruder;
	  :: knowNA -> data.d1 = nonceA;
	  :: knowNB -> data.d1 = nonceB;
	  :: data.d1 = nonceI;
	  fi;
	  if /* agent names are nonsensical for d2 field */
	  :: knowNA -> data.d2 = nonceA;
	  :: knowNB -> data.d2 = nonceB;
	  :: data.d2 = nonceI;
	  fi;
        }
        network ! msg(rcpt, data);
     fi;
  od;
}

/* propositional variables for use in the formulas */

#define success		(statusA == ok && statusB == ok)
#define aliceBob	(partnerA == bob)
#define bobAlice	(partnerB == alice)
#define knowNA		(knowNA)
#define knowNB		(knowNB)

/* 

Example formulas/properties (invent your own):

ltl {[]  (success && aliceBob -> bobAlice)}

ltl {[]  (success && bobAlice -> aliceBob)}

*/

