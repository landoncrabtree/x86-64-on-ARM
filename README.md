# x86-64 on ARM
### A simple Dockerfile to develop, compile, run, and debug x86-64 assembly on ARM64. This was made for my Operating Systems class, since it uses x86 assembly, but I am on an M1 Mac.

## Features
* Supports local development with volume mounting (Files in the `./csc4100` directory are mounted to `/csc4100` in the container and vice versa)
* Necessary tools are installed (GCC, GDB, NASM, etc.)
* Comes with gdbgui for GUI-based debugging (See [gdbgui](#gdbgui))
* Easy to get started (See [Usage](#usage))

## Usage
1. Install Docker Desktop
2. Configure Docker Desktop to use Rosetta2 using [this guide](https://www.docker.com/blog/docker-desktop-4-25/)
3. Run the following commands to get the Docker container running
```
git clone https://github.com/landoncrabtree/x86-64-on-arm.git
cd x86-64-on-arm
chmod +x ./launch.sh
./launch.sh build
./launch.sh run
```

## Debugging with GDB
Because Docker is emulating via Rosetta2, using `gdb` like normal will produce errors (such as invalid memory, etc.). The following blog post [here](https://sporks.space/2023/04/12/debugging-an-x86-application-in-rosetta-for-linux/) highlights the solution to this. Running binaries has a `ROSETTA_DEBUGSERVER_PORT` environment variable, which we can set to any arbitrary port. Thus, to debug a program through GDB, the following approach should be used:

```bash
gcc -g -o program program.c
ROSETTA_DEBUGSERVER_PORT=1234 ./program & gdb
(gdb) set architecture i386:x86-64
(gdb) file /csc4100/program
(gdb) target remote localhost:1234
```

From here, you can use GDB as normal, `b main`, `continue`, `s`, etc.

### gdbgui
gdbgui is a GUI-based debugger for GDB. It is pre-installed in the container. It is accessible from the host machine by navigating to `localhost:5000` in a web browser.
1. You will need two terminals for this: (1) for the gdbgui daemon and (2) the GDB server
2. In terminal (1) Run gdbgui in the container (`gdbgui -g "gdb -ex 'set architecture i386:x86-64'" -r`)
3. In terminal (2) Run the program with `ROSETTA_DEBUGSERVER_PORT=1234 ./program`
4. Navigate to `localhost:8000` in a web browser on the host machine
5. Select the dropdown (top left) and choose 'gdbserver' and connect to `localhost:1234`.
