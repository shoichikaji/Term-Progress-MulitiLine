# NAME

Term::Progress::MulitiLine - It's new $module

# SYNOPSIS

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

# DESCRIPTION

Term::Progress::MulitiLine is ...

# LICENSE

Copyright (C) Shoichi Kaji.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Shoichi Kaji <skaji@cpan.org>
