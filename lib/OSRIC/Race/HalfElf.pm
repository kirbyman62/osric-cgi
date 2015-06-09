package OSRIC::Race::HalfElf;
use parent qw(OSRIC::Race);
use OSRIC::Util qw/d/;

# The stat buffs/nerfs a race gives:
sub stats_boosts
{
	{
		str => 0,
		dex => 0,
		con => 0,
		intl => 0,
		wis => 0,
		cha => 0,
	}
}

# The permitted classes:
sub permitted_classes
{
	[ [ "Assassin" ], [ "Cleric" ], [ "Fighter" ], [ "MagicUser" ],
	[ "Ranger" ], [ "Thief" ], [ "Cleric", "Fighter" ], 
	[ "Cleric", "Ranger" ], [ "Cleric", "MagicUser" ],
	[ "Fighter", "MagicUser" ], [ "Fighter", "Thief" ],
	[ "MagicUser", "Thief" ], [ "Cleric", "Fighter", "MagicUser" ],
	[ "Fighter", "MagicUser", "Thief" ] ]
}

# A hash of subs to generate the starting age based on class:
sub ages
{
	{
		assassin 	=> sub { 22 + d(8, 3) },
		cleric 		=> sub { 40 + d(4, 2) },
		druid 		=> sub { 40 + d(4, 2) },
		fighter 	=> sub { 22 + d(4, 3) },
		illusionist => sub { 30 + d(8, 3) },
		magicuser 	=> sub { 30 + d(8, 2) },
		paladin 	=> sub { 22 + d(4, 3) },
		ranger 		=> sub { 22 + d(4, 3) },
		thief 		=> sub { 22 + d(8, 3) },
	}
}

# The racial limitations:
sub racial_limitations
{
	{
		str => { min => 3, max => 18 },
		dex => { min => 6, max => 18 },
		con => { min => 6, max => 18 },
		intl => { min => 4, max => 18 },
		wis => { min => 3, max => 18 },
		cha => { min => 3, max => 18 },
	}
}

1;
