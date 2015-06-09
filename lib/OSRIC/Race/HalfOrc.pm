package OSRIC::Race::HalfOrc;
use parent qw(OSRIC::Race);
use OSRIC::Util qw/d/;

# The stat buffs/nerfs a race gives:
sub stats_boosts
{
	{
		str => 1,
		dex => 0,
		con => 1,
		intl => 0,
		wis => 0,
		cha => -2,
	}
}

# The permitted classes:
sub permitted_classes
{
	[ [ "Assassin" ], [ "Cleric" ], [ "Fighter" ], [ "Thief" ],
	[ "Cleric", "Fighter" ], [ "Cleric", "Thief" ], [ "Cleric", "Assassin" ],
	[ "Fighter", "Thief" ], [ "Fighter", "Assassin" ] ]
}

# A hash of subs to generate the starting age based on class:
sub ages
{
	{
		assassin 	=> sub { 20 + d(4, 2) },
		cleric 		=> sub { 20 + d(4) },
		druid 		=> sub { 20 + d(4) },
		fighter 	=> sub { 13 + d(4) },
		illusionist => sub { 0 },
		magicuser 	=> sub { 0 },
		paladin 	=> sub { 13 + d(4) },
		ranger 		=> sub { 13 + d(4) },
		thief 		=> sub { 20 + d(4, 2) },
	}
}

# The racial limitations:
sub racial_limitations
{
	{
		str => { min => 6, max => 18 },
		dex => { min => 3, max => 17 },
		con => { min => 13, max => 19 },
		intl => { min => 3, max => 17 },
		wis => { min => 3, max => 14 },
		cha => { min => 3, max => 12 },
	}
}

1;
