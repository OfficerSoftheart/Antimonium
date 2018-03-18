/mob/animal/deer
	name = "deer"
	icon = 'icons/mobs/deer.dmi'

/mob/animal/deer/New()
	gender = pick(MALE, FEMALE)
	if(gender == MALE)
		name = "stag"
	else if(gender == FEMALE)
		name = "doe"
	..()

/mob/animal/deer/CreateLimbs()
	limbs_by_key[BP_CHEST] =      new /obj/item/limb(src,        "upper body",      'icons/mobs/limbs/deer/chest.dmi',     BP_CHEST ,     _root = TRUE, _vital = TRUE, _size = 10)
	limbs_by_key[BP_GROIN] =      new /obj/item/limb(src,        "lower body",      'icons/mobs/limbs/deer/groin.dmi',     BP_GROIN,      BP_CHEST,     _vital = TRUE, _size = 10)
	limbs_by_key[BP_LEFT_ARM] =   new /obj/item/limb(src,        "left front leg",  'icons/mobs/limbs/deer/left_arm.dmi',  BP_LEFT_ARM,   BP_CHEST,     _size = 6)
	limbs_by_key[BP_RIGHT_ARM] =  new /obj/item/limb(src,        "right front leg", 'icons/mobs/limbs/deer/right_arm.dmi', BP_RIGHT_ARM,  BP_CHEST,     _size = 6)
	if(gender == MALE)
		limbs_by_key[BP_HEAD] =       new /obj/item/limb(src,        "head",            'icons/mobs/limbs/deer/head_m.dmi',      BP_HEAD,       BP_CHEST,     _size = 6, _grasp_name = "jaws", _grasp_plural = TRUE)
	else
		limbs_by_key[BP_HEAD] =       new /obj/item/limb(src,        "head",            'icons/mobs/limbs/deer/head_f.dmi',      BP_HEAD,       BP_CHEST,     _size = 6, _grasp_name = "jaws")
	limbs_by_key[BP_LEFT_HAND] =  new /obj/item/limb(src,        "left front paw",  'icons/mobs/limbs/_default.dmi',      BP_LEFT_HAND,  BP_LEFT_ARM,  _size = 3)
	limbs_by_key[BP_RIGHT_HAND] = new /obj/item/limb(src,        "right front paw", 'icons/mobs/limbs/_default.dmi',      BP_RIGHT_HAND, BP_RIGHT_ARM, _size = 3)
	limbs_by_key[BP_LEFT_LEG] =   new /obj/item/limb/stance(src, "left rear leg",   'icons/mobs/limbs/deer/left_leg.dmi',  BP_LEFT_LEG,   BP_GROIN,     _size = 6)
	limbs_by_key[BP_RIGHT_LEG] =  new /obj/item/limb/stance(src, "right rear leg",  'icons/mobs/limbs/deer/right_leg.dmi', BP_RIGHT_LEG,  BP_GROIN,     _size = 6)
	limbs_by_key[BP_LEFT_FOOT] =  new /obj/item/limb/stance(src, "left rear paw",   'icons/mobs/limbs/_default.dmi',      BP_LEFT_FOOT,  BP_LEFT_LEG,  _size = 3)
	limbs_by_key[BP_RIGHT_FOOT] = new /obj/item/limb/stance(src, "right rear paw",  'icons/mobs/limbs/_default.dmi',      BP_RIGHT_FOOT, BP_RIGHT_LEG, _size = 3)
