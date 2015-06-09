package OSRIC::Race::Elf;
use parent qw(OSRIC::Race);
use OSRIC::Util qw/d/;

# The stat buffs/nerfs a race gives:
sub stats_boosts
{
	{
		str => 0,
		dex => 1,
		con => -1,
		intl => 0,
		wis => 0,
		cha => 0,
	}
}

# The permitted classes:
sub permitted_classes
{
	[ [ "Assassin" ], [ "Cleric" ], [ "Fighter" ], [ "MagicUser" ], [ "Thief" ],
	[ "Fighter", "MagicUser" ], [ "Fighter", "Thief" ],
	[ "MagicUser", "Thief" ], [ "Fighter", "MagicUser", "Thief" ] ]
}

# A hash of subs to generate the starting age based on class:
sub ages
{
	{
		assassin 	=> sub { 100 + d(6,5) },
		cleric 		=> sub { 500 + d(10, 10) },
		druid 		=> sub { 500 + d(10, 10) },
		fighter 	=> sub { 130 + d(6, 5) },
		illusionist => sub { 150 + d(6, 5) },
		magicuser 	=> sub { 150 + d(6, 5) },
		paladin 	=> sub { 130 + d(6, 5) },
		ranger 		=> sub { 130 + d(6, 5) },
		thief 		=> sub { 100 + d(6, 5) },
	}
}

# The racial limitations:
sub racial_limitations
{
	{
		str => { min => 3, max => 18 },
		dex => { min => 7, max => 19 },
		con => { min => 8, max => 17 },
		intl => { min => 8, max => 18 },
		wis => { min => 3, max => 18 },
		cha => { min => 3, max => 18 },
	}
}

1;
