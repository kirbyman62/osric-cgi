package OSRIC::Class::Thief;
use parent qw(OSRIC::Class);
use OSRIC::Util qw/d alignments/;

# A sub to get the maximum amount of starting gold (for sorting) and one to get
# an actual amount of starting gold: 
sub max_starting_gold { 120 }
sub get_gold { (d(6, 2) * 10) } # 2d6 * 10

# The starting HP of the class:
sub get_hp { d(6) }

# Minimum score requirements:
sub minimum_scores
{
	{
		str => 6,
		dex => 9,
		con => 6,
		intl => 6,
		wis => 0,
		cha => 6,
	}
}

# The allowed alignments
sub get_alignments
{
	my @a = grep { $_ =~ /(?:neutral|evil)$/i } alignments;
	return \@a;
}

1;
