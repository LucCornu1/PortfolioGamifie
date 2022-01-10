extends KinematicBody2D
class_name PlayerCharacter

func is_class(value: String): return value == "PlayerCharacter" or .is_class(value)
func get_class() -> String: return "PlayerCharacter"


onready var character_sprite_node : Sprite = get_node("Sprite")
onready var character_animated_sprite_node0 : AnimatedSprite = get_node("Thruster0")
onready var character_animated_sprite_node1 : AnimatedSprite = get_node("Thruster1")
onready var state_machine : Node = get_node("StateMachine")
onready var player_hud_node : CanvasLayer = get_node("PlayerHUD")
onready var interaction_area_node : Area2D = get_node("Area2D")

export(float) var movement_speed_X = 0.0 setget set_movement_speed_X, get_movement_speed_X
signal movement_speed_X_changed()

export(float) var movement_speed_Y = 0.0 setget set_movement_speed_Y, get_movement_speed_Y
signal movement_speed_Y_changed()

var moving_direction : Vector2 = Vector2.ZERO setget set_moving_direction, get_moving_direction
signal moving_direction_changed()

var velocity : Vector2 = Vector2.ZERO setget set_velocity, get_velocity
signal velocity_changed()

var facing_left : bool = false setget set_facing_left, get_facing_left
signal facing_left_changed()

# const acceleration : int = 30
# const decceleration : int = 25
const move_state_threshold : float = 20.0

var dirLeft : int = 0
var dirRight : int = 0
var dirUp : int = 0
var dirDown : int = 0


## STATES
export(String) var default_state = ""

func set_state(value) -> void: state_machine.set_state(value)
func get_state() -> Object: return state_machine.get_state()
func get_state_name() -> String: return state_machine.get_state_name()


#### ACCESSORS ####
func set_movement_speed_X(new_speed : float) -> void:
	if new_speed != movement_speed_X:
		movement_speed_X = new_speed
		emit_signal("movement_speed_X_changed")

func get_movement_speed_X() -> float:
	return movement_speed_X

func set_movement_speed_Y(new_speed : float) -> void:
	if new_speed != movement_speed_Y:
		movement_speed_Y = new_speed
		emit_signal("movement_speed_Y_changed")

func get_movement_speed_Y() -> float:
	return movement_speed_Y

func set_moving_direction(new_direction : Vector2) -> void:
	if new_direction != moving_direction:
		moving_direction = new_direction
		emit_signal("moving_direction_changed")

func get_moving_direction() -> Vector2:
	return moving_direction

func set_velocity(new_velocity : Vector2) -> void:
	if new_velocity != velocity:
		velocity = new_velocity
		emit_signal("velocity_changed")

func get_velocity() -> Vector2:
	return velocity

func set_facing_left(value : bool) -> void:
	if value != facing_left:
		facing_left = value
		flip()
		emit_signal("facing_left_changed")

func get_facing_left() -> bool:
	return facing_left


#### BUILT-IN ####
func _ready() -> void:
	# set_state("Idle")
	
	var __ = connect("movement_speed_X_changed", self, "_on_movement_speed_X_changed")
	__ = connect("movement_speed_Y_changed", self, "_on_movement_speed_Y_changed")
	__ = connect("moving_direction_changed", self, "_on_movement_direction_changed")
	__ = connect("velocity_changed", self, "_on_velocity_changed")
	__ = connect("facing_left_changed", self, "_on_facing_left_changed")
	__ = interaction_area_node.connect("area_entered", self, "_on_area_interaction_entered")
	__ = interaction_area_node.connect("area_exited", self, "_on_area_interaction_exited")

func _physics_process(_delta) -> void:
	_compute_velocity()
	_apply_movement()


#### VIRTUALS ####



#### LOGIC ####
func _compute_velocity() -> void:
	set_velocity(Vector2(moving_direction.x * movement_speed_X, moving_direction.y * movement_speed_Y))

func _apply_movement() -> void:
	if velocity != Vector2.ZERO:
		set_velocity(move_and_slide(velocity, Vector2.UP, false, 20, deg2rad(46), false))

# Flip the actor accordingly to the direction it is facing
func flip():
	if !is_instance_valid(character_sprite_node) || !is_instance_valid(character_animated_sprite_node0):
		yield(self, "ready")
	
	# Flip the sprite
	character_sprite_node.set_flip_h(facing_left)

	# Flip the animated sprite
	if facing_left:
		character_animated_sprite_node0.offset.x = abs(character_animated_sprite_node0.offset.x)
		character_animated_sprite_node1.offset.x = abs(character_animated_sprite_node1.offset.x)
	else:
		character_animated_sprite_node0.offset.x = -abs(character_animated_sprite_node0.offset.x)
		character_animated_sprite_node1.offset.x = -abs(character_animated_sprite_node1.offset.x)
	
	character_animated_sprite_node0.set_flip_h(facing_left)
	character_animated_sprite_node1.set_flip_h(facing_left)


#### INPUTS ####
func _input(event: InputEvent) -> void:
	if !event is InputEventKey:
		return
	
	var action_name : String = ""

	if event.is_action_pressed("player_left"):
		action_name = "MoveLeft_Pressed"
	
	elif event.is_action_released("player_left"):
		action_name = "MoveLeft_Released"
	
	elif event.is_action_pressed("player_right"):
		action_name = "MoveRight_Pressed"
	
	elif event.is_action_released("player_right"):
		action_name = "MoveRight_Released"
	
	elif event.is_action_pressed("player_up"):
		action_name = "MoveUp_Pressed"
	
	elif event.is_action_released("player_up"):
		action_name = "MoveUp_Released"
	
	elif event.is_action_pressed("player_down"):
		action_name = "MoveDown_Pressed"
	
	elif event.is_action_released("player_down"):
		action_name = "MoveDown_Released"

	if action_name != "": action(action_name)

func action(action_name: String) -> void:
	match(action_name):
		"MoveLeft_Pressed":
			dirLeft = 1
		"MoveLeft_Released":
			dirLeft = 0
		"MoveRight_Pressed":
			dirRight = 1
		"MoveRight_Released":
			dirRight = 0
		"MoveUp_Pressed":
			dirUp = 1
		"MoveUp_Released":
			dirUp = 0
		"MoveDown_Pressed":
			dirDown = 1
		"MoveDown_Released":
			dirDown = 0
		_:
			return
			
	set_moving_direction(Vector2(dirRight - dirLeft, dirDown - dirUp))


#### SIGNAL RESPONSES ####
func _on_movement_speed_X_changed() -> void:
	pass

func _on_movement_speed_Y_changed() -> void:
	pass

func _on_movement_direction_changed() -> void:
	if moving_direction.x != 0.0:
		set_facing_left(moving_direction.x < 0)

func _on_velocity_changed() -> void:
	pass

func _on_facing_left_changed() -> void:
	pass

func _on_area_interaction_entered(area : Area2D) -> void:
	var object = area.owner
	if is_instance_valid(object):
		if object.is_class("CelestialBody"):
			if player_hud_node.has_method("show_name"):
				player_hud_node.show_name(object.get_body_name(), object.get_body_title(), object.get_body_description())

func _on_area_interaction_exited(area : Area2D) -> void:
	var object = area.owner
	if is_instance_valid(object):
		if object.is_class("CelestialBody"):
			if player_hud_node.has_method("hide_name"):
				player_hud_node.hide_name()
