# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.23

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /opt/cmake-3.23.0/bin/cmake

# The command to remove a file.
RM = /opt/cmake-3.23.0/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/liuwei/lsquic

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/liuwei/lsquic

# Include any dependencies generated for this target.
include bin/CMakeFiles/echo_client.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include bin/CMakeFiles/echo_client.dir/compiler_depend.make

# Include the progress variables for this target.
include bin/CMakeFiles/echo_client.dir/progress.make

# Include the compile flags for this target's objects.
include bin/CMakeFiles/echo_client.dir/flags.make

bin/CMakeFiles/echo_client.dir/echo_client.c.o: bin/CMakeFiles/echo_client.dir/flags.make
bin/CMakeFiles/echo_client.dir/echo_client.c.o: bin/echo_client.c
bin/CMakeFiles/echo_client.dir/echo_client.c.o: bin/CMakeFiles/echo_client.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/liuwei/lsquic/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object bin/CMakeFiles/echo_client.dir/echo_client.c.o"
	cd /home/liuwei/lsquic/bin && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT bin/CMakeFiles/echo_client.dir/echo_client.c.o -MF CMakeFiles/echo_client.dir/echo_client.c.o.d -o CMakeFiles/echo_client.dir/echo_client.c.o -c /home/liuwei/lsquic/bin/echo_client.c

bin/CMakeFiles/echo_client.dir/echo_client.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/echo_client.dir/echo_client.c.i"
	cd /home/liuwei/lsquic/bin && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/liuwei/lsquic/bin/echo_client.c > CMakeFiles/echo_client.dir/echo_client.c.i

bin/CMakeFiles/echo_client.dir/echo_client.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/echo_client.dir/echo_client.c.s"
	cd /home/liuwei/lsquic/bin && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/liuwei/lsquic/bin/echo_client.c -o CMakeFiles/echo_client.dir/echo_client.c.s

bin/CMakeFiles/echo_client.dir/prog.c.o: bin/CMakeFiles/echo_client.dir/flags.make
bin/CMakeFiles/echo_client.dir/prog.c.o: bin/prog.c
bin/CMakeFiles/echo_client.dir/prog.c.o: bin/CMakeFiles/echo_client.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/liuwei/lsquic/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object bin/CMakeFiles/echo_client.dir/prog.c.o"
	cd /home/liuwei/lsquic/bin && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT bin/CMakeFiles/echo_client.dir/prog.c.o -MF CMakeFiles/echo_client.dir/prog.c.o.d -o CMakeFiles/echo_client.dir/prog.c.o -c /home/liuwei/lsquic/bin/prog.c

bin/CMakeFiles/echo_client.dir/prog.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/echo_client.dir/prog.c.i"
	cd /home/liuwei/lsquic/bin && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/liuwei/lsquic/bin/prog.c > CMakeFiles/echo_client.dir/prog.c.i

bin/CMakeFiles/echo_client.dir/prog.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/echo_client.dir/prog.c.s"
	cd /home/liuwei/lsquic/bin && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/liuwei/lsquic/bin/prog.c -o CMakeFiles/echo_client.dir/prog.c.s

bin/CMakeFiles/echo_client.dir/test_common.c.o: bin/CMakeFiles/echo_client.dir/flags.make
bin/CMakeFiles/echo_client.dir/test_common.c.o: bin/test_common.c
bin/CMakeFiles/echo_client.dir/test_common.c.o: bin/CMakeFiles/echo_client.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/liuwei/lsquic/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object bin/CMakeFiles/echo_client.dir/test_common.c.o"
	cd /home/liuwei/lsquic/bin && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT bin/CMakeFiles/echo_client.dir/test_common.c.o -MF CMakeFiles/echo_client.dir/test_common.c.o.d -o CMakeFiles/echo_client.dir/test_common.c.o -c /home/liuwei/lsquic/bin/test_common.c

