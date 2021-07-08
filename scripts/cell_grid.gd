extends GridContainer

var cells = []

func _ready():
	cells.append($cell_0)
	cells.append($cell_1)
	cells.append($cell_2)
	cells.append($cell_3)
	cells.append($cell_4)
	cells.append($cell_5)
	cells.append($cell_6)
	cells.append($cell_7)
	cells.append($cell_8)
	cells.append($cell_9)
	cells.append($cell_a)
	cells.append($cell_b)
	cells.append($cell_c)
	cells.append($cell_d)
	cells.append($cell_e)
	cells.append($cell_f)

func _call_cell(id):
	cells[id]._play_sample()
