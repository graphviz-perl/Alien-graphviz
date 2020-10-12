use Test2::V0;
use Test::Alien;
use Alien::graphviz;

alien_ok 'Alien::graphviz';

xs_ok do { local $/; <DATA> }, with_subtest {
  isnt Foo::gvcv(), undef, 'Foo::gvcVersion() returns defined';
};

my @symbols = qw(gvcVersion gvContext);
#extern GVC_t *gvContext(void);
#extern char *gvcVersion(GVC_t*);
ffi_ok { symbols => \@symbols }, with_subtest {
  my($ffi) = @_;
  my $gvContext = $ffi->function(gvContext => [] => 'opaque');
  my $gvcVersion = $ffi->function(gvcVersion => ['opaque'] => 'char*');
  my $c = $gvContext->();
  isnt $c, undef, 'defined context';
  my $version = $gvcVersion->($c);
  isnt $version, undef, 'defined version';
};

done_testing;

__DATA__
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <gvc.h>

MODULE = Foo PACKAGE = Foo

char *
gvcv()
    CODE:
        RETVAL = gvcVersion(gvContext());
    OUTPUT:
        RETVAL

