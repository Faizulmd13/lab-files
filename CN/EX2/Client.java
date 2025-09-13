import javax.swing.*;
import java.net.*;
import java.awt.image.*;
import javax.imageio.*;
import java.io.*;

public class Client {
    public static void main(String args[]) throws Exception {
        Socket soc = new Socket("localhost", 4000);
        BufferedImage img = ImageIO.read(new File("digital_image_processing.jpg"));
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(img, "jpg", baos);
        byte[] bytes = baos.toByteArray();
        
        OutputStream out = soc.getOutputStream();
        DataOutputStream dos = new DataOutputStream(out);
        dos.writeInt(bytes.length);
        dos.write(bytes, 0, bytes.length);
        System.out.println("Image sent to server.");
        
        dos.close();
        soc.close();
    }
}

