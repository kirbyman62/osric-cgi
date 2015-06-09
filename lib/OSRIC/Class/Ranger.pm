package OSRIC::Class::Ranger;
use parent qw(OSRIC::Class);
use OSRIC::Util qw/d alignments/;

# A sub to get the maximum amount of starting gold (for sorting) and one to get
# an actual amount of starting gold: 
sub max_starting_gold { 200 }
sub get_gold { ((d(6, 3) + 2) * 10) } # (3d6 + 2) * 10

# The starting HP of the class:
sub get_hp { d(8) }

# Minimum score requirements:
sub minimum_scores
{
	{
		str => 13,
		dex => 6,
		con => 14,
		intl => 13,
		wis => 14,
		cha => 6,
	}
}

# The allowed alignments
sub get_alignments
{
	my @a = grep { $_ =~ /^good/i } alignments;
	return \@a;
}

1;
