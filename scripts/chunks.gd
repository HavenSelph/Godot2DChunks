extends Node2D

const tile_size = 16

const region_size = 10
const region_depth = 100
var regions = []

const tiles = {
	"dirt": Vector2i(0, 0),
	"grass": Vector2i(1, 0),
	"coal": Vector2i(2, 0),
	"copper": Vector2i(3, 0),
	"iron": Vector2i(4, 0),
	"stone": Vector2i(5, 0)
}

const Offset = {
	"top_left": Vector2i(-1,1),
	"top_center": Vector2i(0,1),
	"top_right": Vector2i(1,1),
	"center_left": Vector2i(-1,0),
	"center_right": Vector2i(1,0),
	"bottom_left": Vector2i(-1,-1),
	"bottom_center": Vector2i(0,-1),
	"bottom_right": Vector2i(1,-1)
}

func make_tile_map(region: int) -> TileMap:
	var tile_map = TileMap.new()
	tile_map.name = "Region " + str(region)
	tile_map.tile_set = load("res://objects/tiles.tres")
	print(region * region_size * tile_size)
	tile_map.global_position = Vector2(region * region_size * tile_size, 0)
	return tile_map

func generate(_region: int, tile_map: TileMap):
	for x in range(region_size):
		for y in range(region_depth, -region_depth, -1):
			var tile
			if y == 0:
				tile = tiles.grass
			elif y > 0 and y <= 4:
				tile = tiles.dirt
			elif y > 4:
				tile = tiles.stone
			else:
				continue
			tile_map.set_cell(0, Vector2i(x, y), 0, tile)

func make_and_generate(region: int) -> TileMap:
	var tile_map = make_tile_map(region)
	generate(region, tile_map)
	add_child(tile_map)
	print("Generated region " + str(region))
	for i in range(4):
		var coords = tile_map.get_cell_atlas_coords(0, Vector2i(i,5))
		print(str(coords.x) + ", " + str(coords.y))
	return tile_map

# Called when the node enters the scene tree for the first time.
func _ready():
	regions.append(make_and_generate(0))
	regions.append(make_and_generate(-1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
