extends Control

@export var InvData : InventoryData
@export var Hotbar : HBoxContainer
@export var SelectedItemLabel : Label
@export var PlayerObj : Player
var hotbarindex :int = 0
@export var SelectionIndicator : Panel

func _ready():
	
	ReadandWriteItemData()
	GameJamAutoload.AddItemSignal.connect(additem)
	GameJamAutoload.UpdateHotbar.connect(ReadandWriteItemData)
	#hotbarselect(0)
	#GameJamAutoload.UpdatePlayerHand.emit(PlayerObj,InvData.ItemArray[0])



func ReadandWriteItemData(): ##this updates the hotbar. This can be used when initialising the player's inventory on startup or even during gameplay post startup when picking up or dropping an object
	
	if InvData != null and Hotbar != null: ## checks to see if the inventory data is null or if the hotbar export variable is null
		#print(InvData.ItemArray.size()) 
		for itemindex in InvData.ItemArray.size(): ## gets the range of values (in terms of how many unique item entries are stored) and loops through them
			
		
			var itemslot = Hotbar.get_child(itemindex) ##gets the hotbar node that has the same index as the index in the inventory. This should allow for the inventorydata and hotbar to have the same organisation
			
			if itemslot != null and itemslot.is_in_group("ItemSlot"):
				
				if InvData.ItemArray[itemindex] != null: ## checks to see if slotdata exists at the index 
					if InvData.ItemArray[itemindex].itemdata != null: ##checks to see if that slotdata's itemdata also exists
						#print(InvData.ItemArray[itemindex].itemdata.ItemName)
						itemslot.slotdata = InvData.ItemArray[itemindex] ##sets the hotbar's slotdata to the inventory's slotdata at that specific itemindex
						itemslot.ParseData() ## calls a function that makes the hotbar update it's item amount label and its' item icon
					if InvData.ItemArray[itemindex].ItemAmt <= 0:
						InvData.ItemArray[itemindex] = null
						SelectedItemLabel.text = " "
					#print(itemslot)
				
				else:
					print("item data is null")
			else:
				print("No item data detected !")
				pass
				
				#itemslot.ParseData()
			
			
			
			
		#print(InvData.ItemArray[2].ItemName)
	else:
		
		pass



func additem(pickup : SlotData,ItemRef: Node3D):
	if pickup == null:
		
		
		pass
	##loop through inv data.
	## if there is an empty slot, add the item to that
	##otherwise check if the slot's item data is the same as the pickup's item data
	## if so, check to see if adding it to the item will go over the item's max count
	## if it does, don't add the item
	## if it doesn't, then add the item (but make to queue_free the item afterwards)
	## if it does, but adding some of the items allows it to reach the limit without going over,
	## get the difference betwen the item datas and add the result from the difference to the item slot and subtract the difference result from the pickup slot 
	
	for slotcount in InvData.ItemArray.size():
		
		var slotdata = InvData.ItemArray[slotcount] ##allows easy access to the inventory's slot data at the point in the loop
		var itemslot = Hotbar.get_child(slotcount) ## easy access to hotbar slotdata
		if slotdata != null and slotdata.itemdata != null: ## checks to see if the slotdata isn't empty, as if this check isn't here, the program errors out
			
			if slotdata.itemdata == pickup.itemdata:
				
				#print("There is already a similar item in the inventory")
				##get difference between slotdata amounts
				if pickup.itemdata.IsStackable:
					if slotdata.ItemAmt != slotdata.itemdata.MaxCapacity:
						if (slotdata.itemdata.MaxCapacity - (pickup.ItemAmt + slotdata.ItemAmt) ) > 0: ##checks if adding the pickup to the itemslot will not go over the item's max capacity
							print("can add full amount to item slot with same item :D")
							slotdata.ItemAmt += pickup.ItemAmt ##increments the item amount by the pickup's full itemamt
							ItemRef.queue_free() ##deletes the item since there is no reason for the item to be in the world still
							ReadandWriteItemData()
							break
						if (slotdata.itemdata.MaxCapacity - (pickup.ItemAmt + slotdata.ItemAmt)) <= 0:
							#print("Cannot add item D:")
							var differencebetweenitemamts = pickup.ItemAmt - slotdata.itemdata.MaxCapacity ##the calculation done here results in the amount of the item that can be added to the item slot if the itemslot is already occupied
							slotdata.ItemAmt += differencebetweenitemamts +1 -1 ##Doing this prevents a bug that results in the player picking up 1 less item 
							pickup.ItemAmt -= differencebetweenitemamts  
							
							if pickup.ItemAmt == 0: ##this deletes the pickup's in world object when it's itemamt is 0
								ItemRef.queue_free()
							
							ReadandWriteItemData()
							
							
							
							
							pass
						pass
					else:
						print("Itemslot is full !")
						pass
				pass
				if !pickup.itemdata.IsStackable:
					pass
				
			pass
		
		#if slotdata
			
			
		if slotdata == null and pickup.itemdata != null:
			print("empty slot detected")
			InvData.ItemArray[slotcount] = pickup ##updates the free item slot in the inventory to have the slotdata from the pickup
			ReadandWriteItemData()
			#ItemRef.queue_free() ##deletes the item's in game object. This assumes that all of the pickup's slotdata was transferred over, leaving it empty and keeping the object around would allow for the item to be duped
			break
			pass
	
	pass



