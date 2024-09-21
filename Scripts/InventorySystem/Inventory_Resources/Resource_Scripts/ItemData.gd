extends Resource
class_name ItemData

@export var ItemName : String
@export var ItemIcon : Texture
@export var ItemScene : PackedScene
@export var IsStackable : bool
@export var MaxCapacity : int = 1
@export var ItemMesh : Mesh
@export var DamageAmt : float
@export var ProjectileMesh : Mesh


enum type{Healing,RangedWeapon,Melee,Projectile,KeyCard}
enum Mode {Type_SHOCK,Type_NOISE}

@export var ProjectileMode : Mode
@export var ItemType : type


