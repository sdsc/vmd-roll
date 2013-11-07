SRCDIRS = `find * -prune\
	  -type d 	\
          ! -name vmd-modules \
          ! -name vmd \
          ! -name build-\* \
	  ! -name .` vmd vmd-modules