func hotbarinput():
	##The code below checks to see what button that is pressed (usually this will be the numberkeys. It then calls the hotbarselect function and passes a value to it based on the number key input
	## eg. itemslot1 when pressed will pass 1 to the hotbarselect and itemslot4 will pass 4 to the hotbarselect function
	if Input.is_action_just_pressed("ItemSlot1"):
		hotbarselect(0)
		#print("Slot1")
	if Input.is_action_just_pressed("ItemSlot2"):
		hotbarselect(1)
		#print("Slot2")
	if Input.is_action_just_pressed("ItemSlot3"):
		hotbarselect(2)
		#print("Slot3")
	if Input.is_action_just_pressed("ItemSlot4"):
		hotbarselect(3)
		#print("Slot4")
	if Input.is_action_just_pressed("ItemSlot5"):
		hotbarselect(4)
		#print("Slot5")
	if Input.is_action_just_pressed("ItemSlot6"):
		hotbarselect(5)
		#print("Slot6")
	if Input.is_action_just_pressed("ItemSlot7"):
		hotbarselect(6)
		#print("Slot7")
	if Input.is_action_just_pressed("ItemSlot8"):
		hotbarselect(7)
		#print("Slot8")
	if Input.is_action_just_pressed("InventoryCycleForward"):
		hotbarindex +=1
		hotbarselect(hotbarindex)
		pass
	if Input.is_action_just_pressed("InventoryCycleBackward"):
		hotbarindex -=1
		hotbarselect(hotbarindex)
		pass
	##TODO add 2 buttons to cycle through the hotbar for controller users

func hotbarselect(index : int):
	print(index + 1)
	if SelectionIndicator.visible == false:
		SelectionIndicator.visible = true
	SelectionIndicator.global_position = Hotbar.get_child(index).global_position
	SelectionIndicator.global_position.y += 2.5
	SelectionIndicator.global_position.x += 2.5
	if InvData.ItemArray[index] != null:
		if InvData.ItemArray[index].itemdata != null:
			print(InvData.ItemArray[index].itemdata.ItemName)
		SelectedItemLabel.text = InvData.ItemArray[index].itemdata.ItemName
		GameJamAutoload.UpdatePlayerHand.emit(PlayerObj,InvData.ItemArray[index])
	else:
		GameJamAutoload.UpdatePlayerHand.emit(PlayerObj,null)
		print("Slot data empty")
		SelectedItemLabel.text = " "
	
	
	if hotbarindex != index:
		hotbarindex = index
	
	pass

func _process(delta):
	hotbarindex = wrap(hotbarindex,0,7)
	hotbarinput()
