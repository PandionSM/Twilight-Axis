#define ESTATE_NONE 0
#define ESTATE_NOBLE 1
#define ESTATE_COMMONER 2

/proc/familytree_get_estate(mob/living/carbon/human/H)
	if(!H)
		return ESTATE_NONE

	var/datum/job/job = SSfamilytree.get_familytree_job(H)
	if(!job)
		return ESTATE_NONE

	if(SSfamilytree.is_noble_job(job))
		return ESTATE_NOBLE

	return ESTATE_COMMONER

/datum/controller/subsystem/familytree/proc/is_noble_job(datum/job/job)
	if(!job)
		return FALSE
	if(istype(job, /datum/job/roguetown/lord))
		return TRUE
	if(istype(job, /datum/job/roguetown/lady))
		return TRUE
	if(istype(job, /datum/job/roguetown/prince))
		return TRUE
	if(istype(job, /datum/job/roguetown/hand))
		return TRUE
	if(istype(job, /datum/job/roguetown/suitor))
		return TRUE
	if(istype(job, /datum/job/roguetown/seneschal))
		return TRUE
	if(istype(job, /datum/job/roguetown/councillor))
		return TRUE
	if(istype(job, /datum/job/roguetown/magician))
		return TRUE
	if(istype(job, /datum/job/roguetown/steward))
		return TRUE
	if(istype(job, /datum/job/roguetown/archivist))
		return TRUE
	if(istype(job, /datum/job/roguetown/knight))
		return TRUE
	if(istype(job, /datum/job/roguetown/marshal))
		return TRUE
	return FALSE

/proc/familytree_estates_compatible(mob/living/carbon/human/A, mob/living/carbon/human/B)
	if(SSfamilytree.xylix_roulette_active)
		return TRUE

	var/estate_a = familytree_get_estate(A)
	var/estate_b = familytree_get_estate(B)

	if(estate_a == ESTATE_NONE || estate_b == ESTATE_NONE)
		return TRUE

	return estate_a == estate_b
