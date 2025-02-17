# Turbo Assembler Tools

This folder contains the essential tools for working with assembly programs using the Turbo Assembler (TASM) suite. Below is a brief description of each file:

## Files:

1. **`tasm.exe`**:
   - **Purpose**: Turbo Assembler (TASM) is a tool for assembling assembly language source code into object files.
   - **Usage**: Run `tasm program.asm` to compile the assembly code from the `program.asm` file into an object file (`program.obj`).

2. **`tlink.exe`**:
   - **Purpose**: Turbo Linker (TLINK) is used to link object files (`.obj`) into an executable (`.exe`).
   - **Usage**: After compiling with `tasm`, run `tlink program.obj` to link the object file and generate an executable file (`program.exe`).

3. **`td.exe`**:
   - **Purpose**: Turbo Debugger (TD) is a debugger for assembly programs that helps you inspect and debug your code.
   - **Usage**: If needed, run `td program.exe` to start the debugging process on your compiled program.
