extends CelestialBody
class_name Planet

func is_class(value: String): return value == "Planet" or .is_class(value)
func get_class() -> String: return "Planet"

onready var animated_sprite_node : AnimatedSprite = get_node("AnimatedSprite")

export(String) var explored_description setget set_explored_description, get_explored_description

export(Array) var ressource_path_array setget set_ressource_path_array, get_ressource_path_array
signal ressource_path_array_changed()

export(String) var itch_link = "" setget set_itch_link, get_itch_link
signal link_changed()

export(String) var portfolio_link = "" setget set_portfolio_link, get_portfolio_link

export(String, "Lava", "Dry", "Island", "Terran", "Ice", "MotherLand", "None") var biome = "Terran" setget set_biome, get_biome
signal biome_changed()

# Setters & Getters need to be defined in order for an exported variable to work
#### ACCESSORS ####
func set_explored_description(new_description : String) -> void:
	if new_description != explored_description:
		explored_description = new_description
		#emit_signal()

func get_explored_description() -> String:
	return explored_description

func set_ressource_path_array(new_array : Array) -> void:
	if new_array != ressource_path_array:
		ressource_path_array = new_array
		emit_signal("ressource_path_array_changed")

func get_ressource_path_array() -> Array:
	return ressource_path_array.duplicate()

func set_itch_link(new_link : String) -> void:
	if new_link != itch_link:
		itch_link = new_link
		emit_signal("link_changed")

func get_itch_link() -> String:
	return itch_link

func set_portfolio_link(new_link : String) -> void:
	if new_link != portfolio_link:
		portfolio_link = new_link
		#emit_signal()

func get_portfolio_link() -> String:
	return portfolio_link

func set_biome(new_biome : String) -> void:
	if new_biome != biome:
		biome = new_biome
		emit_signal("biome_changed")

func get_biome() -> String:
	return biome

#### BUILT-IN ####
func _ready() -> void:
	change_animation()
	
	var __ = connect("biome_changed", self, "_on_biome_changed")

#### VIRTUALS ####

#### LOGIC ####
func change_animation() -> void:
	animated_sprite_node.play(biome)

#### INPUTS ####

#### SIGNAL RESPONSES ####
func _on_biome_changed() -> void:
	change_animation()
