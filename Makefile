# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.20

# Default target executed when no arguments are given to make.
default_target: all
.PHONY : default_target

# Allow only one "make -f Makefile2" at a time, but pass parallelism.
.NOTPARALLEL:

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
CMAKE_COMMAND = /usr/local/bin/cmake

# The command to remove a file.
RM = /usr/local/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/mike/Desktop/rage-rustic-ascii-graphic-engine

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/mike/Desktop/rage-rustic-ascii-graphic-engine

#=============================================================================
# Targets provided globally by CMake.

# Special rule for the target rebuild_cache
rebuild_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Running CMake to regenerate build system..."
	/usr/local/bin/cmake --regenerate-during-build -S$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR)
.PHONY : rebuild_cache

# Special rule for the target rebuild_cache
rebuild_cache/fast: rebuild_cache
.PHONY : rebuild_cache/fast

# Special rule for the target edit_cache
edit_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "No interactive CMake dialog available..."
	/usr/local/bin/cmake -E echo No\ interactive\ CMake\ dialog\ available.
.PHONY : edit_cache

# Special rule for the target edit_cache
edit_cache/fast: edit_cache
.PHONY : edit_cache/fast

# The main all target
all: cmake_check_build_system
	$(CMAKE_COMMAND) -E cmake_progress_start /home/mike/Desktop/rage-rustic-ascii-graphic-engine/CMakeFiles /home/mike/Desktop/rage-rustic-ascii-graphic-engine//CMakeFiles/progress.marks
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 all
	$(CMAKE_COMMAND) -E cmake_progress_start /home/mike/Desktop/rage-rustic-ascii-graphic-engine/CMakeFiles 0
.PHONY : all

# The main clean target
clean:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 clean
.PHONY : clean

# The main clean target
clean/fast: clean
.PHONY : clean/fast

# Prepare targets for installation.
preinstall: all
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall

# Prepare targets for installation.
preinstall/fast:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall/fast

# clear depends
depend:
	$(CMAKE_COMMAND) -S$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 1
.PHONY : depend

#=============================================================================
# Target rules for targets named rage_app

# Build rule for target.
rage_app: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 rage_app
.PHONY : rage_app

# fast build rule for target.
rage_app/fast:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rage_app.dir/build.make CMakeFiles/rage_app.dir/build
.PHONY : rage_app/fast

#=============================================================================
# Target rules for targets named projection_lib

# Build rule for target.
projection_lib: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 projection_lib
.PHONY : projection_lib

# fast build rule for target.
projection_lib/fast:
	$(MAKE) $(MAKESILENT) -f src/CMakeFiles/projection_lib.dir/build.make src/CMakeFiles/projection_lib.dir/build
.PHONY : projection_lib/fast

#=============================================================================
# Target rules for targets named camera_lib

# Build rule for target.
camera_lib: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 camera_lib
.PHONY : camera_lib

# fast build rule for target.
camera_lib/fast:
	$(MAKE) $(MAKESILENT) -f src/CMakeFiles/camera_lib.dir/build.make src/CMakeFiles/camera_lib.dir/build
.PHONY : camera_lib/fast

#=============================================================================
# Target rules for targets named rasterizer_lib

# Build rule for target.
rasterizer_lib: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 rasterizer_lib
.PHONY : rasterizer_lib

# fast build rule for target.
rasterizer_lib/fast:
	$(MAKE) $(MAKESILENT) -f src/CMakeFiles/rasterizer_lib.dir/build.make src/CMakeFiles/rasterizer_lib.dir/build
.PHONY : rasterizer_lib/fast

#=============================================================================
# Target rules for targets named api_lib

# Build rule for target.
api_lib: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 api_lib
.PHONY : api_lib

# fast build rule for target.
api_lib/fast:
	$(MAKE) $(MAKESILENT) -f src/CMakeFiles/api_lib.dir/build.make src/CMakeFiles/api_lib.dir/build
.PHONY : api_lib/fast

#=============================================================================
# Target rules for targets named vector3_lib

