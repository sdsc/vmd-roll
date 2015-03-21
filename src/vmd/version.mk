ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLMPI
  ROLLMPI = rocks-openmpi
endif
MPINAME := $(firstword $(subst /, ,$(ROLLMPI)))

PKGROOT=/opt/vmd

NAME    = sdsc-vmd
VERSION = 1.9.2
RELEASE = 0
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

RPM.EXTRAS = "AutoReq: no"

SRC_SUBDIR	= vmd

SOURCE_NAME	= vmd
SOURCE_VERSION	= 1.9.2
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).src.$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_NAME)-$(SOURCE_VERSION)

TACHYON_NAME    = tachyon
TACHYON_VERSION = 0.99b6
TACHYON_DIR      = tachyon

ACTC_NAME    = actc
ACTC_VERSION = 1.1
ACTC_DIR =  $(ACTC_NAME)-$(ACTC_VERSION)

FLTK_NAME    = fltk
FLTK_VERSION = 1.3.3
FLTK_DIR =  $(FLTK_NAME)-$(FLTK_VERSION)


# List of *.tar.gz packages that are part of THIS package

TAR_GZ_PKGS = $(SOURCE_NAME)-$(SOURCE_VERSION).src.tar.gz $(TACHYON_NAME)-$(TACHYON_VERSION).tar.gz $(ACTC_NAME)-$(ACTC_VERSION).tar.gz $(FLTK_NAME)-$(FLTK_VERSION)-source.tar.gz

RPM.EXTRAS     = AutoReq:No
