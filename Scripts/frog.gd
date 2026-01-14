extends CharacterBody2D

@onready var animatedsprite = $AnimatedSprite2D
@onready var area2d = $Area2D

signal landed(landed_position: Vector2)

const tile_size = 16
var input_dir: Vector2
var moving = false
var death_happening = false
var respawn_point: Vector2
var allowed_to_move = true

func _ready() -> void:
# This allows the frog to be moved to a new spawn point
# without recoding it
	respawn_point = $".".global_position
	print($".".global_position)
	area2d.area_entered.connect(_on_area_entered)
# used this video for grid-based movement reference: 
# https://youtu.be/8tDcJEbQnW0?si=0sO_DBvVuNA97iRi
func _physics_process(_delta: float) -> void:
	if allowed_to_move:
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

func _on_area_entered(area) -> void:
	if area.name == "Car":
		respawn()

func move():
	if input_dir:
		if moving == false:
			moving = true
			animatedsprite.animation = "Hopping"
			var tween = create_tween()
			tween.tween_property(self, "position", position + input_dir*tile_size, 0.1)
			tween.tween_callback(move_false)
			tween.tween_callback(change_to_idle)
			tween.tween_callback(emit_land)
		
func move_false() -> void:
	moving = false

func change_to_idle() -> void:
	animatedsprite.animation = "Idle"

# signal frog has landed for parent node
func emit_land() -> void:
	landed.emit(global_position)

# Based on input, flip the frog sprite so it is facing the correct direction
func set_frog_alignment(flip_h, flip_v, rotate_anount) -> void:
		animatedsprite.flip_h = flip_h
		animatedsprite.flip_v = flip_v
		animatedsprite.rotation_degrees = rotate_anount

# play death animation for frog in water
# player cannot move during animation
func water_death() -> void:
	allowed_to_move = false
	animatedsprite.play("Water_death")
	await animatedsprite.animation_finished
	respawn()
	animatedsprite.play("Idle")
	allowed_to_move = true

# move frog back to spawn point
func respawn() -> void:
	self.hide()
	self.global_position = respawn_point
	set_frog_alignment(false, false, 0)
	self.show()
	
	
