# Build rules for Pd class, to be included in class Makefile 

# One Pd class per Makefile.
# Class source file must be <classname>.c
# Class Makefile must define class name
# Class Makefile may define extra source files
# Flags and executable extension are defined in flags.mk.
# Paths are defined in paths.mk


#------------ paths ------------------------------------------------------------

EXTRASRCPATHS := $(sort $(dir $(EXTRASRC)))
vpath %.c $(EXTRASRCPATHS)
HEADERPATHS := $(sort $(SHAREDPATHS) $(EXTRASRCPATHS) $(EXTRAINCLUDEPATHS))
INCLUDES := $(foreach path, $(HEADERPATHS), -I $(path))


#------------ files ------------------------------------------------------------

# check for extra C files

ifeq ($(words $(EXTRASRC)), 0)
  SRC := $(CLASSNAME).c
  UBSRC := $(CLASSNAME).c
  UBOBJECT := $(CLASSNAME).o
  IFILES := $(CLASSNAME).i
else
  SRC := $(CLASSNAME).c $(EXTRASRC)
  UBSRC := UB.c
  OBJECTS := $(notdir $(SRC:.c=.o))
  UBOBJECT := UB.o
  IFILES := $(notdir $(SRC:.c=.i))
  C_FLAGS := $(C_FLAGS) $(VISFLAGS)
endif

DEPENDENCIES := $(shell $(CC) -MM $(SRC) $(INCLUDES))
HEADERS := $(sort $(filter %.h, $(DEPENDENCIES)))


################################ TARGETS #######################################

# all: default target: Unity Build, builds class as single compilation unit
# obj: build with object files .o for all files in SRC
# install: copy binary from ./ to  INSTALLDIR
# strip: strip according to STRIPFLAGS
# clean: remove all output files from ./

# --- developer targets (output files go to ./):

# pre: preprocessor files .i with for all files in SRC
# asm: assembly files .s for all files in SRC
# ubpre: UB.i, preprocessor output of UB.c
# ubasm: UB.s, assembly output of UB.c

# vars: print values of variables to stdout
# deps: print dependencies to stdout

# Notice: when you switch from target 'all' to 'obj' or vice versa, you should 
# first clean. Input and output files are equal for both builds, so Make can
# not see if the binary is out of date and it may respond with "nothing to
# be done". 


#----------- phony targets -----------------------------------------------------

.PHONY = clean vars deps


#----------- default target: Unity Build ---------------------------------------

# make Unity Build
all: $(CLASSNAME).$(EXTENSION) $(BINARYDIR)/$(CLASSNAME).$(EXTENSION)

# compile single source file, make o. file
$(UBOBJECT): $(UBSRC)
	$(CC) -c $(UBSRC) $(C_FLAGS) $(ARCHFLAGS) $(INCLUDES)

# make executable from o. file
$(CLASSNAME).$(EXTENSION): $(UBOBJECT)
	$(CC) -o $(CLASSNAME).$(EXTENSION) $(LD_FLAGS) $(ARCHFLAGS) $(UBOBJECT)
	
# if needed, make input file UB.c
UB.c: $(SRC) $(HEADERS)
	echo "// Unity Build file for $(CLASSNAME) \n \n" > UB.c
	for file in $(SRC); do echo "#include \"$$file\"" >> UB.c; done


#----------- build with .o files -----------------------------------------------

# link .o files, make executable
obj: $(OBJECTS) $(BINARYDIR)/$(CLASSNAME).$(EXTENSION)

	$(CC) -o $(CLASSNAME).$(EXTENSION) $(LD_FLAGS) $(ARCHFLAGS) $(OBJECTS)
	

# compile .c files, make .o files	
$(OBJECTS): $(SRC) $(HEADERS)

	$(CC) -c $(SRC) $(C_FLAGS) $(ARCHFLAGS) $(INCLUDES)


#----------- copy binary from ./ to $(BINARYDIR) -------------------------------

$(BINARYDIR)/$(CLASSNAME).$(EXTENSION): $(CLASSNAME).$(EXTENSION)
	cp -f $(CLASSNAME).$(EXTENSION) $(BINARYDIR)/$(CLASSNAME).$(EXTENSION)


#----------- copy binary from ./ to install directory --------------------------

install: $(CLASSNAME).$(EXTENSION)
	cp -f $(CLASSNAME).$(EXTENSION) $(INSTALLDIR)/$(CLASSNAME).$(EXTENSION)


#----------- strip executable --------------------------------------------------

strip: $(CLASSNAME).$(EXTENSION)
	strip $(STRIPFLAGS) $(CLASSNAME).$(EXTENSION)


#----------- local clean -------------------------------------------------------

clean:
	rm -f *.o *.s *.i UB.c $(CLASSNAME).$(EXTENSION)


################################################################################

# Developer targets: asm pre ubpre ubasm vars deps
# Preprocessor, assembly, and object files are stored in ./
# Make clean before distribution!


#----------- assembly files, .s files ------------------------------------------

asm: $(SRC)
	$(CC) -S -c $^ $(C_FLAGS) $(INCLUDES)


#----------- preprocessor output for all files in SRC --------------------------

pre: $(IFILES)

$(IFILES): %.i: %.c
	$(CC) -E $^ $(C_FLAGS) $(INCLUDES) -o $@


#----------- preprocessor output for Unity Build -------------------------------

ubpre: $(UBSRC)
	$(CC) -E UB.c $(C_FLAGS) $(INCLUDES) -o UB.i


#----------- assembly files for Unity Build ------------------------------------

ubasm: $(UBSRC)
	$(CC) -S -c UB.c $(C_FLAGS) $(INCLUDES)


#----------- check variables and dependencies ----------------------------------

vars:
	@echo SRC = $(SRC)
	@echo INCLUDES = $(INCLUDES)
	@echo C_FLAGS = $(C_FLAGS) 
	@echo LD_FLAGS = $(LD_FLAGS)
	@echo ARCHFLAGS = $(ARCHFLAGS)
	@echo STRIPFLAGS = $(STRIPFLAGS)
	@echo HEADERS = $(HEADERS)


deps:
	@echo DEPENDENCIES = $(DEPENDENCIES)
