extends Control

onready var audio = $audio
onready var audio_timer = $audio_timer
var audio_time = 1.0

onready var file_dialog = $settings_menu/file_dialog
onready var sample_status = $settings_menu/sample_scroll/sample_status
var empty_col = Color(0.2, 0.2, 0.2, 1.0)

onready var flash = $flash
onready var flash_timer = $flash_timer
var flash_time = 0.1

onready var settings = $settings_menu

func _ready():
	audio_timer.wait_time = audio_time
	flash.hide()
	flash_timer.wait_time = flash_time
	modulate = empty_col

func _show_settings():
	settings.popup()

func _load_pressed():
	file_dialog.popup()

func _file_selected(path):
	var file = File.new()
	if file.file_exists(path):
		file.open(path, file.READ)
		var buffer = file.get_buffer(file.get_len())
		var sample = AudioStreamSample.new()
		sample.format = AudioStreamSample.FORMAT_16_BITS      
		sample.data = buffer
		sample.stereo = true
		sample.mix_rate = 44100
		audio.stream = sample
		sample_status.text = str(path.get_file())
		file.close()
		modulate = Color.white

func _clear_pressed():
	audio.stream = null
	sample_status.text = "No sample assigned"
	modulate = empty_col

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
