extends CelestialBody
class_name Planet

func is_class(value: String): return value == "Planet" or .is_class(value)
func get_class() -> String: return "Planet"


onready var animated_sprite_node : AnimatedSprite = get_node("AnimatedSprite")

export(Array) var ressource_path_array setget set_ressource_path_array, get_ressource_path_array
signal ressource_path_array_changed()

export(String) var link = "" setget set_link, get_link
signal link_changed()

export(String, "Lava", "Dry", "Island", "Terran", "Ice", "MotherLand") var biome = "Terran"


# Setters & Getters need to be defined in order for an exported variable to work
#### ACCESSORS ####
func set_ressource_path_array(new_array : Array) -> void:
	if new_array != ressource_path_array:
		ressource_path_array = new_array
		emit_signal("ressource_path_array_changed")

func get_ressource_path_array() -> Array:
	return ressource_path_array.duplicate()

func set_link(new_link : String) -> void:
	if new_link != link:
		link = new_link
		emit_signal("link_changed")

func get_link() -> String:
	return link


#### BUILT-IN ####
func _ready() -> void:
	change_animation()


#### VIRTUALS ####



#### LOGIC ####
func change_animation() -> void:
	animated_sprite_node.play(biome)


#### INPUTS ####



#### SIGNAL RESPONSES ####
