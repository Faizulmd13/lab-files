import java.net.*;
import java.io.*;

public class udpclient {
    public static void main(String[] args) throws Exception {
        DatagramSocket clientSocket = new DatagramSocket();
        InetAddress serverAddress = InetAddress.getByName("localhost");

        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        System.out.println("Enter hostnames to query (type 'exit' to quit):");

        while (true) {
            System.out.print("Host: ");
            String host = br.readLine();
            if (host.equalsIgnoreCase("exit")) break;

            byte[] sendData = host.getBytes();
            DatagramPacket sendPacket = new DatagramPacket(sendData, sendData.length, serverAddress, 1362);
            clientSocket.send(sendPacket);

            byte[] receiveData = new byte[1024];
            DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);
            clientSocket.receive(receivePacket);

            String response = new String(receivePacket.getData(), 0, receivePacket.getLength());
            System.out.println("Server response: " + response);
        }

        clientSocket.close();
        System.out.println("Client terminated.");
    }
}

