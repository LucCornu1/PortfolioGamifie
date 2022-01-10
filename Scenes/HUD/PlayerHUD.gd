extends CanvasLayer
class_name PlayerHUD

func is_class(value: String): return value == "PlayerHUD" or .is_class(value)
func get_class() -> String: return "PlayerHUD"


onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")
# onready var texture_rect_node : TextureRect = get_node("BottomMiddle/ObjectName")
onready var name_node : Label = get_node("BottomMiddle/ObjectName/Name")
onready var title_node : Label = get_node("TopLeft/ObjectDescription/Title")
onready var description_node : Label = get_node("TopLeft/ObjectDescription/Description")


#### ACCESSORS ####



#### BUILT-IN ####
func _ready() -> void:
	pass


#### VIRTUALS ####



#### LOGIC ####
func show_name(name : String, title : String, description : String) -> void:
	animation_player.play("transition")
	set_label_text(name, name_node)
	set_label_text(title, title_node)
	set_label_text(description, description_node)

func hide_name() -> void:
	animation_player.play_backwards("transition")

func set_label_text(new_text : String, label_node : Label) -> void:
	if new_text != label_node.get_text():
		label_node.set_text(new_text)


#### INPUTS ####



#### SIGNAL RESPONSES ####
