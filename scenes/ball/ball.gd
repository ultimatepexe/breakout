extends Area2D


const ball_speed:int = 400
const initial_position:Vector2 = Vector2(400, 525)
var direction:Vector2 = Vector2(0, 0)
var is_first_launch:bool = true
var timer:bool = false

func reset_ball() -> void:
	position = initial_position


func choose_initial_direction() -> void:
	var random_x = [-1, 1].pick_random()
	direction = Vector2(random_x, -1)


func move_ball(delta:float) -> void:
	position += direction * ball_speed * delta


func wall_collision() -> void:
	if position.y <= 600:
		if position.y <= 0:
			direction.y *= -1
			$ImpactScreenSound.play()
		if position.x <= 0 or position.x >= 800:
			direction.x *= -1
			$ImpactScreenSound.play()
	else:
		run_timer()


func first_launch(delta:float) -> void:
	if is_first_launch:
		if Input.is_action_just_pressed("space"):
			move_ball(delta)
			is_first_launch = false
	else:
		move_ball(delta)


func run_timer() -> void:
	if !timer:
		$Timer.start()
		timer = true


func _ready() -> void:
	reset_ball()
	choose_initial_direction()


func _process(delta: float) -> void:
	first_launch(delta)
	wall_collision()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("paddle"):
		direction.y *= -1
		$ImpactPaddleSound.play()
	elif body.is_in_group("blocks"):
		$ImpactBlockSound.play()
		body.receive_damage()
		direction.y *= -1


func _on_timer_timeout() -> void:
	reset_ball()
	choose_initial_direction()
	is_first_launch = true
	timer = false
