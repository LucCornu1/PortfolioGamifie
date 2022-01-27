extends Option
class_name PortfolioOption

func is_class(value: String): return value == "PortfolioOption" or .is_class(value)
func get_class() -> String: return "PortfolioOption"

#### ACCESSORS ####

#### BUILT-IN ####

#### VIRTUALS ####

#### LOGIC ####

#### INPUTS ####

#### SIGNAL RESPONSES ####
func _on_button_pressed() -> void:
	._on_button_pressed()
	OS.shell_open("https://tempusfugit6.itch.io/") ### CHANGE TO THE FUTUR PORTFOLIO
