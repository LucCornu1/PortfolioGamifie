extends Option
class_name MapOption

func is_class(value: String): return value == "MapOption" or .is_class(value)
func get_class() -> String: return "MapOption"

#### ACCESSORS ####

#### BUILT-IN ####

#### VIRTUALS ####

#### LOGIC ####

#### INPUTS ####

#### SIGNAL RESPONSES ####
func _on_button_pressed() -> void:
	._on_button_pressed()
	EVENTS.emit_signal("change_map_requested")
