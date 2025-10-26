# Computer Networks Laboratory (CN)

This folder contains the Computer Networks laboratory experiments. Each experiment demonstrates different concepts in computer networking such as protocols, socket programming, routing, and congestion control.

---

## 📂 Folder Structure
- [**EX1**](./EX1) → Network Analysis & Packet Capture
- [**EX2**](./EX2) → Client-Server Image Transfer (Socket Programming)
- [**EX3A**](./EX3/3A) → Echo Client-Server (TCP)
- [**EX3B**](./EX3/3B) → UDP Chat Server & Client Execution
- [**EX4**](./EX4) → UDP DNS Server & Client (DNS Simulation)
- [**EX5**](./EX5) → Wireshark Packet Analysis
- [**EX6A**](./EX6/6A) → ARP Implementation (Server & Client)
- [**EX6B**](./EX6/6B) → RARP Implementation (Server & Client)
- [**EX7**](./EX7) → DCCP Implementation (Agent)
- [**EX8A**](./EX8/8A) → TCP Performance Simulation (NS2)
- [**EX8B**](./EX8/8B) → UDP Performance Simulation (NS2)
- [**EX9A**](./EX9/9A) → Link State Routing Simulation - 7-Node Ring (NS2)
- [**EX9B**](./EX9/9B) → Link State Routing Simulation - 8-Node Octagon (NS2)
- [**EX10**](./EX_10) → Simulation for Error Detection Code

---


## ⚙️ Installation (Java & NS2 Setup)

Some experiments require **Java**, while those under **EX8** and **EX9** require the **Network Simulator 2 (NS2)** and **Xgraph** tool, typically on a Linux platform.

### Java Setup
Ensure Java Development Kit (JDK) is installed:

```bash
# For Ubuntu/Debian
sudo apt-get update
sudo apt-get install default-jdk

# For Windows
Download and install from: [https://www.oracle.com/java/technologies/javase-downloads.html](https://www.oracle.com/java/technologies/javase-downloads.html)
```
Verify Installation:
```text
java -version
javac -version
```

---

## ▶️ How to Run

Each experiment folder typically contains:
- Java source files (`.java`)  
- A text file "instructions.txt" (providing inputs or explanations, varies by experiment)  

### General Execution Steps:
1. Navigate to the experiment folder, e.g.:
```bash
   cd EX1
```

2. Compile and Run the Java program(s):
   ```bash
   javac FileName.java
   java FileName
   ```
                          
3. Refer to the provided 'instructions.txt' in each folder for sample inputs or notes.  

---

## ✅ Recommendation

- Always compile and run programs from the same folder where the .java files exist.
- Follow the instructions.txt for experiment-specific notes.
- For client-server programs, start the server before the client.

---
