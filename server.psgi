use strict;
use warnings;

use Plack::Builder;

my $app = sub {
  [ 302, [ 'Location' => './index.html' ], [''] ]
};

builder {
  enable 'Static', path => qw{^/.+}, root => '.';
  $app;
};
