extends Node

@onready var frog = $Frog
@onready var tiles = $TileMapLayer

func _ready() -> void:
	frog.landed.connect(_on_frog_landed)

func _on_frog_landed(pos: Vector2):
	var tile_position = tiles.local_to_map(tiles.to_local(pos))
	var data = tiles.get_cell_tile_data(tile_position)
	
	if data and data.get_custom_data("isWater"):
		frog.water_death()
