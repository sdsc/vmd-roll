NAME    = vmd
VERSION = 1.9.2
RELEASE = 0

RPM.EXTRAS = "AutoReq: no"

SRC_SUBDIR	= vmd

VMD_NAME	= vmd
VMD_VERSION	= 1.9.2

TACHYON_NAME    = tachyon
TACHYON_VERSION = 0.99b6

ACTC_NAME    = actc
ACTC_VERSION = 1.1

FLTK_NAME    = fltk
FLTK_VERSION = 1.3.3

# List of *.tar.gz packages that are part of THIS package
TAR_GZ_PKGS = $(VMD_NAME)-$(VMD_VERSION).src.tar.gz $(TACHYON_NAME)-$(TACHYON_VERSION).tar.gz $(ACTC_NAME)-$(ACTC_VERSION).tar.gz $(FLTK_NAME)-$(FLTK_VERSION)-source.tar.gz
