extends CelestialBody
class_name Planet

func is_class(value: String): return value == "Planet" or .is_class(value)
func get_class() -> String: return "Planet"


export(String) var ressource_path = "" setget set_ressource_path, get_ressource_path
signal ressource_path_changed()

export(String) var link = "" setget set_link, get_link
signal link_changed()


#### ACCESSORS ####
func set_ressource_path(new_path : String) -> void:
	if new_path != ressource_path:
		ressource_path = new_path
		emit_signal("ressource_path_changed")

func get_ressource_path() -> String:
	return ressource_path

func set_link(new_link : String) -> void:
	if new_link != link:
		link = new_link
		emit_signal("link_changed")

func get_link() -> String:
	return link


#### BUILT-IN ####



#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####
