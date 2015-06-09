package OSRIC::Race::Halfling;
use parent qw(OSRIC::Race);
use OSRIC::Util qw/d/;

# The stat buffs/nerfs a race gives:
sub stats_boosts
{
	{
		str => -1,
		dex => 1,
		con => 0,
		intl => 0,
		wis => 0,
		cha => 0,
	}
}

# The permitted classes:
sub permitted_classes
{
	[ [ "Fighter" ], [ "Druid" ], [ "Thief" ], [ "Fighter", "Thief" ] ]
}

# A hash of subs to generate the starting age based on class:
sub ages
{
	{
		assassin 	=> sub { 40 + d(4, 2) },
		cleric 		=> sub { 40 + d(4, 3) },
		druid 		=> sub { 40 + d(4, 3) },
		fighter 	=> sub { 20 + d(4, 3) },
		illusionist => sub { 0 },
		magicuser 	=> sub { 0 },
		paladin 	=> sub { 20 + d(4, 3) },
		ranger 		=> sub { 20 + d(4, 3) },
		thief 		=> sub { 40 + d(4, 2) },
	}
}

# The racial limitations:
sub racial_limitations
{
	{
		str => { min => 6, max => 17 },
		dex => { min => 8, max => 19 },
		con => { min => 10, max => 18 },
		intl => { min => 6, max => 18 },
		wis => { min => 3, max => 17 },
		cha => { min => 3, max => 18 },
	}
}

1;
