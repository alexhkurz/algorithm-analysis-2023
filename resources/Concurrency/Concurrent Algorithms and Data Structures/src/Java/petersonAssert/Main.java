public class Main {
    static int turn = 0;
    static boolean[] flag = {false, false};
    static int counter = 0;
    static int iterations = 10000;
    static int inCriticalSection = 0; 

    public static void main(String[] args) throws InterruptedException {
        Thread t1 = new Thread(new Runnable() {
            public void run() {
                process(0);
            }
        });

        Thread t2 = new Thread(new Runnable() {
            public void run() {
                process(1);
            }
        });

        t1.start();
        t2.start();
        t1.join();
        t2.join();

        System.out.println("Counter value: " + counter);
    }

    static void process(int me) {
        int other = 1 - me;
        for (int i = 0; i < iterations; i++) {
            // acquire peterson lock
            flag[me] = true;
            turn = other;
            while (flag[other] && turn == other) {} // wait
            // critical section
            inCriticalSection++;
            assert inCriticalSection == 1: "More than one process in critical section!";
            counter++;
            inCriticalSection--;
            // release lock
            flag[me] = false;
        }
    }
}