extends Node2D
class_name LevelBase

func is_class(value: String): return value == "LevelBase" or .is_class(value)
func get_class() -> String: return "LevelBase"


onready var parallax_foreground_node : ParallaxBackground = get_node("ParallaxForeground")
onready var parallax_background_node : ParallaxBackground = get_node("ParallaxBackground")
onready var player_character : PlayerCharacter = get_node("PlayerCharacter")
onready var celestial_objects_node : Node2D = get_node("CelestialObjects")


#### ACCESSORS ####

#### BUILT-IN ####
func _ready() -> void:
	var __ = player_character.connect("hyperspace_entered", parallax_foreground_node, "_on_hyperspace_entered")
	__ = player_character.connect("hyperspace_entered", parallax_background_node, "_on_hyperspace_entered")
	
	var index : int = celestial_objects_node.get_child_count()-1
	if is_instance_valid(celestial_objects_node.get_child(index)):
		var right_limit : float = celestial_objects_node.get_child(index).position.x + 2400
		player_character.character_camera2D_node.set_limit(MARGIN_RIGHT, right_limit)


#### VIRTUALS ####

#### LOGIC ####

#### INPUTS ####

#### SIGNAL RESPONSES ####
