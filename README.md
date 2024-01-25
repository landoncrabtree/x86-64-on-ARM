# x86-64 on ARM
### A simple Dockerfile to develop, compile, run, and debug x86-64 assembly on ARM64. This was made for my Operating Systems class, since it teaches x86 assembly, but I am on an M1 Mac.

## Features
* Supports local development with volume mounting (Files in the `./csc4100` directory are mounted to `/csc4100` in the container and vice versa)
* Necessary tools are installed (GCC, GDB, NASM, etc.)
* Comes with gdbgui for GUI-based debugging (See [gdbgui](#gdbgui))
* Easy to get started (See [Usage](#usage))

## Usage
```
git clone https://github.com/landoncrabtree/x86-64-on-arm.git
cd x86-64-on-arm
chmod +x ./launch.sh
./launch.sh build
./launch.sh run
```

## gdbgui
gdbgui is a GUI-based debugger for GDB. It is pre-installed in the container and can be started by running `gdbgui -r` in the container. It is accessible from the host machine by navigating to `localhost:5000` in a web browser.
1. Compile your program with debugging symbols (`gcc -g -o program program.c`)
2. Run gdbgui in the container (`gdbgui -r`)
3. Navigate to `localhost:8000` in a web browser on the host machine
4. Select the path to the program (`/csc4100/program`)
