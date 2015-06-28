# Build rules for Pd lib

# One Pd class per subdir 
# Flags and executable extension are included from include/flags.mk.
# Shared paths are included from include/paths.mk

# target all: default target, regular build
# target strip: strip binaries according to variable STRIPFLAGS
# target install: copy binaries to INSTALLDIR
# target clean: remove build products from class directories (local clean)


#-------------------------------------------------------------------------------

export

ifneq ($(FLAGS), present)
-include ../includes/flags.mk
-include includes/flags.mk
endif



#----------- targets -----------------------------------------------------------

.PHONY = all ub install clean strip



all:
	for dir in $(CLASSNAMES); do (cd $$dir; ${MAKE} all); \
	done


strip:
	for dir in $(CLASSNAMES); do (cd $$dir; ${MAKE} strip); \
	done


install:
	for dir in $(CLASSNAMES); do (cd $$dir; ${MAKE} install); \
	done
	

clean:
	for dir in $(CLASSNAMES); do (cd $$dir; ${MAKE} clean); \
	done

