SRCDIRS = `find * -prune\
	  -type d 	\
	  ! -name CVS	\
          ! -name vmd-modules \
          ! -name vmd \
          ! -name build-\* \
	  ! -name .` vmd vmd-modules
