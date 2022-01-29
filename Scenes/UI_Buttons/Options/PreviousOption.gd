extends Option
class_name PreviousOption

func is_class(value: String): return value == "PreviousOption" or .is_class(value)
func get_class() -> String: return "PreviousOption"

#### ACCESSORS ####

#### BUILT-IN ####
func _ready() -> void:
	var __ = EVENTS.connect("hide_useless_buttons", self, "_on_hide_self")

#### VIRTUALS ####

#### LOGIC ####

#### INPUTS ####

#### SIGNAL RESPONSES ####
func _on_button_pressed() -> void:
	._on_button_pressed()
	EVENTS.emit_signal("previous_object")

func _on_hide_self() -> void:
	set_visible(false)
