extends StaticBody2D


const paddle_speed:int = 700

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	move_paddle(delta)


func move_paddle(delta:float) -> void:
	if Input.is_action_pressed("left") and position.x > 75:
		position.x -= paddle_speed * delta
	elif Input.is_action_pressed("right") and position.x < 725:
		position.x += paddle_speed * delta
