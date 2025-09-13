import java.net.*;
import java.io.*;

public class EClient {
    public static void main(String arg[]) {
        try {
            InetAddress ia = InetAddress.getLocalHost();
            Socket c = new Socket(ia, 9000);
            
            PrintStream os = new PrintStream(c.getOutputStream());
            DataInputStream is = new DataInputStream(System.in);
            DataInputStream is1 = new DataInputStream(c.getInputStream());
            
            String line;
            while(true) {
                System.out.println("Client:");
                line = is.readLine();
                os.println(line);
                System.out.println("Server:" + is1.readLine());
            }
        } catch(IOException e) {
            System.out.println("Socket Closed!");
        }
    }
}

