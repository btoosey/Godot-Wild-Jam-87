class_name StateMachine
extends Node


@export var initial_state: State

var current_state: State
var states := {}


func init() -> void:
	for child in get_children():
		if child is State:
			states[child.state] = child
			child.transition_requested.connect(_on_transition_requested)

	if initial_state:
		initial_state.enter()
		current_state = initial_state


func on_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_input(event)


func _on_transition_requested(from: State, to: State.StateID) -> void:
	if from != current_state:
		return

	var new_state: State = states[to]
	if not new_state:
		return

	if current_state:
		current_state.exit()

	new_state.enter()
	current_state = new_state
