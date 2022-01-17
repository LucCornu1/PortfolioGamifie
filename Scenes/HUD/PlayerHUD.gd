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

signal hyperspace_skipped()
signal planet_explored()


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

func set_label_text(new_text : String, label_node : Label) -> void:
	if new_text != label_node.get_text():
		label_node.set_text(new_text)


#### INPUTS ####
func _on_skip_panel_gui_input(event : InputEvent) -> void:
	if event.is_action_pressed("left_click") && skip_panel.is_visible():
		emit_signal("hyperspace_skipped")

func _on_explore_button_gui_input(event):
	if event.is_action_pressed("left_click") && explore_button_panel.is_visible():
		emit_signal("planet_explored")


#### SIGNAL RESPONSES ####
func _on_hyperspace_entered(value) -> void:
	animation_player.play("WhiteFlash")
	skip_panel.set_visible(value)
