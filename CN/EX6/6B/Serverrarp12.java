import java.io.*;
import java.net.*;
import java.util.*;

class Serverrarp12 {
    public static void main(String[] args) {
        try {
            DatagramSocket server = new DatagramSocket(1309);
            while(true) {
                byte[] sendbyte = new byte[1024];
                byte[] receivebyte = new byte[1024];

                DatagramPacket receiver = new DatagramPacket(receivebyte, receivebyte.length);
                server.receive(receiver);

                String str = new String(receiver.getData()).trim();
                InetAddress addr = receiver.getAddress();
                int port = receiver.getPort();

                String[] ip = {"165.165.80.80", "165.165.79.1"};
                String[] mac = {"6A:08:AA:C2", "8A:BC:E3:FA"};
                boolean found = false;

                for(int i = 0; i < ip.length; i++) {
                    if(str.equals(mac[i])) {
                        sendbyte = ip[i].getBytes();
                        DatagramPacket sender = new DatagramPacket(sendbyte, sendbyte.length, addr, port);
                        server.send(sender);
                        found = true;
                        break;
                    }
                }
                // If MAC not found, send an error message.
                if(!found) {
                    String notFound = "MAC address not found";
                    sendbyte = notFound.getBytes();
                    DatagramPacket sender = new DatagramPacket(sendbyte, sendbyte.length, addr, port);
                    server.send(sender);
                }
            }
        } catch(Exception e) {
            System.out.println(e);
        }
    }
}

