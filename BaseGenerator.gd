extends Node3D

var map = []
var map_size : int
var random = RandomNumberGenerator.new()
var seed = 1488


func generate(size : int):
	map_size = size
	initialize_map()


func initialize_map():
	for i in range(map_size): 
		map.append([])
		for j in range(map_size): 
			map[i].append(0)
	print(str(map))
