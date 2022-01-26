extends KinematicBody2D
class_name PlayerCharacter

func is_class(value: String): return value == "PlayerCharacter" or .is_class(value)
func get_class() -> String: return "PlayerCharacter"


onready var character_sprite_node : Sprite = get_node("Sprite")
onready var character_animated_sprite_node0 : AnimatedSprite = get_node("Thruster0")
onready var character_animated_sprite_node1 : AnimatedSprite = get_node("Thruster1")
onready var character_camera2D_node : Camera2D = get_node("Camera2D")
onready var state_machine : Node = get_node("StateMachine")
onready var player_hud_node : CanvasLayer = get_node("PlayerHUD")
onready var interaction_area_node : Area2D = get_node("Area2D")
onready var particles2D_node : CPUParticles2D = get_node("CPUParticles2D")
onready var hyperspace_enter_audio : AudioStreamPlayer = get_node("Audio/HyperspaceEnter")
onready var hyperspace_exit_audio : AudioStreamPlayer = get_node("Audio/HyperspaceExit")

export(float) var movement_speed_X = 0.0 setget set_movement_speed_X, get_movement_speed_X
signal movement_speed_X_changed()

export(float) var movement_speed_Y = 0.0 setget set_movement_speed_Y, get_movement_speed_Y
signal movement_speed_Y_changed()

var moving_direction : Vector2 = Vector2.ZERO setget set_moving_direction, get_moving_direction
signal moving_direction_changed()

var velocity : Vector2 = Vector2.ZERO setget set_velocity, get_velocity
signal velocity_changed()

var target_velocity : Vector2 = Vector2.ZERO setget set_target_velocity, get_target_velocity
signal target_velocity_changed()

var facing_left : bool = false setget set_facing_left, get_facing_left
signal facing_left_changed()

var in_hyperspace : bool = true setget set_in_hyperspace, get_in_hyperspace
signal hyperspace_entered(value)

var on_edge : bool = false setget set_on_edge, get_on_edge
signal edge_entered()

# const acceleration : int = 30
# const decceleration : int = 25
const move_state_threshold : float = 20.0

var dirLeft : int = 0
var dirRight : int = 0
var dirUp : int = 0
var dirDown : int = 0

var object_scan : CelestialBody = null


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

func set_target_velocity(new_velocity : Vector2) -> void:
	if new_velocity != target_velocity:
		target_velocity = new_velocity
		emit_signal("target_velocity_changed")

func get_target_velocity() -> Vector2:
	return target_velocity

func set_facing_left(value : bool) -> void:
	if value != facing_left:
		facing_left = value
		flip()
		emit_signal("facing_left_changed")

func get_facing_left() -> bool:
	return facing_left

func set_in_hyperspace(value : bool) -> void:
	if value != in_hyperspace:
		in_hyperspace = value
		emit_signal("hyperspace_entered", in_hyperspace)

func get_in_hyperspace() -> bool:
	return in_hyperspace

func set_on_edge(value : bool) -> void:
	if value != on_edge:
		on_edge = value
		emit_signal("edge_entered")

func get_on_edge() -> bool:
	return on_edge


#### BUILT-IN ####	
func _ready() -> void:
	var __ = connect("movement_speed_X_changed", self, "_on_movement_speed_X_changed")
	__ = connect("movement_speed_Y_changed", self, "_on_movement_speed_Y_changed")
	__ = connect("moving_direction_changed", self, "_on_movement_direction_changed")
	__ = connect("velocity_changed", self, "_on_velocity_changed")
	__ = connect("facing_left_changed", self, "_on_facing_left_changed")
	__ = interaction_area_node.connect("area_entered", self, "_on_area_interaction_entered")
	__ = interaction_area_node.connect("area_exited", self, "_on_area_interaction_exited")
	__ = connect("hyperspace_entered", self, "_on_hyperspace_entered")
	__ = connect("hyperspace_entered", player_hud_node, "_on_hyperspace_entered")
	__ = player_hud_node.connect("hyperspace_skipped", self, "_on_hyperspace_skipped")
	__ = player_hud_node.connect("planet_explored", self, "_on_planet_explored")
	__ = player_hud_node.connect("screen_shake", self, "_on_animation_shake")
	__ = connect("edge_entered", self, "_on_edge_entered")

func _physics_process(_delta) -> void:
	_compute_velocity(_delta)
	_apply_movement()
	keep_player_on_screen()


#### VIRTUALS ####



#### LOGIC ####
func _compute_velocity(_delta : float) -> void:
	set_target_velocity(Vector2(moving_direction.x * movement_speed_X, moving_direction.y * movement_speed_Y))
	var acc : float = 0.8
	if dirRight - dirLeft != 0:
		acc = 0.5
	set_velocity(get_velocity().linear_interpolate(target_velocity, _delta * acc))

