/datum/preferences
	var/polygamy_mode = POLYGAMY_DISABLED

/mob/living/carbon/human
	var/polygamy_mode = POLYGAMY_DISABLED

/proc/familytree_can_have_multiple_spouses(mob/living/carbon/human/H)
	if(!H)
		return FALSE

	if(H.polygamy_mode & POLYGAMY_ALLOW_MULTIPLE)
		return TRUE

	if(familytree_lore_allows_polygyny(H))
		return TRUE
	if(familytree_lore_allows_polyandry(H))
		return TRUE

	return FALSE

/proc/familytree_can_be_additional_spouse(mob/living/carbon/human/H)
	if(!H)
		return FALSE

	if(H.polygamy_mode & POLYGAMY_ALLOW_BE_SECOND)
		return TRUE

	return FALSE

/proc/familytree_lore_allows_polygyny(mob/living/carbon/human/H)
	if(!H)
		return FALSE
	var/datum/patron/P = H.patron
	if(istype(P, /datum/patron/inhumen/baotha))
		return TRUE
	return FALSE

/proc/familytree_lore_allows_polyandry(mob/living/carbon/human/H)
	if(!H)
		return FALSE
	if(isdarkelf(H))
		return TRUE
	return FALSE

/proc/familytree_polygamy_compatible(mob/living/carbon/human/seeker, mob/living/carbon/human/target)
	if(!seeker || !target)
		return FALSE

	var/seeker_has_spouse = seeker.spouse_mob || (seeker.family_member_datum && seeker.family_member_datum.spouses.len)
	var/target_has_spouse = target.spouse_mob || (target.family_member_datum && target.family_member_datum.spouses.len)

	if(!seeker_has_spouse && !target_has_spouse)
		return TRUE

	if(seeker_has_spouse && target_has_spouse)
		return FALSE

	if(seeker_has_spouse)
		if(!familytree_can_have_multiple_spouses(seeker))
			return FALSE
		if(!familytree_can_be_additional_spouse(target))
			return FALSE
		return TRUE

	if(target_has_spouse)
		if(!familytree_can_have_multiple_spouses(target))
			return FALSE
		if(!familytree_can_be_additional_spouse(seeker))
			return FALSE
		return TRUE

	return FALSE
