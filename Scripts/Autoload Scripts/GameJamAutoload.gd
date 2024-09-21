extends Node
signal PrimaryInteraction(item)
signal SecondaryInteraction1(item)
signal SecondaryInteraction2
signal SecondaryInteraction3
signal AddItemSignal(pickup : ItemData,ItemRef: Node3D)
signal UpdatePlayerHand (playerobj : Player, data : SlotData)
signal UpdateHotbar()
signal TakeDamage(entity : GameEntity, damage:float)
signal IncreaseMoneyAmt(amount:int)
signal AskPlayerPos()
signal SendPlayerPos(playerpos : Vector3)
signal UpdateLightMeter(lightmetervalue : float)
signal UpdateSoundMeter(soundmeterval : float)
signal PlayItemCollectSound()
signal DisplayInspectText(text : String)


var money: int
var keycardcollected = false
var secondkeycardcollected = false
