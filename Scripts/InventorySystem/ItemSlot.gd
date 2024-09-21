extends PanelContainer
class_name ItemSlot

@export var slotdata : SlotData
@export var ItemIconNode : TextureRect
@export var ItemAmountNode : Label


func _ready():
	#ParseData(Item)
	ItemIconNode.texture = null
	ItemAmountNode.text = " "
	pass

func ParseData():
	if slotdata != null:
		ItemIconNode.texture = slotdata.itemdata.ItemIcon
		ItemAmountNode.text = str(slotdata.ItemAmt)
		if slotdata.ItemAmt <= 0:
			slotdata = null
			ItemAmountNode.text = " "
			ItemIconNode.texture = null
		#print("updating UI")
		#print(Item.ItemName)
		#print(Item.ItemAmt)
	 
	#print(ItemAmountNode.text)
	
	pass