# Build rule for target.
vector3_lib: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 vector3_lib
.PHONY : vector3_lib

# fast build rule for target.
vector3_lib/fast:
	$(MAKE) $(MAKESILENT) -f src/CMakeFiles/vector3_lib.dir/build.make src/CMakeFiles/vector3_lib.dir/build
.PHONY : vector3_lib/fast

#=============================================================================
# Target rules for targets named win_lib

# Build rule for target.
win_lib: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 win_lib
.PHONY : win_lib

# fast build rule for target.
win_lib/fast:
	$(MAKE) $(MAKESILENT) -f src/CMakeFiles/win_lib.dir/build.make src/CMakeFiles/win_lib.dir/build
.PHONY : win_lib/fast

#=============================================================================
# Target rules for targets named obj_parser_lib

# Build rule for target.
obj_parser_lib: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 obj_parser_lib
.PHONY : obj_parser_lib

# fast build rule for target.
obj_parser_lib/fast:
	$(MAKE) $(MAKESILENT) -f src/CMakeFiles/obj_parser_lib.dir/build.make src/CMakeFiles/obj_parser_lib.dir/build
.PHONY : obj_parser_lib/fast

#=============================================================================
# Target rules for targets named obj_lib

# Build rule for target.
obj_lib: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 obj_lib
.PHONY : obj_lib

# fast build rule for target.
obj_lib/fast:
	$(MAKE) $(MAKESILENT) -f src/CMakeFiles/obj_lib.dir/build.make src/CMakeFiles/obj_lib.dir/build
.PHONY : obj_lib/fast

#=============================================================================
# Target rules for targets named matrix_lib

# Build rule for target.
matrix_lib: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 matrix_lib
.PHONY : matrix_lib

# fast build rule for target.
matrix_lib/fast:
	$(MAKE) $(MAKESILENT) -f src/CMakeFiles/matrix_lib.dir/build.make src/CMakeFiles/matrix_lib.dir/build
.PHONY : matrix_lib/fast

#=============================================================================
# Target rules for targets named tmatrix_lib

# Build rule for target.
tmatrix_lib: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 tmatrix_lib
.PHONY : tmatrix_lib

# fast build rule for target.
tmatrix_lib/fast:
	$(MAKE) $(MAKESILENT) -f src/CMakeFiles/tmatrix_lib.dir/build.make src/CMakeFiles/tmatrix_lib.dir/build
.PHONY : tmatrix_lib/fast

main.o: main.c.o
.PHONY : main.o

# target to build an object file
main.c.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rage_app.dir/build.make CMakeFiles/rage_app.dir/main.c.o
.PHONY : main.c.o

main.i: main.c.i
.PHONY : main.i

# target to preprocess a source file
main.c.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rage_app.dir/build.make CMakeFiles/rage_app.dir/main.c.i
.PHONY : main.c.i

main.s: main.c.s
.PHONY : main.s

# target to generate assembly for a file
main.c.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rage_app.dir/build.make CMakeFiles/rage_app.dir/main.c.s
.PHONY : main.c.s

# Help Target
help:
	@echo "The following are some of the valid targets for this Makefile:"
	@echo "... all (the default if no target is provided)"
	@echo "... clean"
	@echo "... depend"
	@echo "... edit_cache"
	@echo "... rebuild_cache"
	@echo "... api_lib"
	@echo "... camera_lib"
	@echo "... matrix_lib"
	@echo "... obj_lib"
	@echo "... obj_parser_lib"
	@echo "... projection_lib"
	@echo "... rage_app"
	@echo "... rasterizer_lib"
	@echo "... tmatrix_lib"
	@echo "... vector3_lib"
	@echo "... win_lib"
	@echo "... main.o"
	@echo "... main.i"
	@echo "... main.s"
.PHONY : help



#=============================================================================
# Special targets to cleanup operation of make.

# Special rule to run CMake to check the build system integrity.
# No rule that depends on this can have commands that come from listfiles
# because they might be regenerated.
cmake_check_build_system:
	$(CMAKE_COMMAND) -S$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 0
.PHONY : cmake_check_build_system

