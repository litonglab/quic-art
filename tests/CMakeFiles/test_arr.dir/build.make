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
include tests/CMakeFiles/test_arr.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include tests/CMakeFiles/test_arr.dir/compiler_depend.make

# Include the progress variables for this target.
include tests/CMakeFiles/test_arr.dir/progress.make

# Include the compile flags for this target's objects.
include tests/CMakeFiles/test_arr.dir/flags.make

tests/CMakeFiles/test_arr.dir/test_arr.c.o: tests/CMakeFiles/test_arr.dir/flags.make
tests/CMakeFiles/test_arr.dir/test_arr.c.o: tests/test_arr.c
tests/CMakeFiles/test_arr.dir/test_arr.c.o: tests/CMakeFiles/test_arr.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/liuwei/lsquic/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object tests/CMakeFiles/test_arr.dir/test_arr.c.o"
	cd /home/liuwei/lsquic/tests && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT tests/CMakeFiles/test_arr.dir/test_arr.c.o -MF CMakeFiles/test_arr.dir/test_arr.c.o.d -o CMakeFiles/test_arr.dir/test_arr.c.o -c /home/liuwei/lsquic/tests/test_arr.c

tests/CMakeFiles/test_arr.dir/test_arr.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/test_arr.dir/test_arr.c.i"
	cd /home/liuwei/lsquic/tests && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/liuwei/lsquic/tests/test_arr.c > CMakeFiles/test_arr.dir/test_arr.c.i

tests/CMakeFiles/test_arr.dir/test_arr.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/test_arr.dir/test_arr.c.s"
	cd /home/liuwei/lsquic/tests && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/liuwei/lsquic/tests/test_arr.c -o CMakeFiles/test_arr.dir/test_arr.c.s

# Object files for target test_arr
test_arr_OBJECTS = \
"CMakeFiles/test_arr.dir/test_arr.c.o"

# External object files for target test_arr
test_arr_EXTERNAL_OBJECTS =

tests/test_arr: tests/CMakeFiles/test_arr.dir/test_arr.c.o
tests/test_arr: tests/CMakeFiles/test_arr.dir/build.make
tests/test_arr: src/liblsquic/liblsquic.so
tests/test_arr: /home/liuwei/boringssl/ssl/libssl.so
tests/test_arr: /home/liuwei/boringssl/crypto/libcrypto.so
tests/test_arr: /usr/local/lib/libz.so
tests/test_arr: tests/CMakeFiles/test_arr.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/liuwei/lsquic/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable test_arr"
	cd /home/liuwei/lsquic/tests && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/test_arr.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
tests/CMakeFiles/test_arr.dir/build: tests/test_arr
.PHONY : tests/CMakeFiles/test_arr.dir/build

tests/CMakeFiles/test_arr.dir/clean:
	cd /home/liuwei/lsquic/tests && $(CMAKE_COMMAND) -P CMakeFiles/test_arr.dir/cmake_clean.cmake
.PHONY : tests/CMakeFiles/test_arr.dir/clean

tests/CMakeFiles/test_arr.dir/depend:
	cd /home/liuwei/lsquic && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/liuwei/lsquic /home/liuwei/lsquic/tests /home/liuwei/lsquic /home/liuwei/lsquic/tests /home/liuwei/lsquic/tests/CMakeFiles/test_arr.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : tests/CMakeFiles/test_arr.dir/depend
