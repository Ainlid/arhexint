extends Button

onready var check = $check

func _pressed():
	check.popup_centered()

func _reset_ok():
	get_tree().reload_current_scene()
