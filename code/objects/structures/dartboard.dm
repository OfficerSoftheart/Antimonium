/obj/item/dartboard
	name = "dartboard"
	icon = 'icons/objects/structures/dartboard.dmi'
	density = 0
	layer = TURF_LAYER+0.2
	flags = FLAG_SIMULATED | FLAG_ANCHORED
	contact_size = 5
	weight = 3

/obj/item/dartboard/New()
	..()
	align_with_wall(src)
	update_icon()

/obj/item/dartboard/after_dropped()
	align_with_wall(src)
	update_icon()

/obj/item/dartboard/update_icon()
	..()
	if(dir)
		icon_state = "world"
	else
		icon_state = "world_flat"

/obj/item/dartboard/thrown_hit_by(var/atom/movable/projectile)

	var/obj/item/dart = projectile
	if(!istype(dart) || !dart.sharpness)
		return FALSE

	var/result = rand(10) + dart.contact_size
	switch(result)
		if(1)
			result = "wooden frame..."
		if(2 to 5)
			result = "outer ring."
		if(6 to 9)
			result = "inner ring!"
		else
			if(result >= 10)
				result = "bullseye!"
			else
				notify_nearby("\The [projectile] misses \the [src] completely!")
				return FALSE

	projectile.force_move(get_turf(src))
	play_local_sound(src, 'sounds/effects/thunk1.ogg', 100)
	notify_nearby("\The [projectile] strikes \the [src] in the [result]")
	return TRUE
