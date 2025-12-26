extends CharacterBody2D

@onready var animatedsprite = $AnimatedSprite2D

const tile_size = 32
var input_dir: Vector2
var moving = false
# used this video for grid-based movement reference: 
# https://youtu.be/8tDcJEbQnW0?si=0sO_DBvVuNA97iRi
func _physics_process(_delta: float) -> void:
	input_dir = Vector2.ZERO
	if Input.is_action_just_pressed("ui_down"):
		input_dir = Vector2(0,1)
		set_frog_alignment(false, true, 0)
		move()
	elif Input.is_action_just_pressed("ui_up"):
		input_dir = Vector2(0,-1)
		set_frog_alignment(false, false, 0)
		move()
	elif Input.is_action_just_pressed("ui_right"):
		input_dir = Vector2(1,0)
		set_frog_alignment(false, false, 90)
		move()
	elif Input.is_action_just_pressed("ui_left"):
		input_dir = Vector2(-1,0)
		set_frog_alignment(false, true, 90)
		move()
	move_and_slide()

func move():
	if input_dir:
		if moving == false:
			moving = true
			animatedsprite.animation = "Hopping"
			var tween = create_tween()
			tween.tween_property(self, "position", position + input_dir*tile_size, 0.1)
			tween.tween_callback(move_false)
			tween.tween_callback(change_to_idle)
		
func move_false() -> void:
	moving = false

func change_to_idle() -> void:
	animatedsprite.animation = "Idle"

func set_frog_alignment(flip_h, flip_v, rotate_anount) -> void:
		animatedsprite.flip_h = flip_h
		animatedsprite.flip_v = flip_v
		animatedsprite.rotation_degrees = rotate_anount
	
