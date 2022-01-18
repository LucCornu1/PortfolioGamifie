extends State
class_name CharacterIdleState

func is_class(value: String): return value == "CharacterIdleState" or .is_class(value)
func get_class() -> String: return "CharacterIdleState"

#### ACCESSORS ####

#### BUILT-IN ####

func _ready() -> void:
	yield(owner, "ready")

#### VIRTUALS ####

# Called when the current state of the state machine is set to this node
func enter_state():
	if "character_animated_sprite_node0" && "character_animated_sprite_node1" in owner:
		owner.character_animated_sprite_node0.play("Idle")
		owner.character_animated_sprite_node1.play("Idle")

# Called when the current state of the state machine is switched to another one
func exit_state():
	pass

# Called every frames, for real time behaviour
# Use a return "State_node_name" or return Node_reference to change the current state of the state machine at a given time
func update_state(_delta):
	# Change state to move if the player is moving horizontaly
	var horiz_movement = owner.dirRight - owner.dirLeft
	if horiz_movement != 0:
		return "Move"

#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####
