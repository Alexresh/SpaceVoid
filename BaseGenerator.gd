extends Node3D

var map = []
var map_size : int
var random = RandomNumberGenerator.new()
var seed = 14889
var points = []
const SIDE2 = "res://Models/Base_blocks/2side.glb"
const SIDE4 = "res://Models/Base_blocks/4side.glb"
const INTEREST = "res://Models/Base_blocks/interest.glb"

func generate(size : int, points_of_interest : int):
	#random.set_seed(seed)
	random.randomize()
	map_size = size
	initialize_map()
	generate_points_of_interest(points_of_interest)
	connect_all_points()
	#print_map_to_console()
	instantinate_map()

func instantinate_map():
	for i in range(map_size):
		for j in range(map_size):
			match map[i][j]:
				1:
					var block = preload("res://Models/Base_blocks/2side.tscn").instantiate()
					block.rotate_y(deg_to_rad(90))
					set_base_block(i, j, block)
				2: 
					var block = preload("res://Models/Base_blocks/2side.tscn").instantiate()
					set_base_block(i, j, block)
				3: 
					var block = preload("res://Models/Base_blocks/4side.tscn").instantiate()
					set_base_block(i, j, block)
				9: 
					var block = preload("res://Models/Base_blocks/Interest.tscn").instantiate()
					set_base_block(i, j, block)

func set_base_block(x : int, y : int, block):
	get_parent_node_3d().add_child(block)
	block.set_position(Vector3(x * 5, 0, y * 5))

func initialize_map():
	map.clear()
	points.clear()
	for i in range(map_size): 
		map.append([])
		for j in range(map_size): 
			map[i].append(0)

func generate_points_of_interest(points_of_interest : int):
	var done = false
	while (!done):
		var x = random.randi_range(0, map_size - 1)
		var y = random.randi_range(0, map_size - 1)
		if(map[x][y] != 9):
			map[x][y] = 9
			points_of_interest -= 1
			points.append(Vector2(x, y))
		if(points_of_interest == 0):
			done = true

func print_map_to_console():
	for i in range(map_size):
		var out = ""
		for j in range(map_size):
			match map[i][j]:
				0: out+=" "
				1: out+="|"
				2: out+="-"
				3: out+="+"
				9: out+="@"
		print(out)
	for item in points:
		print(str(item))

func connect_two_point(one : Vector2, two : Vector2, one_line = true):
	if(one_line):
		var vector = random.randi_range(0,1)
		if(vector):
			draw_vertical_line(one.y, two.y, one.x)
			draw_horizontal_line(one.x, two.x, two.y)
		else:
			draw_vertical_line(one.y, two.y, two.x)
			draw_horizontal_line(one.x, two.x, one.y)
			
func connect_all_points():
	for i in range(0, points.size() - 1):
		connect_two_point(points[i], points[i+1])
	

func draw_vertical_line(y1, y2, x):
	for i in range(min(y1, y2), max(y1, y2) + 1):
		if((i == y1 || i == y2) && map[x][i] != 9): map[x][i] = 3
		match map[x][i]:
			0:
				map[x][i] = 2
			1:
				map[x][i] = 3

func draw_horizontal_line(x1, x2, y):
	for i in range(min(x1, x2), max(x1, x2) + 1):
		if((i == x1 || i == x2) && map[i][y] != 9): map[i][y] = 3
		match map[i][y]:
			0:
				map[i][y] = 1
			2:
				map[i][y] = 3
