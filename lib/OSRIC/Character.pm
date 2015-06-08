package OSRIC::Character;

use OSRIC::Race;
use OSRIC::Race::Dwarf;
use OSRIC::Race::Elf;
use OSRIC::Race::Gnome;
use OSRIC::Race::HalfElf;
use OSRIC::Race::Halfling;
use OSRIC::Race::HalfOrc;
use OSRIC::Race::Human;

use OSRIC::Class;
use OSRIC::Class::Assassin;
use OSRIC::Class::Cleric;
use OSRIC::Class::Druid;
use OSRIC::Class::Fighter;
use OSRIC::Class::Illusionist;
use OSRIC::Class::MagicUser;
use OSRIC::Class::Paladin;
use OSRIC::Class::Ranger;
use OSRIC::Class::Thief;

use OSRIC::Util qw/d con_mod/;
use POSIX qw/ceil/;
use JSON qw/to_json/;
use List::Compare qw/new get_intersection/;

# These functions are ordered in this file in the order they are to be
# called in:

# Generates a new character:
sub new
{
	my $class = shift;
	my $character =
	{
		irc => "", # The player's irc nick, not found on the character sheet.
		personal =>
		{
			name => "",
			classes => [ ],
			alignment => "",
			race => "",
			xp => 0,
			hp => 0,
			ac => 0,
			lvl => 1,
			age => 0,
			height => 0,
			weight => 0,
			sex => "M"
		},
		stats =>
		{
			str => 0,
			dex => 0,
			con => 0,
			intl => 0,
			wis => 0,
			cha => 0,
		},
		equipment =>
		{
			items => [ ],
			weapons => [ ],
			missiles => [ ],
			armour => [ ],
		},
		wealth =>
		{
			coins => 0,
			gems => [ ],
			other => [ ],
		},
	};
	bless $character, $class;
}

# Sets the player's irc nick:
sub set_irc
{
	my $self = shift;
	$self->{irc} = shift;
}

# Generates the 6 major stats:
sub generate_stats
{
	my $self = shift;
	for my $stat(keys %{$self->{stats}})
	{
		# TODO:
		# * A system where players can choose what number to allocate to what
		#	stat.
		$self->{stats}->{$stat} = d(6, 3);
	}
} 

# Return a list of available races based on the player's stats:
sub get_available_races
{
	my $self = shift;
	my @races = @OSRIC::Race::races;

	# Loop over each race:
	for my $race(@OSRIC::Race::races)
	{
		# Get the stat boosts and racial limitations of this race:
		my $stats_boosts = "OSRIC::Race::$race"->stats_boosts;
		my $racial_limitations = "OSRIC::Race::$race"->racial_limitations;

		# Loop over each stat:
		for my $stat(keys %{$self->{stats}})
		{
			# Add any class boosts:
			my $real = $self->{stats}->{$stat} + $stats_boosts->{$stat};

			# Check if this stat fits the range:
			if(($real < $racial_limitations->{$stat}->{min}) ||
			($real > $racial_limitations->{$stat}->{max}))
			{
				# If not, remove it from the list and move onto the next race:
				@races = grep { $_ ne "$race" } @races;
				last;
			}
		}
	}
	return @races;
}

# Sets the race of the player:
sub set_race
{
	my $self = shift;
	$self->{personal}->{race} = shift;

	# Increase the stats based on any racial stat boosts:
	my $stats_boosts = "OSRIC::Race::$self->{personal}->{race}"->stats_boosts;
	for my $stat(keys %{$self->{stats}})
	{
		$self->{stats}->{$stat} += $stats_boosts->{$stat};
	}
}

# Return a list of available classes based on the player's race and stats:
sub get_available_classes
{
	my $self = shift;
	my $race = $self->{personal}->{race};
	my $possible_classes = "OSRIC::Race::$race"->permitted_classes;
	my @classes = @$possible_classes;

	# Loops over the permitted classes:
	my $break = 0;
	for my $classes(@$possible_classes)
	{
		# Loop over each class (there are some dual or triple classes):
		for my $class(@$classes)
		{
			# Check if the player's stats allow for this class:
			my $min = "OSRIC::Class::$class"->minimum_scores;
			for my $stat(keys %$min)
			{
				if($self->{stats}->{$stat} < $min->{$stat})
				{
					# If not, remove it from the list of possible classes:
					@classes = grep { $_ != $classes } @classes;

					# Break from the loop:
					$break = 1;
					last;
				}
				last if($break);
			}
			$break = 0 if($break);
		}
	}
	return @classes;
}

# Takes an arrayref to an array of class names, sets it to the plauer's class:
sub set_class
{
	my $self = shift;
	$self->{personal}->{classes} = shift;
}

# Gives the player a certain amount of starting gold (class-dependant):
sub generate_gold
{
	my $self = shift;

	# Get the classes and sort by the highest starting gold (see page 28): 
	my @sorted = sort { "OSRIC::Class::$b"->max_starting_gold <=> 
						"OSRIC::Class::$a"->max_starting_gold }
						@{$self->{personal}->{classes}};

	# Generate the starting gold:
	$self->{wealth}->{coins} = "OSRIC::Class::$sorted[0]"->get_gold;
}

# Generates the player's age. If multiple classes are used, the average is
# taken (this was discussed with vypr):
sub generate_age
{
	my $self = shift;

	# Get the hash of age subs for the character's race:
	my $race = $self->{personal}->{race};
	my $age_subs = "OSRIC::Race::$race"->ages;

	# Loop over each class and add the generated age to the player:
	for my $class(@{$self->{personal}->{classes}})
	{
		my $class = lc $class;
		$self->{personal}->{age} += &{$age_subs->{$class}};
	}

	# Divide by the number of classes:
	$self->{personal}->{age} /= @{$self->{personal}->{classes}};
}

# Generates the player's HP.
sub generate_hp
{
	my $self = shift;

	# Loop over each class and generate an HP value:
	for my $class(@{$self->{personal}->{classes}})
	{
		$self->{personal}->{hp} += ("OSRIC::Class::$class"->get_hp +
			con_mod($self->{stats}->{con}, $class));
	}

	# Divide by the number of classes:
	$self->{personal}->{hp} /= @{$self->{personal}->{classes}};

	# Round up if needed:
	$self->{personal}->{hp} = ceil($self->{personal}->{hp});
}

# Gets all of the player's available alignments:
sub get_available_alignments
{
	my $self = shift;

	# Store all the returned alignment options:
	my @alignments;

	# Loop over the player's classes:
	my $classes = $self->{personal}->{classes};
	for my $class(@{$classes})
	{
		push @alignments, "OSRIC::Class::$class"->get_alignments;
	}

	# Return the intersection of all the arrays obtained:
	if(@alignments > 1)
	{
		my $lc = List::Compare->new({
			lists => \@alignments,
			unsorted => 1,
		});
		return $lc->get_intersection;
	}
	else
	{
		return @{$alignments[0]};
	}
}

# Sets the player's alignment:
sub set_alignment
{
	my $self = shift;
	$self->{personal}->{alignment} = shift;
}

# Sets the character's name to the passed string:
sub set_name
{
	my $self = shift;
	$self->{personal}->{name} = shift;
}

# Encodes the character to JSON:
sub as_json
{
	my $self = shift;
	my $json = to_json($self, {
		pretty => 1,
		convert_blessed => 1,
		allow_blessed => 1
	});
	return $json;
}

# Required by the JSON module, as specified in the docs:
sub TO_JSON
{
	my $self = shift;
	my %hash = %$self;
	return \%hash;
}

1;
