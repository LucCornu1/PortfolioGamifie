extends Node2D
class_name CelestialBody

func is_class(value: String): return value == "CelestialBody" or .is_class(value)
func get_class() -> String: return "CelestialBody"


export(String) var body_name = "" setget set_body_name, get_body_name
signal body_name_changed()

export(String) var body_description = "" setget set_body_description, get_body_description
signal body_description_changed()


#### ACCESSORS ####
func set_body_name(new_name : String) -> void:
	if new_name != body_name:
		body_name = new_name
		emit_signal("body_name_changed")

func get_body_name() -> String:
	return body_name

func set_body_description(new_description : String) -> void:
	if new_description != body_description:
		body_description = new_description
		emit_signal("body_description_changed")

func get_body_description() -> String:
	return body_description


#### BUILT-IN ####
func _ready() -> void:
	var __ = connect("body_name_changed", self, "_on_body_name_changed")
	__ = connect("body_description_changed", self, "_on_body_description_changed")


#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####
func _on_body_name_changed() -> void:
	pass

func _on_body_description_changed() -> void:
	pass
