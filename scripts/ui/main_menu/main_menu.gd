extends Control


var main_scene: PackedScene = preload("uid://gq26gdg6jtcb")

@onready var play_button: Button = $HBoxContainer/PlayButton


func _ready() -> void:
	play_button.pressed.connect(_on_play_pressed)


func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(main_scene)
