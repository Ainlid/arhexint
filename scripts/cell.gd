extends Control

export var hex_num = "0"

onready var audio = $audio
onready var audio_timer = $audio_timer
var audio_time = 1.0

onready var file_dialog = $settings_menu/file_dialog

onready var flash = $flash
onready var flash_timer = $flash_timer
var flash_time = 0.1

onready var value = $value
onready var settings = $settings_menu

func _ready():
	value.text = hex_num
	audio_timer.wait_time = audio_time
	flash.hide()
	flash_timer.wait_time = flash_time

func _show_settings():
	settings.popup()

func _load_pressed():
	file_dialog.popup()

func _pitch_changed(value):
	var pitch_conv = pow(2.0, value / 12.0)
	audio.pitch_scale = pitch_conv

func _volume_changed(value):
	audio.volume_db = value

func _play_sample():
	if audio.stream:
		audio.play()
		audio_timer.start()
		flash.show()
		flash_timer.start()

func _flash_timeout():
	flash.hide()

func _audio_timeout():
	audio.stop()
