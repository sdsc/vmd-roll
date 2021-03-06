#
# 				Rocks(r)
# 		         www.rocksclusters.org
# 		         version 7.0 (Manzanita)
#
# Copyright (c) 2000 - 2017 The Regents of the University of California.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# Modification, are permitted provided that the following conditions are
# Met:
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
ADDED_LIBS_3 = mafft

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
	for F in $(ADDED_LIBS_3); do \
	  cp license-files/$$F-LICENSE $(SOURCE_DIR)/$$F-LICENSE; \
	done
	$(CHECK_LICENSE_FILES)
	echo University of Illinois > $@

build: $(SRC_DIRS)
	patch $(SOURCE_DIR)/Makefile patch-files/Makefile.patch
	perl -pi -e 's!ROLLVMDCOMP!$(VMDCOMP)!g' $(SOURCE_DIR)/Makefile
	perl -pi -e 's!ROLLPKGROOT!$(PKGROOT)!g' $(SOURCE_DIR)/Makefile
	patch $(FLTK_DIR)/Makefile patch-files/fltk/Makefile.patch
	perl -pi -e 's!ROLLINSTALL!$(CURDIR)/$(SOURCE_DIR)/lib/fltk!' $(FLTK_DIR)/Makefile
	patch plugins/Make-arch patch-files/plugins/Make-arch.patch
	perl -pi -e 's!ROLLCC!mpicc!' plugins/Make-arch
	perl -pi -e 's!ROLLCXX!mpicxx!' plugins/Make-arch
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
          python_version=`python3 -c "from __future__ import print_function;import sys; print(sys.version[:3])"`; \
          numpy_version=`python3 -c "import numpy; print(numpy.__version__)"`; \
 	  perl -pi -e 's!PYTHON_INCLUDE_DIR!'$${PYTHONROOT}'/include/python'$${python_version}m'!g' $(SOURCE_DIR)/configure; \
 	  perl -pi -e 's!PYTHON_LIBRARY_DIR!'$${PYTHONROOT}'/lib!g' $(SOURCE_DIR)/configure; \
 	  perl -pi -e 's!PYVERSION!'$${python_version}m'!g' $(SOURCE_DIR)/configure; \
          PYTHON_INCLUDE=`find $${PYTHONROOT}/lib/python$${python_version} -name arrayobject.h | sed 's/numpy.arrayobject.h//'`; \
 	  perl -pi -e "s!NUMPY_INCLUDE_DIR!$${PYTHON_INCLUDE}!g" $(SOURCE_DIR)/configure; \
	  cd $(TACHYON_DIR)/unix; \
	  make $(TACHYON_ARCH); \
	  cd ..; \
	  cp compile/*/libtachyon.a ../$(SOURCE_DIR)/lib/$(TACHYON_NAME)/lib/;\
	  cp src/*.h ../$(SOURCE_DIR)/lib/$(TACHYON_NAME)/include/; \
	  cd ../$(ACTC_DIR); \
	  make CC=$(CC); \
	  cp *.a ../$(SOURCE_DIR)/lib/actc/lib/; \
	  cp *.h ../$(SOURCE_DIR)/lib/actc/include/; \
	  cd ../$(FLTK_DIR); \
	  make CXX=$(CXX) LIBS="-ldl -fPIC"; \
	  make CXX=$(CXX) prefix=`pwd`/../$(SOURCE_DIR)/lib/fltk install; \
          cd ../$(MAFFT_DIR)/core; \
          make CC=$(CC); \
          cd ../../$(STRIDE_DIR); \
          make CC="$(CC) -O2"; \
          cd ../$(SOURCE_DIR)/lib/surf; \
          gunzip surf.tar.Z; \
          tar xf surf.tar; \
          makedepend; \
          make CC=$(CC); \
          cd ../../../plugins/phylotree/src; \
          cp $(CURDIR)/Makefile.upgmaclu Makefile; \
          make CC=$(CC); \
          cd ../../../plugins/clustalw/src; \
          cp $(CURDIR)/Makefile.clustalw Makefile; \
          make CC=$(CC); \
 	  cd ../../../plugins; \
 	  perl -pi -e 's!ROLLNETCDF!'$${NETCDFHOME}'!g' Make-arch; \
 	  perl -pi -e 's!ROLLHDF5!'$${HDF5HOME}'!g' Make-arch; \
	  perl -pi -e 's!ROLLMPI!'$${MPIHOME}'!g' Make-arch; \
 	  make LINUXAMD64; \
 	  make PLUGINDIR=`pwd`/../$(SOURCE_DIR)/plugins distrib; \
          cd libbiokit/src/libbiokit; \
          cp $(CURDIR)/Makefile.libbiokit Makefile; \
          make CXX=$(CXX); \
          cd ../utils; \
          cp $(CURDIR)/Makefile.utils Makefile; \
          make; \
          cd ../../../stamp/src; \
          cp $(CURDIR)/Makefile.stamp Makefile; \
          make CXX=$(CXX); \
          cd ../../cionize; \
          cp $(CURDIR)/Makefile.cionize Makefile; \
          cp ../compile/lib_LINUXAMD64/molfile/libmolfile_plugin.h . ; \
          make CC=$(CC) CXX=$(CXX); \
          cd ../volutil/src; \
          cp $(CURDIR)/Makefile.volutil Makefile; \
          cp ../../compile/lib_LINUXAMD64/molfile/libmolfile_plugin.h . ; \
          make CXX=$(CXX); \
          cd ../../rnaview/src; \
          cp ${CURDIR}/Makefile.rnaview Makefile; \
          make CC=$(CC); \
          cd ../../catdcd; \
          cp ${CURDIR}/Makefile.catdcd Makefile; \
          make CXX=$(CXX); \
	  cd ../../$(SOURCE_DIR); \
	  perl -pi -e 's!ROLLNETCDF!'$${NETCDFHOME}'!g' configure; \
	  perl -pi -e 's!ROLLHDF5!'$${HDF5HOME}'!g' configure; \
	  export VMDINSTALLBINDIR=$(PKGROOT)/bin; \
	  export VMDINSTALLLIBRARYDIR=$(PKGROOT)/lib; \
	  make VERBOSE=1 linux.amd64.opengl; \
	  perl -pi -e 's!$$! /usr/lib64/libXext.so.6 /usr/lib64/libXft.so.2 /usr/lib64/libfontconfig.so.1! ..if $$_ =~ /^LOADLIBES/' src/Makefile; \
	  cd src; \
	  patch Makefile $(REDHAT.ROOT)/src/vmd/patch-files/src/Makefile.patch; \
	  make \
	)
	@echo "::: Package $(NAME) build complete :::"
	
install::
	mkdir -p -m 755 $(ROOT)/$(PKGROOT)/bin
	$(PKGROOT_BIND_MOUNT)
	( \
          cp $(STRIDE_DIR)/stride $(SOURCE_DIR)/lib/stride/stride_LINUXAMD64; \
          cp $(TACHYON_DIR)/compile/linux-icc-thr-ogl/tachyon $(SOURCE_DIR)/lib/tachyon/tachyon_LINUXAMD64; \
          cp  $(SOURCE_DIR)/lib/surf/surf $(SOURCE_DIR)/lib/surf/surf_LINUXAMD64; \
          cd $(SOURCE_DIR)/src; \
          make install; \
          cd ../..; \
          cp $(MAFFT_DIR)/binaries/* $(PKGROOT)/bin; \
          mkdir -p $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/mafft1.1; \
          cp plugins/mafft/mafft.tcl $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/mafft1.1; \
          cp plugins/mafft.new/pkgIndex.tcl $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/mafft1.1; \
          cp $(MAFFT_DIR)/core/mafft $(PKGROOT)/bin; \
          mkdir -p $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/phylotree1.2; \
          cp plugins/phylotree/*.tcl $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/phylotree1.2 ; \
          mkdir $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/stamp1.2; \
          cp plugins/stamp/src/stamp $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/stamp1.2; \
          cp plugins/stamp/*.tcl plugins/stamp/*.directories $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/stamp1.2; \
          find plugins/libbiokit/src/utils \( -executable -a -type f -not -name Makefile \) -exec cp \{\} $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/libbiokit1.1 \; ; \
          cp plugins/libbiokit/src/libbiokit/libbiokit.so $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/libbiokit1.1; \
          cp stamp.defaults $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/stamp1.2; \
          cp plugins/phylotree/src/upgmaclu $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/phylotree1.2; \
          mkdir -p $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/clustalw1.1; \
          cp plugins/clustalw/*.tcl $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/clustalw1.1; \
          cp plugins/clustalw/src/clustalw $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/clustalw1.1; \
          mkdir -p $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/cionize1.0; \
          cp plugins/cionize/cionize $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/cionize1.0; \
          cp plugins/cionize/*.tcl  $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/cionize1.0; \
          mkdir -p $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/volutil1.3; \
          cp plugins/volutil/src/volutil $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/volutil1.3; \
          cp plugins/volutil/*.tcl $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/volutil1.3; \
          mkdir -p $(PKGROOT)/lib/plugins/noarch/tcl/qwikmd1.1; \
          cp plugins/qwikmd/*.tcl  $(PKGROOT)/lib/plugins/noarch/tcl/qwikmd1.1; \
          cp plugins/qwikmd/*.conf  $(PKGROOT)/lib/plugins/noarch/tcl/qwikmd1.1; \
          mkdir -p $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/rnaview1.1; \
          cp plugins/rnaview/src/rnaview $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/rnaview1.1; \
          cp plugins/rnaview/*.tcl $(PKGROOT)/lib/plugins/LINUXAMD64/tcl/rnaview1.1; \
          cp plugins/catdcd/catdcd $(PKGROOT)/bin; \
	)
	$(PKGROOT_BIND_UMOUNT)
	$(INSTALL_LICENSE_FILES)
	@echo "::: Package $(NAME) install complete :::"

clean::
	rm -rf $(SOURCE_DIR) $(ACTC_DIR) $(FLTK_DIR) $(TACHYON_DIR) $(MAFFT_DIR) $(STRIDE_DIR) plugins DESCRIPTION LICENSE
