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
include tests/CMakeFiles/test_varint.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include tests/CMakeFiles/test_varint.dir/compiler_depend.make

# Include the progress variables for this target.
include tests/CMakeFiles/test_varint.dir/progress.make

# Include the compile flags for this target's objects.
include tests/CMakeFiles/test_varint.dir/flags.make

tests/CMakeFiles/test_varint.dir/test_varint.c.o: tests/CMakeFiles/test_varint.dir/flags.make
tests/CMakeFiles/test_varint.dir/test_varint.c.o: tests/test_varint.c
tests/CMakeFiles/test_varint.dir/test_varint.c.o: tests/CMakeFiles/test_varint.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/liuwei/lsquic/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object tests/CMakeFiles/test_varint.dir/test_varint.c.o"
	cd /home/liuwei/lsquic/tests && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT tests/CMakeFiles/test_varint.dir/test_varint.c.o -MF CMakeFiles/test_varint.dir/test_varint.c.o.d -o CMakeFiles/test_varint.dir/test_varint.c.o -c /home/liuwei/lsquic/tests/test_varint.c

tests/CMakeFiles/test_varint.dir/test_varint.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/test_varint.dir/test_varint.c.i"
	cd /home/liuwei/lsquic/tests && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/liuwei/lsquic/tests/test_varint.c > CMakeFiles/test_varint.dir/test_varint.c.i

tests/CMakeFiles/test_varint.dir/test_varint.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/test_varint.dir/test_varint.c.s"
	cd /home/liuwei/lsquic/tests && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/liuwei/lsquic/tests/test_varint.c -o CMakeFiles/test_varint.dir/test_varint.c.s

# Object files for target test_varint
test_varint_OBJECTS = \
"CMakeFiles/test_varint.dir/test_varint.c.o"

# External object files for target test_varint
test_varint_EXTERNAL_OBJECTS =

tests/test_varint: tests/CMakeFiles/test_varint.dir/test_varint.c.o
tests/test_varint: tests/CMakeFiles/test_varint.dir/build.make
tests/test_varint: src/liblsquic/liblsquic.so
tests/test_varint: /home/liuwei/boringssl/ssl/libssl.so
tests/test_varint: /home/liuwei/boringssl/crypto/libcrypto.so
tests/test_varint: /usr/local/lib/libz.so
tests/test_varint: tests/CMakeFiles/test_varint.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/liuwei/lsquic/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable test_varint"
	cd /home/liuwei/lsquic/tests && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/test_varint.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
tests/CMakeFiles/test_varint.dir/build: tests/test_varint
.PHONY : tests/CMakeFiles/test_varint.dir/build

tests/CMakeFiles/test_varint.dir/clean:
	cd /home/liuwei/lsquic/tests && $(CMAKE_COMMAND) -P CMakeFiles/test_varint.dir/cmake_clean.cmake
.PHONY : tests/CMakeFiles/test_varint.dir/clean

tests/CMakeFiles/test_varint.dir/depend:
	cd /home/liuwei/lsquic && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/liuwei/lsquic /home/liuwei/lsquic/tests /home/liuwei/lsquic /home/liuwei/lsquic/tests /home/liuwei/lsquic/tests/CMakeFiles/test_varint.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : tests/CMakeFiles/test_varint.dir/depend
