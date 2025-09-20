# Compiler Design Laboratory (CD)

This folder contains the Compiler Design laboratory experiments. Each experiment demonstrates different phases of a compiler such as lexical analysis, parsing, syntax-directed translation, intermediate code generation, and type checking.

---

## 📂 Folder Structure
- [**EX1**](./EX1) → Lexical analyzer to recognize patterns in C (Identifiers, Constants, Comments, Operators, etc.) + Symbol table  
- [**EX2**](./EX2) → Lexical analyzer using Lex tool  
- [**EX3A**](./EX3/A) → Recognize valid arithmetic expressions using `+ - * /`  
- [**EX3B**](./EX3/B) → Identifier checker (valid variable recognition)  
- [**EX3C**](./EX3/C) → C Control Structures Syntax Checker
- [**EX3D**](./EX3/D) → Calculator using Lex and Yacc (Arithmetic Expression Evaluator)  
- [**EX4**](./EX4) → Generate three-address code using Lex and Yacc  
- [**EX5**](./EX5) → Type checking using Lex and Yacc  
- [**EX6**](./EX6) → Simple code optimization  
- [**EX7**](./EX7) → Target code generation  


---

## ⚙️ Installation (Linux)

Before running the programs, install the required tools:

```bash
sudo apt-get update
sudo apt-get install flex bison
sudo apt-get install libfl-dev
```

---

## ▶️ How to Run

Each experiment folder typically contains:
- Source files (`.l`, `.y`, `.c`)  
- A text file "instructions.txt" (providing inputs or explanations, varies by experiment)  

### General Execution Steps:
1. Navigate to the experiment folder, e.g.:
   ```bash
   cd EX1
   ```

2. Compile the Lex/Yacc/C program:
   - For Lex only:
     ```bash
     lex file.l
     gcc lex.yy.c -lfl -o program
     ./program
     ```
   - For Yacc with Lex:
     ```bash
     yacc -d file.y
     lex file.l
     gcc y.tab.c lex.yy.c -lfl -o program
     ./program
     ```
   - For C only:
     ```bash
     gcc file.c -o program
     ./program
     ```
                          
3. Refer to the provided 'instructions.txt' in each folder for sample inputs or notes.  

---

## ⚠️ Note on Compatibility

- These programs are tested on **Linux (Ubuntu/Mint)**.  
- To run on Windows, you will need:
  - A Linux environment (WSL, Cygwin, or Virtual Machine), or  
  - Recompile the programs inside Windows using compatible Lex/Yacc tools.  

---

## ✅ Recommendation
- Always run these in a Linux environment for smooth execution.  
- Use the text file inside each experiment folder for input/output examples.  

---
