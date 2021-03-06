/mob
	var/obj/ui/radial_menu/radial_menu

/mob/Destroy()
	QDel(radial_menu, "mob destroyed")
	. = ..()

/atom
	var/list/radial_menus = list() //todo event framework

/atom/proc/UpdateRadialMenus(var/delay)
	set waitfor = 0
	sleep(delay)
	if(radial_menus.len)
		for(var/thing in radial_menus)
			var/obj/ui/radial_menu/menu = thing
			menu.UpdateButtons()

/atom/Destroy()
	. = ..()
	UpdateRadialMenus()

/atom/movable/Move()
	. = ..()
	UpdateRadialMenus(1)

/atom/Entered()
	. = ..()
	UpdateRadialMenus(1)

/atom/Exited()
	. = ..()
	UpdateRadialMenus(1)

/obj/ui/radial_menu
	name = "Radial Menu"
	icon = 'icons/images/ui_radial_menu.dmi'
	screen_loc = "CENTER,CENTER"

	var/atom/source_atom
	var/screen_loc_x
	var/screen_loc_y
	var/list/buttons = list()
	var/obj/ui/radial_button/close/close_button
	var/obj/ui/source_atom_display
	var/button_type = /obj/ui/radial_button/show_atom
	var/menu_type = RADIAL_MENU_DEFAULT

/obj/ui/radial_menu/proc/ReceiveInput(var/thing_input)
	return

/obj/ui/radial_menu/Destroy()
	QDel(source_atom_display, "radial menu destroyed")
	source_atom_display = null
	for(var/thing in buttons)
		if(!Deleted(thing))
			QDel(thing, "radial menu destroyed")
	buttons.Cut()
	if(owner && owner.radial_menu == src)
		owner.radial_menu = null
	if(source_atom)
		source_atom.radial_menus -= src
		source_atom = null
	. = ..()

/obj/ui/radial_menu/New(var/mob/_owner, var/list/_source_atom)

	if(!_owner || !_owner.client || !_source_atom)
		QDel(src, "no owner client")
		return

	source_atom = _source_atom
	source_atom.radial_menus += src
	source_atom_display = new(_owner)
	source_atom_display.icon = 'icons/images/ui.dmi'
	source_atom_display.icon_state = "square_base"
	UpdateSourceAtomAppearance()

	close_button = new(_owner, src)

	if(_owner.radial_menu)
		QDel(_owner.radial_menu, "radial menu replacement")
	_owner.radial_menu = src

	..(_owner)

	var/list/clickdata = splittext(owner.client.last_click["screen-loc"], ",")
	var/list/data_x = splittext(clickdata[1], ":")
	var/list/data_y = splittext(clickdata[2], ":")

	screen_loc_x = text2num(data_x[1])
	screen_loc_y = text2num(data_y[1])
	screen_loc = "[screen_loc_x-2],[screen_loc_y-2]"
	source_atom_display.screen_loc = "[screen_loc_x],[screen_loc_y]"

	UpdateButtons()

/obj/ui/radial_menu/proc/UpdateSourceAtomAppearance()

	var/image/I = new()
	source_atom_display.overlays.Cut()
	source_atom_display.name = source_atom.name
	if(istype(source_atom, /obj/item))
		var/obj/item/prop = source_atom
		I.appearance = prop.GetInvIcon()
	else
		I.appearance = source_atom
	I.plane = plane
	I.layer = FLOAT_LAYER
	source_atom_display.overlays += I

	var/atom/movable/object = source_atom
	if(!istype(object) || isnull(object.draw_shadow_underlay))
		source_atom_display.draw_shadow_underlay = TRUE
		source_atom_display.UpdateShadowUnderlay()

/obj/ui/radial_menu/proc/GetAdditionalMenuData()
	return

/obj/ui/radial_menu/proc/UpdateButtons()

	if(!IsAdjacentTo(owner, source_atom))
		QDel(src, "adjacency fail")
		return

	var/list/displaying = source_atom.GetRadialMenuContents(owner, menu_type, GetAdditionalMenuData())

	buttons -= close_button

	for(var/thing in buttons)
		var/obj/ui/radial_button/button = thing
		if(locate("\ref[button.GetAtom()]") in displaying)
			displaying -= button.GetAtom()
			button.UpdateAppearance()
			continue
		buttons -= button
		QDel(button, "button update")

	for(var/thing in displaying)
		buttons += new button_type(owner, src, thing)

	buttons.Insert(1, close_button)

	var/use_angle = 0
	var/angle_step = round(360/buttons.len)
	for(var/thing in buttons)
		var/obj/ui/radial_button/button = thing
		button.screen_loc = "[screen_loc_x+1]:[-32+round(58 * cos(use_angle-90))], [screen_loc_y+1]:[-32+round(58 * sin(use_angle-90))]"
		use_angle += angle_step
		if(use_angle > 360)
			use_angle -= 360

	UpdateSourceAtomAppearance()

	owner.RefreshUI()
