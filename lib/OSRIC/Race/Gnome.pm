package OSRIC::Race::Gnome;
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
	[ [ "Assassin" ], [ "Cleric" ], [ "Fighter" ], [ "Illusionist" ],
	[ "Thief" ], [ "Fighter", "Illusionist" ], [ "Fighter", "Thief" ],
	[ "Illusionist", "Thief" ] ]
}

# A hash of subs to generate the starting age based on class:
sub ages
{
	{
		assassin 	=> sub { 80 + d(4, 5) },
		cleric 		=> sub { 300 + d(12, 3) },
		druid 		=> sub { 300 + d(12, 3) },
		fighter 	=> sub { 60 + d(4, 5) },
		illusionist => sub { 100 + d(12, 2) },
		magicuser 	=> sub { 100 + d(12, 2) },
		paladin 	=> sub { 60 + d(4, 5) },
		ranger 		=> sub { 60 + d(4, 5) },
		thief 		=> sub { 80 + d(4, 5) },
	}
}

# The racial limitations:
sub racial_limitations
{
	{
		str => { min => 6, max => 18 },
		dex => { min => 3, max => 19 },
		con => { min => 8, max => 17 },
		intl => { min => 7, max => 18 },
		wis => { min => 3, max => 18 },
		cha => { min => 3, max => 18 },
	}
}

1;
