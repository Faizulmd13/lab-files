import java.io.*;
import java.net.*;

public class udpdnsserver {

    private static int indexOf(String[] array, String str) {
        str = str.trim();
        for (int i = 0; i < array.length; i++) {
            if (array[i].equals(str))
                return i;
        }
        return -1;
    }

    public static void main(String[] args) throws IOException {
        String[] hosts = {"yahoo.com", "gmail.com", "cricinfo.com", "facebook.com"};
        String[] ip = {"68.180.206.184", "209.85.148.19", "80.168.92.140", "69.63.189.16"};

        DatagramSocket serversocket = new DatagramSocket(1362);
        System.out.println("UDP DNS Server is running on port 1362...");

        while (true) {
            byte[] receivedata = new byte[1024];
            DatagramPacket recvpack = new DatagramPacket(receivedata, receivedata.length);
            serversocket.receive(recvpack);

            String hostRequest = new String(recvpack.getData(), 0, recvpack.getLength());
            InetAddress clientAddress = recvpack.getAddress();
            int clientPort = recvpack.getPort();

            String response;
            int idx = indexOf(hosts, hostRequest);
            if (idx != -1) {
                response = ip[idx];
            } else {
                response = "Host Not Found";
            }

            byte[] sendData = response.getBytes();
            DatagramPacket sendPack = new DatagramPacket(sendData, sendData.length, clientAddress, clientPort);
            serversocket.send(sendPack);
            System.out.println("Served: " + hostRequest + " -> " + response);
        }
    }
}

