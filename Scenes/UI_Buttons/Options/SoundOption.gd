extends Option
class_name SoundOption

func is_class(value: String): return value == "SoundOption" or .is_class(value)
func get_class() -> String: return "SoundOption"

#### ACCESSORS ####

#### BUILT-IN ####
func _ready() -> void:
	set_enabled(AudioServer.is_bus_mute(AudioServer.get_bus_index("Master")))

#### VIRTUALS ####

#### LOGIC ####

#### INPUTS ####

#### SIGNAL RESPONSES ####
func _on_button_pressed() -> void:
	._on_button_pressed()
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), get_enabled())
