// run several times, try to obtain results other than the expected 200000
public class Main {
    static int x = 0; // add the qualifier `volatile` for comparison
    public static void main(String[] args) {
        Runnable f = () -> { for (var i = 0; i < 100000; i++) x++; };
        var t1 = new Thread(f);
        var t2 = new Thread(f);
        t1.start();
        t2.start();
        try { // InterruptedException must be caught
        t1.sleep(0); // adapt the argument to overlap the threads
        t1.join(); // print only after t1 finishes
        t2.join(); // print only after t2 finishes
        } catch (InterruptedException ie) {
        };
        System.out.println(x);
    }
}