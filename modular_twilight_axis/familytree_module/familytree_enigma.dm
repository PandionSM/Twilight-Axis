// DLC: Enigma roles integration for familytree tier system.
// Appends enigma job types to existing tier lists at runtime.

/datum/controller/subsystem/familytree/proc/load_enigma_roles()
	// Garrison (military)
	high_tier_military_types |= list(
		/datum/job/roguetown/sheriff,
		/datum/job/roguetown/royal_sergeant,
		/datum/job/roguetown/royal_guard,
		/datum/job/roguetown/town_watch,
		/datum/job/roguetown/vanguard,
		/datum/job/roguetown/overseer,
		/datum/job/roguetown/dungeoneer,
	)

	// Retinue (military)
	high_tier_military_types |= list(
		/datum/job/roguetown/knight_enigma,
	)

	// Town administration
	high_tier_town_types |= list(
		/datum/job/roguetown/mayor,
		/datum/job/roguetown/bailiff,
		/datum/job/roguetown/courtphysician,
	)
