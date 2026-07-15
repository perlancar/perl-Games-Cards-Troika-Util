package Games::Cards::Troika::Util;

use 5.010001;
use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our %SPEC;

$SPEC{troika_list_cards} = {
    v => 1.1,
    summary => 'Return the list of cards',
    args => {
        lang => {schema => ['str*', in=>['eng', 'ind', 'fra'], default=>'eng']},
        descriptive => {schema => 'bool*'},
        detail => {schema => 'bool*'},
    },
    args_rels => {
        choose_one => [qw/descriptive detail/],
    },
};
sub troika_list_cards {
    my %args = @_;

    my $lang = $args{lang} // 'eng';

    require TableData::Games::Cards::Troika;
    my $t = TableData::Games::Cards::Troika->new;

    my @rows;
    while ($t->has_next_row) {
        my $row = $t->get_next_row_hashref;
        push @rows, $row;
    }

    if ($args{detail}) {
        1;
    } elsif ($args{descriptive}) {
        @rows = map { $_->{"${lang}_descriptive_name"} } @rows;

    } else {
        @rows = map { $_->{"${lang}_short_name"} } @rows;
    }

    [200, "OK", \@rows];
}

1;
# ABSTRACT: Utilities related to the Anak Bos Troika card game

=head1 DESCRIPTION


=head1 SEE ALSO

Website of publisher. L<https://www.engaginc.com/> .

Homepage for the game. L<https://www.engaginc.com/products/anak-bos-troika/> .

Some additional materials for the game (instruction, logo, box mockup). L<https://github.com/berdikaritc/engaginc-productinfo-troika> .
