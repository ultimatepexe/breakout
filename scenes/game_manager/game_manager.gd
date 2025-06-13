extends Node2D


@export var next_stage:String
@export var blocks:Node2D
var blocks_in_stage:int = 0
@onready var timer:Timer = $Timer

func count_blocks() -> void:
	for block in blocks.get_children():
		blocks_in_stage += 1


func update_block_count() -> void:
	blocks_in_stage -= 1
	if blocks_in_stage <= 0:
		run_timer()


func run_timer() -> void:
	timer.start()


func _ready() -> void:
	count_blocks()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("r"):
		get_tree().reload_current_scene()
	elif Input.is_action_just_pressed("esc"):
		get_tree().quit()


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file(next_stage)
