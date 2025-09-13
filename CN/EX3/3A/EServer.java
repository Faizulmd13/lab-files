import java.net.*;
import java.io.*;

public class EServer {
    public static void main(String args[]) {
        try {
            ServerSocket s = new ServerSocket(9000);
            Socket c = s.accept();
            DataInputStream is = new DataInputStream(c.getInputStream());
            PrintStream ps = new PrintStream(c.getOutputStream());
            
            String line;
            while(true) {
                line = is.readLine();
                ps.println(line);
            }
        } catch(IOException e) {
            System.out.println(e);
        }
    }
}

