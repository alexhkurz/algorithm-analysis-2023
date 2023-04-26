import java.util.concurrent.ThreadLocalRandom;

public class Main {
    private static int x = 0;
    private static int y = 0;
    private static int a = 0;
    private static int b = 0;

    public static void main(String[] args) throws InterruptedException {
        int iterations = 1000;

        for (int i = 0; i < iterations; i++) {
            runTest(i);
        }

        System.out.println("No violation of sequential inconsistency after " + iterations + " iterations:");
    }

    private static void runTest(int i) throws InterruptedException {
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

        System.out.println("a: " + a + ", b: " + b);

        assert !(a == 0 && b == 0) : "Sequential inconsistency violation after " + i + " iterations";

        // Reset the values for the next iteration
        x = 0;
        y = 0;
        a = 0;
        b = 0;
    }
}
