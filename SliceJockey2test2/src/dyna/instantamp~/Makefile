# GNU make/gcc Makefile for Pd class.

# One Pd class per makefile.
# Class source file must be <classname>.c
# Extra source files can be included from relative path
# Files flags.mk, paths.mk and classbuildrules.mk should be in ../includes/


################################################################################

CLASSNAME := instantamp~


#---------- extra C files ------------------------------------------------------

# headers in same directories are automatically included

EXTRASRC :=


#---------- extra paths to be included -----------------------------------------

EXTRAINCLUDEPATHS := ../dyna-shared


################################################################################

# Find out where we are relative to includes/ directory

DIRDEPTH := $(shell test -d ../../includes && echo "../..")

ifeq ($(words $(DIRDEPTH)), 0)
DIRDEPTH := $(shell test -d ../includes && echo "..")
endif

ifeq ($(words $(DIRDEPTH)), 0)
$(warning $(CLASSNAME): ../includes/  or ../../includes not found)
endif


################################################################################

# Include abstractions

ifneq ($(FLAGS), present)
include $(DIRDEPTH)/includes/flags.mk
endif

ifneq ($(PATHS), present)
include $(DIRDEPTH)/includes/paths.mk
endif

include $(DIRDEPTH)/includes/classbuildrules.mk
