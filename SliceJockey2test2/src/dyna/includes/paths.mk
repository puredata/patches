# Shared paths for all Pd classes in src/
# Windows: path to pd.dll (for linking) is set in flags.mk

PATHS = present


# Paths to shared headers (m_pd.h etc.)

SHAREDPATHS := $(DIRDEPTH)/includes


# paths to install binaries

BINARYDIR := $(DIRDEPTH)/../bin/$(LIBNAME)
INSTALLDIR := $(DIRDEPTH)/../bin/$(LIBNAME)


