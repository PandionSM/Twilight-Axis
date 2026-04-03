/datum/controller/subsystem/familytree/proc/ask_monarch_noble_permission(mob/living/carbon/human/monarch)
	if(!monarch?.client)
		return
	INVOKE_ASYNC(src, PROC_REF(do_ask_monarch_noble_permission), monarch)

/datum/controller/subsystem/familytree/proc/do_ask_monarch_noble_permission(mob/living/carbon/human/monarch)
	if(!monarch?.client)
		return
	var/result = tgui_alert(monarch, "Могут ли другие дворяне (рыцари, советники и прочие с благородной кровью) быть частью вашей семьи?", "Герцогская семья", list("Да", "Нет"))

	if(!monarch || QDELETED(monarch))
		return

	if(result == "Да")
		allow_nobles_in_ruling_family = TRUE
		ftlog("NOBLE DYNASTY: [monarch.real_name] allowed nobles in ruling family")
		to_chat(monarch, span_notice("Дворяне с благородной кровью теперь могут стать частью вашей семьи."))
	else
		ftlog("NOBLE DYNASTY: [monarch.real_name] denied nobles in ruling family")

/datum/controller/subsystem/familytree/proc/try_assign_noble_to_dynasty(mob/living/carbon/human/H)
	if(!allow_nobles_in_ruling_family)
		return FALSE
	if(!ruling_family)
		return FALSE
	if(!H || H.family_datum)
		return FALSE
	if(!HAS_TRAIT(H, TRAIT_NOBLE))
		return FALSE

	var/block = get_familytree_runtime_block_reason(H)
	if(block)
		return FALSE

	if(familytree_get_role_tier(H) == ROLE_TIER_LOW)
		ftlog("NOBLE DYNASTY: [H.real_name] blocked - low status role not allowed in ruling family")
		return FALSE
	if(familytree_get_role_tier(H) == ROLE_TIER_NONE && !is_royal_hand_job(get_familytree_job(H)))
		ftlog("NOBLE DYNASTY: [H.real_name] blocked - no tier role")
		return FALSE
	ftlog("NOBLE DYNASTY: [H.real_name] eligible for ruling family (noble dynasty entry)")
	request_family_confirmation(H, CALLBACK(src, PROC_REF(do_assign_noble_to_dynasty), H), "dynasty")
	return TRUE

/datum/controller/subsystem/familytree/proc/do_assign_noble_to_dynasty(mob/living/carbon/human/H)
	if(!H || QDELETED(H) || H.family_datum)
		return
	if(!ruling_family)
		return

	var/datum/family_member/new_member = ruling_family.CreateFamilyMember(H)
	if(!new_member)
		return

	var/datum/family_member/monarch = GetCurrentMonarch()
	if(monarch)
		if(CanBeSiblings(H.age, monarch.person?.age))
			if(monarch.parents.len)
				new_member.AddParent(monarch.parents[1])
				if(monarch.parents.len > 1)
					new_member.AddParent(monarch.parents[2])
			new_member.generation = monarch.generation
		else
			new_member.generation = monarch.generation

	ftlog("NOBLE DYNASTY: [H.real_name] added to ruling family")
	to_chat(H, span_love("Вы были приняты в герцогскую семью!"))
	stop_tracking_human(H, "assigned to ruling family as noble")
