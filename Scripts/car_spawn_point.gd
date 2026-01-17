extends Node2D

@onready var timer = $Timer

const CAR = preload("res://Scenes/Entities/car.tscn")

var min_time = 1
var max_time = 4
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	timer.set_wait_time(rng.randf_range(min_time, max_time))

func _on_timer_timeout() -> void:
	var car_instance = CAR.instantiate()
	get_parent().add_child(car_instance)
	car_instance.position = self.position
	timer.set_wait_time(rng.randf_range(min_time, max_time))
