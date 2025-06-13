extends StaticBody2D


@export var game_manager:Node2D
@export var block_life:int

func update_color() -> void:
	if block_life == 3:
		modulate = Color.GREEN
	elif block_life == 2:
		modulate = Color.YELLOW
	elif block_life == 1:
		modulate = Color.RED


func receive_damage() -> void:
	block_life -= 1
	if block_life > 0:
		update_color()
	else:
		game_manager.update_block_count()
		queue_free()


func run_timer() -> void:
	$Timer.start()


func _ready() -> void:
	update_color()
