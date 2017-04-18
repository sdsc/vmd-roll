# SDSC "vmd" roll

## Overview

This roll bundles the Visual Molecular Dynamics package.  For more information
about the package, please visit the <a href="http://www.ks.uiuc.edu/Research/vmd">official web page</a>.

## Requirements

To build/install this roll you must have root access to a Rocks development
machine (e.g., a frontend or development appliance).

If your Rocks development machine does *not* have Internet access you must
download the appropriate vmd source file(s) using a machine that does have
Internet access and copy them into the `src/<package>` directories on your Rocks
development machine.


## Dependencies

The sdsc-roll must be installed on the build machine, since the build process
depends on make include files provided by that roll.

The roll sources assume that modulefiles provided by SDSC compiler, python,
and MPI
rolls are available, but it will build without them as long as the environment
variables they provide are otherwise defined.

The build process requires cmake and the NETCDF libraries and assumes that
the modulefiles provided by the SDSC cmake-roll and netcdf-roll
are available.  It will build without the modulefiles as long as
the environment variables they provide are otherwise defined.


## Building

To build the vmd-roll, execute this on a Rocks development
machine (e.g., a frontend or development appliance):

```shell
% make 2>&1 | tee build.log
```

A successful build will create the file `vmd-*.disk1.iso`.  If you built the
roll on a Rocks frontend, proceed to the installation step. If you built the
roll on a Rocks development appliance, you need to copy the roll to your Rocks
frontend before continuing with installation.
with installation.

This roll source supports building with different compilers and for different
MPI flavors and python installations.  The `ROLLCOMPILER`, `ROLLMPI`, and
`ROLLPY` make variables can be used to specify the names of compiler, MPI, and
python modulefiles to use for building the software, e.g.,

```shell
make ROLLCOMPILER=intel ROLLMPI=mvapich2_ib ROLLPY=opt-python 2>&1 | tee build.log
```

The build process recognizes "gnu", "intel" or "pgi" as the value for the
`ROLLCOMPILER` variable; any MPI modulefile name may be used as the value of
the `ROLLMPI` variable, and any python modulefile name for the ROLLPY variable.
The default values are "gnu", "rocks-openmpi", and "python".


## Installation

To install, execute these instructions on a Rocks frontend:

```shell
% rocks add roll *.iso
% rocks enable roll vmd
% cd /export/rocks/install
% rocks create distro
% rocks run roll vmd | bash
```

In addition to the software itself, the roll installs vmd environment
module files in:

```shell
/opt/modulefiles/applications/vmd
```


## Testing

The vmd-roll includes a test script which can be run to verify proper
installation of the roll documentation, binaries and module files. To
run the test scripts execute the following command(s):

```shell
% /root/rolltests/vmd.t 
```
