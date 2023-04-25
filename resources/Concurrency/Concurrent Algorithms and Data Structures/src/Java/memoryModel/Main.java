import java.util.concurrent.ThreadLocalRandom;

public class Main {
    private static int x = 0;
    private static int y = 0;
    private static int a = 0;
    private static int b = 0;

    public static void main(String[] args) throws InterruptedException {
        int[] counters = new int[4];
        int iterations = 1000;

        for (int i = 0; i < iterations; i++) {
            int result = runTest();
            counters[result]++;
        }

        System.out.println("Outcomes after " + iterations + " iterations:");
        System.out.println("(0, 0): " + counters[0]);
        System.out.println("(0, 1): " + counters[1]);
        System.out.println("(1, 0): " + counters[2]);
        System.out.println("(1, 1): " + counters[3]);
    }

    private static int runTest() throws InterruptedException {
        Thread t1 = new Thread(() -> {
            try {
                Thread.sleep(ThreadLocalRandom.current().nextInt(1, 10));
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            x = 1;
            b = y;
        });

        Thread t2 = new Thread(() -> {
            try {
                Thread.sleep(ThreadLocalRandom.current().nextInt(1, 10));
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            y = 1;
            a = x;
        });

        t1.start();
        t2.start();
        t1.join();
        t2.join();

        int resultIndex;
        if (a == 0 && b == 0) {
            resultIndex = 0;
        } else if (a == 0 && b == 1) {
            resultIndex = 1;
        } else if (a == 1 && b == 0) {
            resultIndex = 2;
        } else {
            resultIndex = 3;
        }

        System.out.println("a: " + a + ", b: " + b);

        // Reset the values for the next iteration
        x = 0;
        y = 0;
        a = 0;
        b = 0;

        return resultIndex;
    }
}
