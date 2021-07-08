extends Control

var hex_data

onready var file_dialog = $file_dialog
onready var status = $data_scroll/data_status

signal loaded(loaded_data)
signal cleared

func _file_selected(path):
	var file = File.new()
	if file.file_exists(path):
		file.open(path, file.READ)
		var filesize = file.get_len()
		var buffer = file.get_buffer(filesize)
		hex_data = buffer.hex_encode()
		status.text = str(path.get_file()) + "\n"
		status.text += "Size: " + str(filesize * 2) + " characters"
		file.close()
		emit_signal("loaded", hex_data)

func _clear_pressed():
	hex_data = null
	status.text = "No data assigned"
	emit_signal("cleared")

func _load_pressed():
	file_dialog.popup_centered()
