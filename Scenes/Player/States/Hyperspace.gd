extends State
class_name CharacterHyperspaceState

func is_class(value: String): return value == "CharacterHyperspaceState" or .is_class(value)
func get_class() -> String: return "CharacterHyperspaceState"

#### ACCESSORS ####

#### BUILT-IN ####

func _ready() -> void:
	yield(owner, "ready")

#### VIRTUALS ####

# Called when the current state of the state machine is set to this node
func enter_state():
	if "character_animated_sprite_node0" && "character_animated_sprite_node1" in owner:
		owner.character_animated_sprite_node0.play("Hyperspace")
		owner.character_animated_sprite_node1.play("Hyperspace")

# Called when the current state of the state machine is switched to another one
func exit_state():
	pass

# Called every frames, for real time behaviour
# Use a return "State_node_name" or return Node_reference to change the current state of the state machine at a given time
func update_state(_delta):
	if !owner.in_hyperspace:
		return "Move"

#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####
