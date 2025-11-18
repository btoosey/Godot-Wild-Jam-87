class_name MovementComponent
extends Node

@export var character: Node2D = null
@export var velocity_component: VelocityComponent = null

var can_move: bool = true
var current_direction

enum direction {
	UP,
	UP_RIGHT,
	UP_LEFT,
	DOWN,
	DOWN_LEFT,
	DOWN_RIGHT,
	LEFT,
	RIGHT,
	IDLE
}

var key_up := false
var key_down := false
var key_left := false
var key_right := false


func _process(_delta: float) -> void:
	if !can_move:
		return

	_get_input()
	_set_direction()
	_move()


func _set_direction() -> void:
	if key_up:
		if key_left:
			current_direction = direction.UP_LEFT
		elif key_right:
			current_direction = direction.UP_RIGHT
		else:
			current_direction = direction.UP
	elif key_down:
		if key_left:
			current_direction = direction.DOWN_LEFT
		elif key_right:
			current_direction = direction.DOWN_RIGHT
		else:
			current_direction = direction.DOWN
	elif key_left:
		current_direction = direction.LEFT
	elif key_right:
		current_direction = direction.RIGHT
	else:
		current_direction = direction.IDLE


func _move() -> void:
	match current_direction:
		direction.UP:
			character.velocity = Vector2(0, -velocity_component.max_speed)
		direction.DOWN:
			character.velocity = Vector2(0, velocity_component.max_speed)
		direction.LEFT:
			character.velocity = Vector2(-velocity_component.max_speed, 0)
		direction.RIGHT:
			character.velocity = Vector2(velocity_component.max_speed, 0)
		direction.UP_LEFT:
			character.velocity = _cartesian_to_isometric(Vector2(-velocity_component.max_speed, 0))
		direction.UP_RIGHT:
			character.velocity = _cartesian_to_isometric(Vector2(0, -velocity_component.max_speed))
		direction.DOWN_LEFT:
			character.velocity = _cartesian_to_isometric(Vector2(0, velocity_component.max_speed))
		direction.DOWN_RIGHT:
			character.velocity = _cartesian_to_isometric(Vector2(velocity_component.max_speed, 0))
		direction.IDLE: character.velocity = Vector2.ZERO

	character.move_and_slide()


func _get_input() -> void:
	if Input.is_action_pressed("move_up"): key_up = true
	else: key_up = false

	if Input.is_action_pressed("move_down"): key_down = true
	else: key_down = false

	if Input.is_action_pressed("move_left"): key_left = true
	else: key_left = false

	if Input.is_action_pressed("move_right"): key_right = true
	else: key_right = false


func _cartesian_to_isometric(cartesian) -> Vector2:
	return Vector2(cartesian.x - cartesian.y, (cartesian.x + cartesian.y) / 2)
