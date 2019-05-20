extends TileMap

const CHECK_PATTERN_NUMBER : int = 2

export var width : int
export var height : int
export var cursor_path : NodePath

var cursor : Sprite

func _ready():
	var area = width * height
	for i in range(area):
		var x = i % width
		var y = i / width
		set_cell(x, y, (x + y) % CHECK_PATTERN_NUMBER)
	
	cursor = get_node(cursor_path)
	cursor.hide()
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseMotion:
		var selected_tile : Vector2 = world_to_map(event.position - position)
		if is_on_grid(selected_tile):
			var tile_position = map_to_world(selected_tile)
			cursor.position = tile_position
			cursor.show()
		else:
			cursor.hide()

func get_cursor_index():
	var retVal = null
	if cursor.visible:
		retVal = map_to_world(cursor.position)
	return retVal
	
func is_on_grid(coord : Vector2):
	return coord.x >= 0 and coord.y >= 0 and coord.x < width and coord.y < height
	pass