extends Option
class_name LinkedInOption

func is_class(value: String): return value == "LinkedInOption" or .is_class(value)
func get_class() -> String: return "LinkedInOption"

#### ACCESSORS ####

#### BUILT-IN ####



#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####
func _on_button_pressed() -> void:
	._on_button_pressed()
	OS.shell_open("https://www.linkedin.com/in/luc-cornu-3554a51b1/")
