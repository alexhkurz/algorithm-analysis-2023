public class Main {
    private static int x = 0;
    private static int y = 0;
    private static int a = 0;
    private static int b = 0;
   
    public static void main(String[] args) throws InterruptedException {
    for (int i = 0; i < 1000; i++) {
    runTest();
    }
    }
   
    private static void runTest() throws InterruptedException {
    Thread t1 = new Thread(() -> {
    x = 1;
    b = y;
    });
   
    Thread t2 = new Thread(() -> {
    y = 1;
    a = x;
    });
   
    t1.start();
    t2.start();
    t1.join();
    t2.join();
   
    System.out.println("a: " + a + ", b: " + b);
    // Reset the values for the next iteration
    x = 0;
    y = 0;
    a = 0;
    b = 0;
    }
   }
   