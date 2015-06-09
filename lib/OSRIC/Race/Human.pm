package OSRIC::Race::Human;
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
	[ [ "Assassin" ], [ "Cleric" ], [ "Druid" ], [ "Fighter" ],
	[ "Illusionist" ], [ "MagicUser" ], [ "Paladin" ], [ "Ranger" ],
	[ "Thief" ] ]
}

# A hash of subs to generate the starting age based on class:
sub ages
{
	{
		assassin 	=> sub { 20 + d(4) },
		cleric 		=> sub { 20 + d(4) },
		druid 		=> sub { 20 + d(4) },
		fighter 	=> sub { 15 + d(4) },
		illusionist => sub { 24 + d(8, 2) },
		magicuser 	=> sub { 24 + d(8, 2) },
		paladin 	=> sub { 15 + d(4) },
		ranger 		=> sub { 15 + d(4) },
		thief 		=> sub { 20 + d(4) },
	}
}

# The racial limitations:
sub racial_limitations
{
	{
		str => { min => 0, max => 18 },
		dex => { min => 0, max => 18 },
		con => { min => 0, max => 18 },
		intl => { min => 0, max => 18 },
		wis => { min => 0, max => 18 },
		cha => { min => 0, max => 18 },
	}
}

1;
