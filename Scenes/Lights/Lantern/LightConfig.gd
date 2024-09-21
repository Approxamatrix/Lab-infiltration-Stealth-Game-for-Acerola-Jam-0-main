@tool

extends Node3D
class_name LightConfig


@export var update : bool


@export_category("OmniLight")

@export var omni : OmniLight3D
@export var ColourOmni : Color
@export var EnergyOmni : float
@export var IndirectEnergyOmni : float
@export var VolFogEnergyOmni : float
@export var RangeOmni : float
@export var AttenuationOmni : float

@export_category("SpotLight")


@export var spot : SpotLight3D
@export var ColourSpot : Color
@export var EnergySpot : float
@export var IndirectEnergySpot : float
@export var VolFogEnergySpot : float
@export var RangeSpot : float
@export var AttenuationSpot : float


#Have it control the color, energy, indirect energy, volumetric fog energy as well as the omnilight's range and attenuation.
# Called when the node enters the scene tree for the first time.
func _ready():
	omnilight()
	spotlight()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if update == true:
		omnilight()
		spotlight()
		update = false
		print("updated !")
	
	else:
		
		pass
	
	
	pass
	
func omnilight():
	
	if omni != null:
		omni.light_color = ColourOmni
		omni.light_energy = EnergyOmni
		omni.light_indirect_energy = IndirectEnergyOmni
		omni.light_volumetric_fog_energy = VolFogEnergyOmni
		omni.omni_range = RangeOmni
		omni.omni_attenuation = AttenuationOmni
			
	pass
	
func spotlight():
	if spot != null:
		spot.light_color = ColourSpot
		spot.light_energy = EnergySpot
		spot.light_indirect_energy = IndirectEnergySpot
		spot.light_volumetric_fog_energy = VolFogEnergySpot
		spot.spot_range = RangeSpot
		spot.spot_attenuation = AttenuationSpot
		
		pass
	pass
