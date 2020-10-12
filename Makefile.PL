use ExtUtils::MakeMaker;
use Alien::Build::MM;

my $abmm = Alien::Build::MM->new;

WriteMakefile($abmm->mm_args(
  ABSTRACT           => 'Discover or download and install libgvc (from Graphviz)',
  AUTHOR             => q{Ed J <etj@cpan.org>},
  NAME               => 'Alien::graphviz',
  DISTNAME           => 'Alien-graphviz', # needed by ABMM though not by EUMM
  VERSION_FROM       => 'lib/Alien/graphviz.pm',
  CONFIGURE_REQUIRES => {
    'Alien::Build::MM' => 0,
  },
  BUILD_REQUIRES => {
    'Alien::Build::MM' => 0,
  },
  PREREQ_PM => {
    'Alien::Base' => 0,
  },
  TEST_REQUIRES => {
    'Test::Alien' => 0,
    'Test2::V0' => 0,
    'FFI::Platypus' => '0.12',
  },
));

sub MY::postamble {
  $abmm->mm_postamble;
}
