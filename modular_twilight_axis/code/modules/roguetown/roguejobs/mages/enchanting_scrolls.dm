/obj/item/enchantmentscroll
	name = "scroll of enchanting"
	desc = "A scroll imbued with an arcane enchantment. Can be used on certain items to imbue them."
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "enchantment"
	component
	possible_item_intents = list(/datum/intent/use)
	grid_width = 64
	grid_height = 32

/obj/item/enchantmentscroll/attack_obj(obj/item/O, mob/living/user)
	if(O.unenchantable)
		to_chat(user, span_warning("You cannot enchant this item."))
		return FALSE
	var/datum/component/magic_item/M = O.GetComponent(/datum/component/magic_item, component)
	var/datum/component/cursed_item/C = O.GetComponent(/datum/component/cursed_item)
	if(M)
		if(length(M.magical_effects) >= M.enchanting_capacity)
			to_chat(user, span_warning("This item is already enchanted to its full capacity."))
			return FALSE
		if(C)
			to_chat(user, span_warning("This item is already filled with strange magic and cannot be enchanted."))
			return FALSE
	return TRUE
