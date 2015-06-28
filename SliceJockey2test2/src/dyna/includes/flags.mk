# Define C_FLAGS, LD_FLAGS, ARCHFLAGS, EXTENSION.


VARIABLES = present

#----------- flags for all platforms -------------------------------------------

DEFINEFLAGS := -DPD
OFLAGS := -O3
WARNFLAGS := -Wall -Wextra -Wshadow -Winline
CFLAGS = $(OFLAGS) $(WARNFLAGS)

DEBUGFLAGS := -g
STRIPFLAGS := --strip-unneeded -R .note -R .comment

# only used for multiple-file classes:
VISFLAGS := -fvisibility=hidden


#------------ find current platform --------------------------------------------

UNAME := $(shell uname)

ifeq ($(UNAME), Linux)
MACHINE := $(shell uname -m)
  ifeq ($(MACHINE), armv6l)
  PLATFORM := Linux_armv6l
  endif
  ifeq ($(MACHINE), armv7-a)
  PLATFORM := Linux_armv7
  endif
  ifeq ($(findstring $(MACHINE), i386 i486 i586 i686), $(MACHINE))
  PLATFORM := Linux_i386
  endif
  ifeq ($(findstring $(MACHINE), ia64 x86_64), $(MACHINE))
  PLATFORM := Linux_ia64
  endif
endif
ifeq ($(findstring MINGW, $(UNAME)), MINGW)
PLATFORM := WinMinGW
endif
ifeq ($(UNAME), Darwin)
PLATFORM := Darwin
endif


# ----------------------- LINUX armv6l (Raspberry Pi) --------------------------

ifeq ($(PLATFORM), Linux_armv6l)
DEFINEFLAGS := $(DEFINEFLAGS) -DUNIX -DNOSIMD
EXTENSION := pd_linux
ARCHFLAGS := -march=armv6 -mfpu=vfp
C_FLAGS := -fpic -fsingle-precision-constant -mfloat-abi=hard -marm \
           -mstructure-size-boundary=64
LD_FLAGS := -rdynamic -shared -fpic -lc -lm
endif


# ----------------------- LINUX armv7 ------------------------------------------

ifeq ($(PLATFORM), Linux_armv7-a)
DEFINEFLAGS := $(DEFINEFLAGS) -DUNIX 
EXTENSION := pd_linux
ARCHFLAGS := -march=armv7-a -mcpu=cortex-a8 -mtune=cortex-a8 -mfpu=neon
C_FLAGS := -fpic -ffast-math -fsingle-precision-constant -mfloat-abi=hard
LD_FLAGS := -rdynamic -shared -fpic -lc -lm
endif


# ----------------------- LINUX i386 -------------------------------------------

ifeq ($(PLATFORM), Linux_i386)
DEFINEFLAGS := $(DEFINEFLAGS) -DUNIX
EXTENSION := l_i386
ARCHFLAGS := -march=pentium3 -mtune=pentium3 -mfpmath=sse
C_FLAGS := -fpic
LD_FLAGS := -rdynamic -shared -fpic -lc -lm
endif


# ----------------------- LINUX ia64 -------------------------------------------

ifeq ($(PLATFORM), Linux_ia64)
DEFINEFLAGS := $(DEFINEFLAGS) -DUNIX
EXTENSION := l_ia64
ARCHFLAGS := -march=core2 -mtune=core2 -mfpmath=sse
C_FLAGS := -fpic
LD_FLAGS := -rdynamic -shared -fpic -lc -lm
endif


# ----------------------- Mac OSX ----------------------------------------

ifeq ($(PLATFORM), Darwin)
DEFINEFLAGS := $(DEFINEFLAGS) -DMACOSX -DUNIX -DOSXFAT
EXTENSION := pd_darwin
ARCHFLAGS := -arch i386 -arch x86_64 -arch ppc7400
C_FLAGS := -mmacosx-version-min=10.4
LD_FLAGS := -undefined suppress -flat_namespace -bundle
STRIPFLAGS := -x
endif


# ----------------------- WIN i386 MinGW----------------------------------------

ifeq ($(PLATFORM), WinMinGW)
EXTENSION := dll
CC := gcc
LD := gcc
ARCHFLAGS := -march=pentium3 -mtune=pentium3 -mfpmath=sse
C_FLAGS :=
# find pd.dll for linking. You may define a local pd.ddl instead
PD_DLL := $(shell cd "$$PROGRAMFILES/pd" && pwd)/bin/pd.dll
LD_FLAGS := $(LD_FLAGS) "$(PD_DLL)"
LD_FLAGS := -static-libgcc --export-dynamic -shared
endif


# ----------------- accumulated cc and ld flags --------------------------------

C_FLAGS := $(C_FLAGS) $(CFLAGS) $(DEFINEFLAGS) 
LD_FLAGS := $(LD_FLAGS) $(DEBUGFLAGS)
