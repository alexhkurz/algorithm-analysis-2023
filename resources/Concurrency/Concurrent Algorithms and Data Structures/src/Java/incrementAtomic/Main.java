import java.util.concurrent.atomic.AtomicInteger;

public class Main {
    static AtomicInteger x = new AtomicInteger(0);
    public static void main(String[] args) {
        Runnable f = () -> { for (var i = 0; i < 100000; i++) x.getAndIncrement(); };
        var t1 = new Thread(f);
        var t2 = new Thread(f);
        t1.start();
        t2.start();
        try {
            Thread.sleep(0); // adapt the argument to overlap the threads
            t1.join(); // print only after t1 finishes
            t2.join(); // print only after t2 finishes
        } catch (InterruptedException ie) {
        }
        System.out.println(x);
    }
}