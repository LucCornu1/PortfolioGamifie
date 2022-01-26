extends CanvasLayer
class_name PlayerHUD

func is_class(value: String): return value == "PlayerHUD" or .is_class(value)
func get_class() -> String: return "PlayerHUD"


onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")
# onready var texture_rect_node : TextureRect = get_node("BottomMiddle/ObjectName")
onready var name_label : Label = get_node("BottomMiddle/ObjectName/Name")
onready var title_label : Label = get_node("TopLeft/ObjectDescription/Title")
onready var decription_label : Label = get_node("TopLeft/ObjectDescription/Description")
onready var skip_panel : Panel = get_node("BottomRight/Skip")
onready var explore_button_panel : Panel = get_node("TopLeft/ExploreButton")
onready var top_right_node : Control = get_node("TopRight")
onready var image_control_node : Control = get_node("TopRight/ImgControl")
onready var image_itch_node : TextureRect = get_node("TopRight/Itchio")
onready var colonize_button : Panel = get_node("TopRight/Colonize")
onready var destroy_button : Panel = get_node("TopRight/Destroy")
onready var center_control_node : Control = get_node("Center")

var planet : Planet = null
var destroy_mode : bool = false

signal hyperspace_skipped()
signal planet_explored()
signal screen_shake()


#### ACCESSORS ####



#### BUILT-IN ####
func _ready() -> void:
	pass


#### VIRTUALS ####



#### LOGIC ####
func show_name(name : String, title : String, description : String) -> void:
	animation_player.play("transition")
	set_label_text(name, name_label)
	set_label_text(title, title_label)
	set_label_text(description, decription_label)

func hide_name() -> void:
	animation_player.play_backwards("transition")
	hide_planet_informations()

func set_label_text(new_text : String, label_node : Label) -> void:
	if new_text != label_node.get_text():
		label_node.set_text(new_text)

func show_planet_informations(object_scan : Planet) -> void:
	var ressource_path_array : Array = object_scan.get_ressource_path_array()
	var children_array : Array = image_control_node.get_children()
	planet = object_scan
	if planet.get_link() == "":
		image_itch_node.set_visible(false)
		if planet.get_biome() != "None":
			destroy_button.set_visible(true)
		if planet.get_biome() != "MotherLand":
			colonize_button.set_visible(true)
	else:
		image_itch_node.set_visible(true)
		destroy_button.set_visible(false)
		colonize_button.set_visible(false)
	
	top_right_node.set_visible(true)
	for i in children_array.size():
		if ResourceLoader.exists(ressource_path_array[i]):
			children_array[i].texture = load(ressource_path_array[i])

func hide_planet_informations() -> void:
	var children_array : Array = image_control_node.get_children()
	
	top_right_node.set_visible(false)
	for i in children_array.size():
		children_array[i].texture = null

func show_explore_button(value : bool) -> void:
	explore_button_panel.set_visible(value)

func show_change_system_panel(value : bool) -> void:
	center_control_node.set_visible(value)

func colonize_planet() -> void:
	if destroy_mode:
		planet.set_biome("None")
	else:
		planet.set_biome("MotherLand")

func shake() -> void:
	emit_signal("screen_shake")


#### INPUTS ####
func _on_skip_panel_gui_input(event : InputEvent) -> void:
	if event.is_action_pressed("left_click") and skip_panel.is_visible():
		emit_signal("hyperspace_skipped")

func _on_explore_button_gui_input(event : InputEvent) -> void:
	if event.is_action_pressed("left_click") and explore_button_panel.is_visible():
		emit_signal("planet_explored")

func _on_no_button_gui_input(event : InputEvent) -> void:
	if event.is_action_pressed("left_click") and center_control_node.is_visible():
		center_control_node.set_visible(false)

func _on_yes_button_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click") and center_control_node.is_visible():
		get_tree().change_scene("res://Scenes/Levels/Galaxy/GalaxyMap.tscn")

func _on_itch_button_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click") and image_itch_node.is_visible():
		OS.shell_open(planet.get_link())
		if planet.get_biome() != "None":
			destroy_button.set_visible(true)
		if planet.get_biome() != "MotherLand":
			colonize_button.set_visible(true)

func _on_colonize_button_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click") and colonize_button:
		destroy_mode = false
		animation_player.play("BigShake")

func _on_destroy_button_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click") and destroy_button:
		destroy_mode = true
		animation_player.play("BigShake")


#### SIGNAL RESPONSES ####
func _on_hyperspace_entered(value) -> void:
	animation_player.play("WhiteFlash")
	skip_panel.set_visible(value)
