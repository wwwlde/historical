# How to Assemble and Run Applications with TASM, TLINK, and TD

This guide explains how to assemble, link, and debug your assembly programs using Turbo Assembler (`tasm.exe`), Turbo Linker (`tlink.exe`), and Turbo Debugger (`td.exe`).

## Steps to Assemble, Link, and Run:

1. **Write your Assembly Code**:
   - Create your assembly source file, e.g., `program.asm`.

2. **Assemble the Code**:
   - Open Command Prompt and navigate to the folder containing `tasm.exe` and your `.asm` file.
   - Compile your source file with `tasm.exe`:
     ```bash
     tasm program.asm
     ```
   - This will generate an object file `program.obj`.

3. **Link the Object File**:
   - After compilation, link the object file using `tlink.exe`:
     ```bash
     tlink program.obj
     ```
   - This will produce the executable file `program.exe`.

4. **Run the Executable**:
   - You can now run the program directly:
     ```bash
     program.exe
     ```

5. **Debugging (Optional)**:
   - If you need to debug your program, use `td.exe` (Turbo Debugger):
     ```bash
     td program.exe
     ```

## Example Commands:

Assuming your source file is `program.asm`:

```bash
tasm program.asm
tlink program.obj
program.exe
```

If you need to debug:
```bash
td program.exe
```

## Troubleshooting:
- Ensure your source file doesn't contain syntax errors before assembling.
- Check the command output for any error messages.
