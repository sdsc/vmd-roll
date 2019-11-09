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
VERSION         = 1.9.4a38
RELEASE         = 0
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

MAFFT_NAME    = mafft
MAFFT_SUFFIX  = tgz
MAFFT_VERSION = 7.394
MAFFT_PKG     = $(MAFFT_NAME)-$(MAFFT_VERSION)-with-extensions-src.$(MAFFT_SUFFIX)
MAFFT_DIR     = $(MAFFT_NAME)-$(MAFFT_VERSION)-with-extensions

STRIDE_NAME    = stride
STRIDE_SUFFIX  = tar.gz
STRIDE_VERSION = 1.0
STRIDE_PKG     = $(STRIDE_NAME)-$(STRIDE_VERSION).$(STRIDE_SUFFIX)
STRIDE_DIR     = $(STRIDE_NAME)-$(STRIDE_VERSION)

TAR_GZ_PKGS     = $(SOURCE_PKG) $(ACTC_PKG) $(FLTK_PKG) $(TACHYON_PKG) $(STRIDE_PKG)
TGZ_PKGS        = $(MAFFT_PKG)

RPM.EXTRAS      = AutoReq:No\nAutoProv:No
RPM.PREFIX      = $(PKGROOT)
