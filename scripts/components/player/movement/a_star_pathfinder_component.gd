class_name AStarPathfinderComponent
extends Node

signal character_to_target_path_acquired(path)

@export var tilemap_layer_ocean: TileMapLayer = null
@export var character: Node2D = null
@export var velocity_component: VelocityComponent = null

var pathfinding_grid: AStarGrid2D = AStarGrid2D.new()
var path_to_target: Array = []
var target_tile: Vector2i


func _ready() -> void:
	pathfinding_grid.cell_shape = AStarGrid2D.CELL_SHAPE_ISOMETRIC_DOWN
	pathfinding_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	pathfinding_grid.region = tilemap_layer_ocean.get_used_rect()
	pathfinding_grid.cell_size = Vector2(Globals.TILE_SIZE, Globals.HALF_TILE_SIZE)
	pathfinding_grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_EUCLIDEAN
	pathfinding_grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_EUCLIDEAN
	pathfinding_grid.update()


func establish_path_to_target(target: Vector2i) -> void:
	path_to_target = pathfinding_grid.get_point_path(character.global_position / Globals.TILE_SIZE, target, true)

	if path_to_target.size() >= 1:
		path_to_target.remove_at(0)

	character_to_target_path_acquired.emit(path_to_target)
	print(path_to_target)


func _select_character_target() -> void:
	var x = randi_range(pathfinding_grid.region.position.x, pathfinding_grid.region.size.x + pathfinding_grid.region.position.x - 1)
	var y = randi_range(pathfinding_grid.region.position.y, pathfinding_grid.region.size.y + pathfinding_grid.region.position.y - 1)

	target_tile = Vector2(x, y)
	print(target_tile)
