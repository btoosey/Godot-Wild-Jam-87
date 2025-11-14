extends Node


@onready var gameplay_state_machine: StateMachine = $GameplayStateMachine as StateMachine


func _ready() -> void:
	gameplay_state_machine.init()
