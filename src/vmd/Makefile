# @Copyright@
# 
# 				Rocks(r)
# 		         www.rocksclusters.org
# 		         version 5.6 (Emerald Boa)
# 		         version 6.1 (Emerald Boa)
# 
# Copyright (c) 2000 - 2013 The Regents of the University of California.
# All rights reserved.	
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright
# notice unmodified and in its entirety, this list of conditions and the
# following disclaimer in the documentation and/or other materials provided 
# with the distribution.
# 
# 3. All advertising and press materials, printed or electronic, mentioning
# features or use of this software must display the following acknowledgement: 
# 
# 	"This product includes software developed by the Rocks(r)
# 	Cluster Group at the San Diego Supercomputer Center at the
# 	University of California, San Diego and its contributors."
# 
# 4. Except as permitted for the purposes of acknowledgment in paragraph 3,
# neither the name or logo of this software nor the names of its
# authors may be used to endorse or promote products derived from this
# software without specific prior written permission.  The name of the
# software includes the following terms, and any derivatives thereof:
# "Rocks", "Rocks Clusters", and "Avalanche Installer".  For licensing of 
# the associated name, interested parties should contact Technology 
# Transfer & Intellectual Property Services, University of California, 
# San Diego, 9500 Gilman Drive, Mail Code 0910, La Jolla, CA 92093-0910, 
# Ph: (858) 534-5815, FAX: (858) 534-7345, E-MAIL:invent@ucsd.edu
# 
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS''
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
# @Copyright@
#
# $Log$


REDHAT.ROOT = $(PWD)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include $(SDSCDEVEL)/Pull.mk
include $(SDSCDEVEL)/Rules.mk

ADDED_LIBS_1 = actc tachyon
ADDED_LIBS_2 = fltk

VMDCOMP = GCC
ifeq ("$(COMPILERNAME)", "intel")
  VMDCOMP = ICC
endif

TACHYON_ARCH = linux-64-thr-ogl
ifeq ("$(COMPILERNAME)", "intel")
  TACHYON_ARCH = linux-icc-thr-ogl
endif

$(NAME).spec: DESCRIPTION LICENSE

DESCRIPTION:
	$(MODULE_LOAD_CC); \
	$(MODULE_LOAD_PYTHON); \
	( \
	  $(DESCRIBE_PKG); \
	  $(DESCRIBE_CC); \
	  $(DESCRIBE_PYTHON); \
	  $(DESCRIBE_MPI); \
	  $(DESCRIBE_NETCDF) \
	) > $@

LICENSE: $(SRC_DIRS)
	for F in $(ADDED_LIBS_1); do \
	  cp license-files/$$F-PKG-INFO $(SOURCE_DIR)/$$F-PKG-INFO; \
	done
	for F in $(ADDED_LIBS_2); do \
	  cp license-files/$$F-COPYING $(SOURCE_DIR)/$$F-COPYING; \
	done
	$(CHECK_LICENSE_FILES)
	echo University of Illinois > $@

build: $(SRC_DIRS)
	patch $(SOURCE_DIR)/Makefile patch-files/Makefile.patch
	perl -pi -e 's!ROLLVMDCOMP!$(VMDCOMP)!g' $(SOURCE_DIR)/Makefile
	perl -pi -e 's!ROLLPKGROOT!$(PKGROOT)!g' $(SOURCE_DIR)/Makefile
	patch $(FLTK_DIR)/Makefile patch-files/fltk/Makefile.patch
	perl -pi -e 's!ROLLINSTALL!$(CURDIR)/$(SOURCE_DIR)/lib/fltk!' $(FLTK_DIR)/Makefile
	patch $(SOURCE_DIR)/configure patch-files/configure.patch
	mkdir -p $(SOURCE_DIR)/lib/$(TACHYON_NAME)/{include,lib}
	mkdir -p $(SOURCE_DIR)/lib/actc/{include,lib}
	mkdir -p $(SOURCE_DIR)/lib/fltk
	( \
	  $(MODULE_LOAD_CMAKE); \
	  $(MODULE_LOAD_PYTHON); \
	  $(MODULE_LOAD_CC); \
	  $(MODULE_LOAD_MPI); \
	  $(MODULE_LOAD_NETCDF); \
	  export PYTHON_INCLUDE_DIR=$${PYTHONROOT}/include/python2.7; \
	  export PYTHON_LIBRARY_DIR=$${PYTHONROOT}/lib; \
	  export NUMPY_INCLUDE_DIR=$${PYTHONROOT}/lib/python2.7/site-packages/numpy/core/include; \
	  export CC=$(CC); \
	  cd $(TACHYON_DIR)/unix; \
	  make $(TACHYON_ARCH); \
	  cd ..; \
	  cp compile/*/libtachyon.a ../$(SOURCE_DIR)/lib/$(TACHYON_NAME)/lib/;\
	  cp src/*.h ../$(SOURCE_DIR)/lib/$(TACHYON_NAME)/include/; \
	  cd ../$(ACTC_DIR); \
	  make; \
	  cp *.a ../$(SOURCE_DIR)/lib/actc/lib/; \
	  cp *.h ../$(SOURCE_DIR)/lib/actc/include/; \
	  cd ../$(FLTK_DIR); \
	  make LIBS="-ldl -fPIC"; \
	  make prefix=`pwd`/../$(SOURCE_DIR)/lib/fltk install; \
	  cd ../$(SOURCE_DIR); \
	  perl -pi -e 's!ROLLNETCDF!'$${NETCDFHOME}'!g' configure; \
	  export VMDINSTALLBINDIR=$(PKGROOT)/bin; \
	  export VMDINSTALLLIBRARYDIR=$(PKGROOT)/lib; \
	  make linux.amd64.opengl; \
	  perl -pi -e 's!$$! /usr/lib64/libXext.so.6 /usr/lib64/libXft.so.2 /usr/lib64/libfontconfig.so.1! if $$_ =~ /^LOADLIBES/' src/Makefile; \
	  cd src; \
	  make \
	)
	@echo "::: Package $(NAME) build complete :::"
	
install::
	mkdir -p -m 755 $(ROOT)/$(PKGROOT)/bin
	$(PKGROOT_BIND_MOUNT)
	( \
	  cp $(TACHYON_NAME)/compile/$(TACHYON_ARCH)/tachyon $(ROOT)/$(PKGROOT)/bin; \
	  cd $(SOURCE_DIR)/src; \
	  make install \
	)
	$(PKGROOT_BIND_UMOUNT)
	$(INSTALL_LICENSE_FILES)
	@echo "::: Package $(NAME) install complete :::"

clean::
	rm -rf $(SOURCE_DIR) $(ACTC_DIR) $(FLTK_DIR) $(TACHYON_DIR) DESCRIPTION LICENSE
