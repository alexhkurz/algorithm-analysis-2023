public class Main {
    static int x = 0;

    // remove synchronized for comparison
    private synchronized static void incrementX() {
        x++;
    }

    public static void main(String[] args) {
        Runnable f = () -> {
            for (var i = 0; i < 100000; i++) {
                incrementX();
            }
        };
        var t1 = new Thread(f);
        var t2 = new Thread(f);
        t1.start();
        t2.start();
        try {
            Thread.sleep(0); // if needed adapt the argument to overlap the threads
            t1.join(); // print only after t1 finishes
            t2.join(); // print only after t2 finishes
        } catch (InterruptedException ie) {
        }
        System.out.println(x);
    }
}