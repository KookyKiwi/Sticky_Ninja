extends Control

@onready var animated_sprite: AnimatedSprite2D = $Ninja/AnimatedSprite2D

func _process(_delta):
	animated_sprite.play("run")

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Test_Map.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scenes/options_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
