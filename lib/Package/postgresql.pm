package Package::postgresql;

use strict;
use warnings;

use base qw(Package);

our $VERSION = '8.2.5';


sub base_url {
	return "ftp://ftp2.ch.postgresql.org/pub/mirrors/postgresql/source/v$VERSION/";
}


sub packagename {
	return "postgresql-" . $VERSION;
}


sub build_sourcedirs {
	my $self = shift @_;
	return map {$self->packagesrcdir() . "/$_"} qw(src/interfaces src/include);
}



sub subpath_for_check {
	return "lib/libpq.dylib";
}


sub make_flags {
	return '';
}

sub php_extension_configure_flags {
	my $self = shift @_;
	my (%args) = @_;
	my $prefix = $self->config()->prefix();
	return "--with-pgsql=shared,$prefix --with-pdo-pgsql=shared,$prefix";
}



sub php_dso_extension_names {
	my $self = shift @_;
	return qw(pgsql pdo_pgsql);
}



sub package_filelist {
	my $self = shift @_;
	return $self->config()->extdir_path('*pgsql'), qw(
		lib/libpgtypes*.dylib
		lib/libpq*.dylib
		php.d/50-extension-*pgsql*.ini
	);
}





1;
