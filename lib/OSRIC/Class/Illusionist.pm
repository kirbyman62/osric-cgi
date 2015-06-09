package OSRIC::Class::Illusionist;
use parent qw(OSRIC::Class);
use OSRIC::Util qw/d alignments/;

# A sub to get the maximum amount of starting gold (for sorting) and one to get
# an actual amount of starting gold: 
sub max_starting_gold { 80 }
sub get_gold { (d(4, 2) * 10) } # 2d4 * 10

# The starting HP of the class:
sub get_hp { d(4) }

# Minimum score requirements:
sub minimum_scores
{
	{
		str => 6,
		dex => 16,
		con => 0,
		intl => 15,
		wis => 6,
		cha => 6,
	}
}

# The allowed alignments
sub get_alignments
{
	my @a = alignments;
	return \@a;
}

1;
