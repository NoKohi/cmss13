/obj/item/storage/wallet
	name = "wallet"
	desc = "It can hold a few small and personal things."
	storage_slots = 10
	icon_state = "wallet"
	w_class = SIZE_TINY
	can_hold = list(
		/obj/item/spacecash,
		/obj/item/card,
		/obj/item/clothing/mask/cigarette,
		/obj/item/device/flashlight/pen,
		/obj/item/seeds,
		/obj/item/stack/medical,
		/obj/item/toy/crayon,
		/obj/item/coin,
		/obj/item/toy/dice,
		/obj/item/disk,
		/obj/item/implanter,
		/obj/item/tool/lighter,
		/obj/item/tool/match,
		/obj/item/paper,
		/obj/item/tool/pen,
		/obj/item/photo,
		/obj/item/reagent_container/dropper,
		/obj/item/tool/screwdriver,
		/obj/item/tool/stamp
	)
	flags_equip_slot = SLOT_ID

	var/obj/item/card/id/front_id = null


/obj/item/storage/wallet/_item_removal(obj/item/W as obj, atom/new_location)
	if(W == front_id)
		front_id = null
		name = initial(name)
	..()

/obj/item/storage/wallet/_item_insertion(obj/item/W as obj, prevent_warning = 0)
	if(!front_id && istype(W, /obj/item/card/id))
		front_id = W
		name = "[name] ([front_id])"
	..()

/obj/item/storage/wallet/update_icon()

	if(front_id)
		switch(front_id.icon_state)
			if("id")
				icon_state = "walletid"
				return
			if("silver")
				icon_state = "walletid_silver"
				return
			if("gold")
				icon_state = "walletid_gold"
				return
			if("centcom")
				icon_state = "walletid_centcom"
				return
	icon_state = "wallet"


/obj/item/storage/wallet/GetID()
	return front_id

/obj/item/storage/wallet/GetAccess()
	var/obj/item/I = GetID()
	if(I)
		return I.GetAccess()
	else
		return ..()

/obj/item/storage/wallet/random/fill_preset_inventory()
	var/item1_type = pick( /obj/item/spacecash/c10,/obj/item/spacecash/c100,/obj/item/spacecash/c1000,/obj/item/spacecash/c20,/obj/item/spacecash/c200,/obj/item/spacecash/c50, /obj/item/spacecash/c500)
	var/item2_type
	if(prob(50))
		item2_type = pick( /obj/item/spacecash/c10,/obj/item/spacecash/c100,/obj/item/spacecash/c1000,/obj/item/spacecash/c20,/obj/item/spacecash/c200,/obj/item/spacecash/c50, /obj/item/spacecash/c500)
	var/item3_type = pick( /obj/item/coin/silver, /obj/item/coin/silver, /obj/item/coin/gold, /obj/item/coin/iron, /obj/item/coin/iron, /obj/item/coin/iron )

	if(item1_type)
		new item1_type(src)
	if(item2_type)
		new item2_type(src)
	if(item3_type)
		new item3_type(src)
