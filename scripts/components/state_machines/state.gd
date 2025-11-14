class_name State
extends Node


@warning_ignore("unused_signal")
signal transition_requested(from: State, to: Variant)

enum StateID {PLAY}

@export var state: StateID


func enter() -> void:
	pass


func exit() -> void:
	pass
