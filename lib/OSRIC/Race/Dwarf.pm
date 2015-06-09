package OSRIC::Race::Dwarf;
use parent qw(OSRIC::Race);
use OSRIC::Util qw/d/;

# The stat buffs/nerfs a race gives:
sub stats_boosts
{
	{
		str => 0,
		dex => 0,
		con => 1,
		intl => 0,
		wis => 0,
		cha => -1,
	}
}

# The permitted classes:
sub permitted_classes
{
	[ [ "Assassin" ], [ "Cleric" ], [ "Fighter" ], [ "Thief" ],
	[ "Fighter", "Thief" ] ]
}

# A hash of subs to generate the starting age based on class:
sub ages
{
	{
		assassin 	=> sub { 75 + d(6, 3) },
		cleric 		=> sub { 250 + d(20, 2) },
		druid 		=> sub { 250 + d(20, 2) },
		fighter 	=> sub { 40 + d(4, 5) },
		illusionist => sub { 0 },
		magicuser 	=> sub { 0 },
		paladin 	=> sub { 40 + d(4, 5) },
		ranger 		=> sub { 40 + d(4, 5) },
		thief 		=> sub { 75 + d(6, 3) },
	}
}

# The racial limitations:
sub racial_limitations
{
	{
		str => { min => 8, max => 18 },
		dex => { min => 3, max => 17 },
		con => { min => 12, max => 19 },
		intl => { min => 3, max => 18 },
		wis => { min => 3, max => 18 },
		cha => { min => 3, max => 16 },
	}
}

1;
