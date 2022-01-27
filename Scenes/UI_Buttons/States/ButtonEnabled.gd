extends State
class_name ButtonEnabled

func is_class(value: String): return value == "ButtonEnabled" or .is_class(value)
func get_class() -> String: return "ButtonEnabled"

#### ACCESSORS ####

#### BUILT-IN ####
func _ready() -> void:
	yield(owner, "ready")

#### VIRTUALS ####
func enter_state():
	if "animated_button" in owner:
		owner.animated_button.play("enabled")

# Called when the current state of the state machine is switched to another one
func exit_state():
	pass

# Called every frames, for real time behaviour
# Use a return "State_node_name" or return Node_reference to change the current state of the state machine at a given time
func update_state(_delta):
	if owner.is_pressed():
		return "ButtonNormal_Pressed"

#### LOGIC ####


#### INPUTS ####


#### SIGNAL RESPONSES ####
