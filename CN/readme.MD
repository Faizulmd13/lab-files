# Computer Networks Laboratory (CN)

This folder contains the Computer Networks laboratory experiments. Each experiment demonstrates different concepts in computer networking such as protocols, socket programming, error detection, congestion control, and packet transmission.

---

## 📂 Folder Structure
- [**EX1**](./EX1) → Network Analysis & Packet Capture 
- [**EX2**](./EX2) → Client-Server Image Transfer
- [**EX3A**](./EX3/3A) → Echo Client-Server
- [**EX3B**](./EX3/3B) → UDP Chat Server & Client Execution
- [**EX4**](./EX4) → UDP DNS Server & Client
- [**EX5**](./EX5) → Wireshark Packet Analysis

---


## ⚙️ Installation (Java Setup)

Ensure Java Development Kit (JDK) is installed:

```bash
# For Ubuntu/Debian
sudo apt-get update
sudo apt-get install default-jdk

# For Windows
Download and install from: https://www.oracle.com/java/technologies/javase-downloads.html
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
