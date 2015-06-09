package OSRIC::Class::Assassin;
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
		str => 12,
		dex => 12,
		con => 6,
		intl => 11,
		wis => 6,
		cha => 0,
	}
}

# The allowed alignments
sub get_alignments
{
	my @a = grep { $_ =~ /^evil/i } alignments;
	return \@a;
}

1;
