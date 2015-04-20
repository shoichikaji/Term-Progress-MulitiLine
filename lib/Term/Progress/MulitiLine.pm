package Term::Progress::MulitiLine;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

my $BEGIN  = "\r";
my $UP     = "\e[1A";
my $DELETE = "\e[K";

sub new {
    my ($class, %option) = @_;
    my $fh = delete $option{fh} || \*STDERR;
    my $lines = delete $option{lines} || [];
    bless { fh => $fh, lines => $lines, previous_lines => 0 }, $class;
}

sub lines {
    my $self = shift;
    my $ref  = ref $_[0];
    if ($ref eq 'CODE') {
        $self->{lines} = $_[0]->($self->{lines});
    } elsif ($ref eq 'ARRAY') {
        $self->{lines} = $_[0];
    } else {
        die "Unexpected argument";
    }
}

sub update {
    my $self = shift;
    $self->_delete_previous;
    my $fh = $self->{fh};
    print {$fh} join("\n", map { chomp $_; $_ } @{ $self->{lines} });
    $self->{previous_lines} = scalar @{ $self->{lines} };
}

sub _delete_previous {
    my $self = shift;
    my $fh = $self->{fh};
    print {$fh} $BEGIN;
    for my $i ( 0 .. ($self->{previous_lines} - 1) ) {
        print {$fh} $DELETE;
        print {$fh} $UP if $i < $self->{previous_lines} - 1;
    }
}

sub finish {
    my $self = shift;
    my $fh = $self->{fh};
    print {$fh} "\n";
}

1;
__END__

=encoding utf-8

=head1 NAME

Term::Progress::MulitiLine - It's new $module

=head1 SYNOPSIS

    use Term::Progress::MulitiLine;

    my $t = Term::Progress::MulitiLine->new(fh => \*STDERR);
    $t->lines( [ "hello", "world" ] );

    while (1) {
        $t->update;
        sleep 1;
        $t->lines(sub {
            my $lines = shift;
            # change lines...
            $lines;
        });
    }

=head1 DESCRIPTION

Term::Progress::MulitiLine is ...

=head1 LICENSE

Copyright (C) Shoichi Kaji.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Shoichi Kaji E<lt>skaji@cpan.orgE<gt>

=cut

