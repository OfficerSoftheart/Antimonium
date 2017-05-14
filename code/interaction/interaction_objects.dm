/obj/left_clicked_on(var/mob/clicker)
	handle_clicked_on(clicker, SLOT_LEFT_HAND)

/obj/right_clicked_on(var/mob/clicker)
	handle_clicked_on(clicker, SLOT_RIGHT_HAND)

/obj/proc/handle_clicked_on(var/mob/clicker, var/slot)
	if(is_adjacent_to(get_turf(src), get_turf(clicker)))
		if(clicker.get_equipped(slot))
			attacked_by(clicker, clicker.get_equipped(slot))
		else
			manipulated_by(clicker, slot)

/obj/proc/attacked_by(var/mob/user, var/obj/item/thing)
	return

/obj/proc/manipulated_by(var/mob/user, var/slot)
	return

/obj/item/handle_clicked_on(var/mob/clicker, var/slot)
	if(is_adjacent_to(get_turf(src), get_turf(clicker)))
		if(!clicker.get_equipped(slot))
			notify_nearby("\The [clicker] picks up \the [src].")
			play_local_sound(src, collect_sound, 50)
			clicker.collect_item(src, slot)
			return
	. = ..()

/obj/item/proc/attacking(var/mob/user, var/mob/target)
	if(!(interaction_flags & FLAG_SIMULATED))
		return
	user.do_attack_animation(target, src)
	if(user.intent.selecting == INTENT_HELP)
		play_local_sound(src, 'sounds/effects/punch1.wav', 20)
		user.notify_nearby("\The [user] prods \the [target] with \the [src].")
	else
		user.notify_nearby("\The [user] [pick(attack_verbs)] \the [target] with \the [src]!")
		play_local_sound(src, 'sounds/effects/whoosh1.wav', 50)
		spawn(3)
			play_local_sound(src, hit_sound, 50)
		if(weight || sharpness)
			target.resolve_physical_attack(user, weight, sharpness, contact_size, src)

/obj/item/proc/attacking_self(var/mob/user)
	return

/obj/item/attacked_by(var/mob/user, var/obj/item/thing)
	return

/obj/item/proc/before_dropped()
	return

/obj/item/proc/after_dropped()
	return

/obj/item/proc/before_picked_up()
	return

/obj/item/proc/after_picked_up()
	pixel_x = initial(pixel_x)
	pixel_y = initial(pixel_y)
	transform = null
