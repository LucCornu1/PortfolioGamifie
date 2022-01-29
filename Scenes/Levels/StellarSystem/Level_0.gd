extends LevelBase
class_name Level_0

func is_class(value: String): return value == "Level_0" or .is_class(value)
func get_class() -> String: return "Level_0"

#### ACCESSORS ####

#### BUILT-IN ####
func _ready() -> void:
	EVENTS.emit_signal("hide_useless_buttons")

#### VIRTUALS ####

#### LOGIC ####

#### INPUTS ####

#### SIGNAL RESPONSES ####
