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
	__ = EVENTS.connect("previous_object", self, "_on_previous_clicked")
	__ = EVENTS.connect("next_object", self, "_on_next_clicked")
	
	var index : int = celestial_objects_node.get_child_count()-1
	if is_instance_valid(celestial_objects_node.get_child(index)):
		var right_limit : float = celestial_objects_node.get_child(index).position.x + 2400
		player_character.character_camera2D_node.set_limit(MARGIN_RIGHT, right_limit)

#### VIRTUALS ####

#### LOGIC ####
func set_player_position(position : Vector2) -> void:
	position = Vector2(position.x + 1200, position.y)
	player_character.set_position(position)

#### INPUTS ####

#### SIGNAL RESPONSES ####
func _on_previous_clicked() -> void:
	var current_index : int = int(round(player_character.get_position().x / 10000))
	var target_index : int
	if (current_index - 1) < 0:
		target_index = celestial_objects_node.get_child_count() - 1
	else:
		target_index = current_index - 1
	
	if target_index != current_index:
		var target : Vector2 = celestial_objects_node.get_child(target_index).get_position()
		set_player_position(target)

func _on_next_clicked() -> void:
	var current_index : int = int(round(player_character.get_position().x / 10000))
	var target_index : int
	if (current_index + 1) > celestial_objects_node.get_child_count() - 1:
		target_index = 0
	else:
		target_index = current_index + 1
	
	if target_index != current_index:
		var target : Vector2 = celestial_objects_node.get_child(target_index).get_position()
		set_player_position(target)
