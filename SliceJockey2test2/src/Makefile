# GNU make / gcc Makefile for building Pd lib / project

# One Pd class per subdir 
# Flags and executable extension are included from include/flags.mk.
# Shared paths are included from include/paths.mk

# target all: default target, regulare build
# target ub: build classes as Unity Builds (single compilation unit per class)
# target strip: strip binaries according to variable STRIPFLAGS
# target install: copy binaries to INSTALLDIR
# target clean: remove build products from class directories (local clean)
# target cleanall: clean + remove binaries from ../bin/
# target mkbindirs: make lib subdirectories in ../bin/


################################################################################



#----------- libdir names ------------------------------------------------------

LIBDIR := crip dyna slic verbkit 


################################################################################


export

include includes/flags.mk


#----------- targets -----------------------------------------------------------

.PHONY = all ub install clean strip



all: mkbindirs
	for dir in $(LIBDIR); do (cd $$dir; ${MAKE} all); \
	done


ub: mkbindirs
	for dir in $(LIBDIR); do (cd $$dir; ${MAKE} ub); \
	done


strip:
	for dir in $(LIBDIR); do (cd $$dir; ${MAKE} strip); \
	done


install:
	for dir in $(LIBDIR); do (cd $$dir; ${MAKE} install); \
	done
	

clean:
	for dir in $(LIBDIR); do (cd $$dir; ${MAKE} clean); \
	done


cleanall: clean
	for dir in $(LIBDIR); do (cd ../bin/$$dir; rm -f *); \
	done


mkbindirs:
	for dir in $(LIBDIR); do (mkdir -p ../bin/$$dir); \
	done
