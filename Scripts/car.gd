extends Area2D

@onready var sprite = $Sprite2D

var speed = 30
var sprite_array = ["res://Sprites/Car_Sprites/blue car.png", 
"res://Sprites/Car_Sprites/red car.png"]


func _ready() -> void:
	self.area_entered.connect(_on_area_entered)
	sprite.texture = load(sprite_array[randi() % sprite_array.size()])
	sprite.rotation_degrees = 90
	self.add_to_group("Cars")

func _physics_process(delta: float) -> void:
	self.position.x += speed * delta

func _on_area_entered(area) -> void:
	if area.name == "CarStoppingPoint":
		print("leaving!")
		self.queue_free()
