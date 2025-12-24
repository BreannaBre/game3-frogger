extends CharacterBody2D

const tile_size = 32
var input_dir: Vector2
var moving = false
# used this video for grid-based movement reference: 
# https://youtu.be/8tDcJEbQnW0?si=0sO_DBvVuNA97iRi
func _physics_process(_delta: float) -> void:
	input_dir = Vector2.ZERO
	if Input.is_action_just_pressed("ui_down"):
		input_dir = Vector2(0,1)
		move()
	elif Input.is_action_just_pressed("ui_up"):
		input_dir = Vector2(0,-1)
		move()
	elif Input.is_action_just_pressed("ui_right"):
		input_dir = Vector2(1,0)
		move()
	elif Input.is_action_just_pressed("ui_left"):
		input_dir = Vector2(-1,0)
		move()
	move_and_slide()

func move():
	if input_dir:
		if moving == false:
			moving = true
			var tween = create_tween()
			tween.tween_property(self, "position", position + input_dir*tile_size, 0.1)
			tween.tween_callback(move_false)
		
func move_false():
	moving = false
