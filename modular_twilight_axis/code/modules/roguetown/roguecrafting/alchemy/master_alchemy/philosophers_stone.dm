/obj/item/philosophers_stone
	name = "Great Philosopher's Stone"
	desc = "A pulsating, blood-red gem. It feels warm, almost like it has a pulse of its own."
	icon = 'modular_twilight_axis/code/modules/roguetown/roguecrafting/alchemy/master_alchemy/alch.dmi'
	icon_state = "soulstone"
	
	var/charges = 0
	var/max_charges = 200
	var/mob/living/carbon/human/bound_soul = null 

/obj/item/philosophers_stone/Destroy()
	if(bound_soul && !QDELETED(bound_soul))
		REMOVE_TRAIT(bound_soul, TRAIT_PHILOSOPHER_BOUND, src)
	return ..()

/obj/item/philosophers_stone/attack_self(mob/living/carbon/human/user)
	if(!istype(user)) return
	
	if(bound_soul)
		to_chat(user, span_warning(bound_soul == user ? "Ваши души уже переплетены." : "Этот камень уже поглотил чужую жизнь."))
		return

	if(HAS_TRAIT(user, TRAIT_PHILOSOPHER_BOUND))
		to_chat(user, span_warning("Ваша душа уже переплетена с другим артефактом!"))
		return

	user.visible_message(span_danger("[user] прижимает камень к груди!"), \
						span_notice("Вы чувствуете, как вся ваша жизненная суть втягивается в бездонную пустоту камня..."))
	
	if(do_after(user, 50, target = src))
		if(HAS_TRAIT(user, TRAIT_PHILOSOPHER_BOUND) || bound_soul) return

		bound_soul = user
		charges = max_charges
		
		ADD_TRAIT(user, TRAIT_DNR, src)
		ADD_TRAIT(user, TRAIT_PHILOSOPHER_BOUND, src)

		playsound(src, 'sound/magic/lightning.ogg', 100, TRUE)
		to_chat(user, span_userdanger("КОНТРАКТ ПОДПИСАН. Камень наполнился вашей жизнью. Каждое использование теперь приближает ваш конец..."))
		update_icon()

/obj/item/philosophers_stone/proc/consume_soul()
	if(!bound_soul || QDELETED(bound_soul)) return
	
	var/mob/living/carbon/human/victim = bound_soul
	victim.visible_message(span_userdanger("Тело [victim] мгновенно бледнеет!"))
	
	to_chat(victim, span_userdanger("ВЫ ИСЧЕРПАЛИ СЕБЯ. КАМЕНЬ ПОГЛОТИЛ ПОСЛЕДНЮЮ КАПЛЮ ВАШЕЙ СУТИ!"))

	playsound(src, 'sound/magic/lightning.ogg', 100, TRUE)
	
	victim.death()

	qdel(src)