bin/CMakeFiles/echo_client.dir/test_common.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/echo_client.dir/test_common.c.i"
	cd /home/liuwei/lsquic/bin && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/liuwei/lsquic/bin/test_common.c > CMakeFiles/echo_client.dir/test_common.c.i

bin/CMakeFiles/echo_client.dir/test_common.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/echo_client.dir/test_common.c.s"
	cd /home/liuwei/lsquic/bin && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/liuwei/lsquic/bin/test_common.c -o CMakeFiles/echo_client.dir/test_common.c.s

bin/CMakeFiles/echo_client.dir/test_cert.c.o: bin/CMakeFiles/echo_client.dir/flags.make
bin/CMakeFiles/echo_client.dir/test_cert.c.o: bin/test_cert.c
bin/CMakeFiles/echo_client.dir/test_cert.c.o: bin/CMakeFiles/echo_client.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/liuwei/lsquic/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object bin/CMakeFiles/echo_client.dir/test_cert.c.o"
	cd /home/liuwei/lsquic/bin && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT bin/CMakeFiles/echo_client.dir/test_cert.c.o -MF CMakeFiles/echo_client.dir/test_cert.c.o.d -o CMakeFiles/echo_client.dir/test_cert.c.o -c /home/liuwei/lsquic/bin/test_cert.c

bin/CMakeFiles/echo_client.dir/test_cert.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/echo_client.dir/test_cert.c.i"
	cd /home/liuwei/lsquic/bin && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/liuwei/lsquic/bin/test_cert.c > CMakeFiles/echo_client.dir/test_cert.c.i

bin/CMakeFiles/echo_client.dir/test_cert.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/echo_client.dir/test_cert.c.s"
	cd /home/liuwei/lsquic/bin && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/liuwei/lsquic/bin/test_cert.c -o CMakeFiles/echo_client.dir/test_cert.c.s

# Object files for target echo_client
echo_client_OBJECTS = \
"CMakeFiles/echo_client.dir/echo_client.c.o" \
"CMakeFiles/echo_client.dir/prog.c.o" \
"CMakeFiles/echo_client.dir/test_common.c.o" \
"CMakeFiles/echo_client.dir/test_cert.c.o"

# External object files for target echo_client
echo_client_EXTERNAL_OBJECTS =

bin/echo_client: bin/CMakeFiles/echo_client.dir/echo_client.c.o
bin/echo_client: bin/CMakeFiles/echo_client.dir/prog.c.o
bin/echo_client: bin/CMakeFiles/echo_client.dir/test_common.c.o
bin/echo_client: bin/CMakeFiles/echo_client.dir/test_cert.c.o
bin/echo_client: bin/CMakeFiles/echo_client.dir/build.make
bin/echo_client: src/liblsquic/liblsquic.so
bin/echo_client: /home/liuwei/boringssl/ssl/libssl.so
bin/echo_client: /home/liuwei/boringssl/crypto/libcrypto.so
bin/echo_client: /usr/local/lib/libz.so
bin/echo_client: /usr/lib/x86_64-linux-gnu/libevent.so
bin/echo_client: bin/CMakeFiles/echo_client.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/liuwei/lsquic/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking C executable echo_client"
	cd /home/liuwei/lsquic/bin && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/echo_client.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
bin/CMakeFiles/echo_client.dir/build: bin/echo_client
.PHONY : bin/CMakeFiles/echo_client.dir/build

bin/CMakeFiles/echo_client.dir/clean:
	cd /home/liuwei/lsquic/bin && $(CMAKE_COMMAND) -P CMakeFiles/echo_client.dir/cmake_clean.cmake
.PHONY : bin/CMakeFiles/echo_client.dir/clean

bin/CMakeFiles/echo_client.dir/depend:
	cd /home/liuwei/lsquic && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/liuwei/lsquic /home/liuwei/lsquic/bin /home/liuwei/lsquic /home/liuwei/lsquic/bin /home/liuwei/lsquic/bin/CMakeFiles/echo_client.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : bin/CMakeFiles/echo_client.dir/depend
