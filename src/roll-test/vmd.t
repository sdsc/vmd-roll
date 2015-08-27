#!/usr/bin/perl -w
# vmd roll installation test.  Usage:
# vmd.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend

use Test::More qw(no_plan);

my $appliance = $#ARGV >= 0 ? $ARGV[0] :
                -d '/export/rocks/install' ? 'Frontend' : 'Compute';
my $installedOnAppliancesPattern = '.';
my $isInstalled = -d '/opt/vmd';
my $output;

# vmd-common.xml
if($appliance =~ /$installedOnAppliancesPattern/) {
  ok($isInstalled, 'vmd installed');
} else {
  ok(! $isInstalled, 'vmd not installed');
}

SKIP: {

  skip 'vmd not installed', 4 if ! $isInstalled;

  $out=`module load vmd; vmd --help 2>&1`;
  ok($out =~ /VMD for LINUXAMD64,/, 'vmd executable works');

  `/bin/ls /opt/modulefiles/applications/vmd/[0-9]* 2>&1`;
  ok($? == 0, 'vmd module installed');
  `/bin/ls /opt/modulefiles/applications/vmd/.version.[0-9]* 2>&1`;
  ok($? == 0, 'vmd version module installed');
  ok(-l '/opt/modulefiles/applications/vmd/.version',
     'vmd version module link created');

}
