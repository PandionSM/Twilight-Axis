/datum/action/cooldown/spell/projectile/cast(atom/cast_on, mob/living/user)
	. = ..()
	if(!isturf(owner.loc))
		return FALSE

	if(!iscarbon(user)) //TA changes
		return FALSE

	var/atom/target = cast_on
	// For non-click spells, resolve target in the caster's facing direction
	if(!click_to_activate)
		target = get_ranged_target_turf(owner, owner.dir, cast_range)

	fire_projectile(target)
	return TRUE