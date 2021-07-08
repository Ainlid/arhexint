extends Control

var hex_data
var data_size = 0
var cur_id = 0
var cur_char = "-"

onready var play_button = $play_button
var is_playing = false
onready var rate_timer = $rate_timer

signal character(char_id)

onready var recorder = $recorder
onready var record_button = $record_button
var effect
var recording

onready var save_dialog = $save_dialog
onready var save_popup = $save_popup

onready var info = $info

func _ready():
	effect = AudioServer.get_bus_effect(0, 0)

func _receive_data(loaded_data):
	hex_data = loaded_data
	data_size = hex_data.length()
	play_button.disabled = false
	_update_info()

func _data_cleared():
	_stop_playback()
	hex_data = null
	data_size = 0
	play_button.disabled = true
	_update_info()

func _rate_changed(value):
	rate_timer.wait_time = 1.0 / value

func _record_pressed():
	if effect.is_recording_active():
		recording = effect.get_recording()
		effect.set_recording_active(false)
		record_button.text = "Record"
	else:
		effect.set_recording_active(true)
		record_button.text = "Stop recording"

func _save_pressed():
	save_dialog.popup_centered()

func _confirm_save(save_path):
	if recording:
		recording.save_to_wav(save_path)
		save_popup.popup_centered()

func _play_pressed():
	if is_playing:
		_stop_playback()
	else:
		_start_playback()

func _stop_playback():
	is_playing = false
	play_button.text = "Play"
	rate_timer.stop()
	cur_id = 0
	cur_char = "-"
	_update_info()

func _start_playback():
	is_playing = true
	play_button.text = "Stop"
	rate_timer.start()

func _update_info():
	info.text = str(cur_id) + "/" + str(data_size) + "\n" + "Current value: " + cur_char

func _rate_timeout():
	cur_char = "0x" + hex_data[cur_id]
	emit_signal("character", cur_char.hex_to_int())
	_update_info()
	if cur_id < hex_data.length() - 1:
		cur_id += 1
	else:
		_stop_playback()
