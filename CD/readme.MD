# Compiler Design Laboratory (CD)

This folder contains the Compiler Design laboratory experiments. Each experiment demonstrates different phases of a compiler such as lexical analysis, parsing, syntax-directed translation, intermediate code generation, and type checking.

---

## 📂 Folder Structure
- **EX1** → Lexical Analyzer using Lex  
- **EX2** → Calculator implementation using Lex & Yacc  
- **EX3a** → Program to check whether a string belongs to the grammar using Yacc  
- **EX3b** → Program for shift-reduce parsing using Yacc  
- **EX3c** → Program to check for ambiguity in grammar using Yacc  
- **EX4** → Program for syntax-directed translation (postfix evaluation / simple translation scheme)  
- **EX5** → Program for intermediate code generation (3-address code)  
- **EX6** → Program for type checking using Yacc  
- **EX7** → Program for symbol table construction  

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
- A text file (providing inputs or explanations, varies by experiment)  
- Precompiled executable (Linux-compatible, if generated earlier)  

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
                          
3. Refer to the provided text file in each folder for sample inputs or notes.  

---

## ⚠️ Note on Compatibility

- These programs are tested on **Linux (Ubuntu/Mint)**.  
- The executables are **not portable to Windows**.  
- To run on Windows, you will need:
  - A Linux environment (WSL, Cygwin, or Virtual Machine), or  
  - Recompile the programs inside Windows using compatible Lex/Yacc tools.  

---

## ✅ Recommendation
- Always run these in a Linux environment for smooth execution.  
- Use the text file inside each experiment folder for input/output examples.  

---
