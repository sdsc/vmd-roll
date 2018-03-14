ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLMPI
  ROLLMPI = rocks-openmpi
endif
MPINAME := $(firstword $(subst /, ,$(ROLLMPI)))

ifndef ROLLPY
  ROLLPY = python
endif

NAME            = sdsc-vmd
VERSION         = 1.9.3
RELEASE         = 4
PKGROOT         = /opt/vmd

SRC_SUBDIR      = vmd

SOURCE_NAME     = vmd
SOURCE_SUFFIX   = tar.gz
SOURCE_VERSION  = $(VERSION)
SOURCE_PKG      = $(SOURCE_NAME)-$(SOURCE_VERSION).src.$(SOURCE_SUFFIX)
SOURCE_DIR      = $(SOURCE_NAME)-$(SOURCE_VERSION)

ACTC_NAME       = actc
ACTC_SUFFIX     = tar.gz
ACTC_VERSION    = 1.1
ACTC_PKG        = $(ACTC_NAME)-$(ACTC_VERSION).$(ACTC_SUFFIX)
ACTC_DIR        = $(ACTC_NAME)-$(ACTC_VERSION)

FLTK_NAME       = fltk
FLTK_SUFFIX     = tar.gz
FLTK_VERSION    = 1.3.4-1
FLTK_PKG        = $(FLTK_NAME)-$(FLTK_VERSION)-source.$(FLTK_SUFFIX)
FLTK_DIR        = $(FLTK_NAME)-$(FLTK_VERSION)

TACHYON_NAME    = tachyon
TACHYON_SUFFIX  = tar.gz
TACHYON_VERSION = 0.99b6
TACHYON_PKG     = $(TACHYON_NAME)-$(TACHYON_VERSION).$(TACHYON_SUFFIX)
TACHYON_DIR     = $(TACHYON_NAME)

TAR_GZ_PKGS     = $(SOURCE_PKG) $(ACTC_PKG) $(FLTK_PKG) $(TACHYON_PKG)

RPM.EXTRAS      = AutoReq:No\nAutoProv:No
RPM.PREFIX      = $(PKGROOT)
