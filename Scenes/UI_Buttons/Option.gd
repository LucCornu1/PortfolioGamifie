extends TextureButton
class_name Option

func is_class(value: String): return value == "Option" or .is_class(value)
func get_class() -> String: return "Option"

onready var animated_button : AnimatedSprite = get_node("AnimatedSprite")

var enabled : bool = false setget set_enabled, get_enabled
signal button_enabled()

#### ACCESSORS ####
func set_enabled(value : bool) -> void:
	if value != enabled:
		enabled = value
		emit_signal("button_enabled")

func get_enabled() -> bool:
	return enabled

#### BUILT-IN ####
func _ready():
	var __ = connect("pressed", self, "_on_button_pressed")
	__ = connect("button_down", self, "_on_button_down")
	__ = connect("button_up", self, "_on_button_up")

#### VIRTUALS ####

#### LOGIC ####

#### INPUTS ####

#### SIGNAL RESPONSES ####
func _on_button_pressed() -> void:
	set_enabled(!get_enabled())

func _on_button_down() -> void:
	pass

func _on_button_up() -> void:
	pass
