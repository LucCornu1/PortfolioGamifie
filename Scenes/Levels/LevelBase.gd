extends Node2D
class_name LevelBase

func is_class(value: String): return value == "LevelBase" or .is_class(value)
func get_class() -> String: return "LevelBase"


onready var parallax_foreground_node : ParallaxBackground = get_node("ParallaxForeground")
onready var parallax_background_node : ParallaxBackground = get_node("ParallaxBackground")
onready var player_character : PlayerCharacter = get_node("PlayerCharacter")


#### ACCESSORS ####

#### BUILT-IN ####
func _ready() -> void:
	var __ = player_character.connect("hyperspace_entered", parallax_foreground_node, "_on_hyperspace_entered")
	__ = player_character.connect("hyperspace_entered", parallax_background_node, "_on_hyperspace_entered")


#### VIRTUALS ####

#### LOGIC ####

#### INPUTS ####

#### SIGNAL RESPONSES ####