func _apply_movement() -> void:
	if velocity != Vector2.ZERO:
		set_velocity(move_and_slide(velocity, Vector2.UP, false, 20, deg2rad(46), false))

func keep_player_on_screen() -> void:
	position.x = clamp(position.x, character_camera2D_node.limit_left, character_camera2D_node.limit_right)
	position.y = clamp(position.y, character_camera2D_node.limit_top, character_camera2D_node.limit_bottom)
	
	if position.x == character_camera2D_node.limit_left || position.x == character_camera2D_node.limit_right:
		velocity.x = 0
		target_velocity.x = 0
		set_on_edge(true)
	elif position.y == character_camera2D_node.limit_top || position.y == character_camera2D_node.limit_bottom:
		velocity.y = 0
		target_velocity.y = 0
		set_on_edge(true)
	else:
		set_on_edge(false)

# Flip the actor accordingly to the direction it is facing
func flip() -> void:
	if !is_instance_valid(character_sprite_node) || !is_instance_valid(character_animated_sprite_node0):
		yield(self, "ready")
	
	# Flip the sprite
	character_sprite_node.set_flip_h(facing_left)

	# Flip the animated sprite
	if facing_left:
		character_animated_sprite_node0.position.x = abs(character_animated_sprite_node0.position.x)
		character_animated_sprite_node1.position.x = abs(character_animated_sprite_node1.position.x)
		particles2D_node.position.x = abs(particles2D_node.position.x)
		particles2D_node.direction.x = abs(particles2D_node.direction.x)
	else:
		character_animated_sprite_node0.position.x = -abs(character_animated_sprite_node0.position.x)
		character_animated_sprite_node1.position.x = -abs(character_animated_sprite_node1.position.x)
		particles2D_node.position.x = -abs(particles2D_node.position.x)
		particles2D_node.direction.x = -abs(particles2D_node.direction.x)
	
	character_animated_sprite_node0.set_flip_h(facing_left)
	character_animated_sprite_node1.set_flip_h(facing_left)

func set_hyperspace_direction(going_left : bool) -> void:
	if going_left:
		set_moving_direction(Vector2(-1, 0))
	else:
		set_moving_direction(Vector2(1, 0))


#### INPUTS ####
func _input(event: InputEvent) -> void:
	if !event is InputEventKey:
		return
	
	var action_name : String = ""

	if event.is_action_pressed("player_left") && !in_hyperspace:
		action_name = "MoveLeft_Pressed"
	
	elif event.is_action_released("player_left") && !in_hyperspace:
		action_name = "MoveLeft_Released"
	
	elif event.is_action_pressed("player_right") && !in_hyperspace:
		action_name = "MoveRight_Pressed"
	
	elif event.is_action_released("player_right") && !in_hyperspace:
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
	if !is_instance_valid(area):
		return
	
	var object = area.owner
	if is_instance_valid(object):
		if object.is_class("CelestialBody"):
			object_scan = object
			if area.get_name() == "Orbite":
				set_in_hyperspace(false)
			elif area.get_name() == "Scanner":
				player_hud_node.show_name(object.get_body_name(), object.get_body_title(), object.get_body_description())
				if object.is_class("Planet"):
					player_hud_node.show_explore_button(true)
				else:
					player_hud_node.show_explore_button(false)

func _on_area_interaction_exited(area : Area2D) -> void:
	if !is_instance_valid(area):
		return
	
	var object = area.owner
	if is_instance_valid(object):
		if object.is_class("CelestialBody"):
			object_scan = null
			if area.get_name() == "Orbite":
				set_in_hyperspace(true)
			elif area.get_name() == "Scanner":
				player_hud_node.hide_name()

func _on_hyperspace_entered(value) -> void:
	particles2D_node.set_emitting(value)
	if !value:
		hyperspace_exit_audio.play()
		dirLeft = 0
		dirRight = 0
		set_moving_direction(Vector2(dirRight - dirLeft, dirDown - dirUp))
	else:
		set_hyperspace_direction(get_facing_left())
		hyperspace_enter_audio.play()

func _on_hyperspace_skipped() -> void:
	if in_hyperspace:
		var new_x : float = int((get_position().x / 10000)) * 10000
		if facing_left:
			set_position(Vector2(new_x + 2500, get_position().y))
		else:
			set_position(Vector2(new_x + 8000, get_position().y))

func _on_planet_explored() -> void:
	if is_instance_valid(object_scan):
		if object_scan.is_class("Planet"):
#			print(object_scan.get_ressource_path())
			player_hud_node.show_planet_informations(object_scan)
		else:
			print("Nothing To Explore")

func _on_edge_entered() -> void:
	player_hud_node.show_change_system_panel(get_on_edge())

func _on_animation_shake() -> void:
	character_camera2D_node.add_trauma(0.7)
