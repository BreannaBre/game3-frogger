extends Area2D

var speed = 30

func _ready() -> void:
	self.area_entered.connect(_on_area_entered)
	
func _physics_process(delta: float) -> void:
	self.position.x += speed * delta

func _on_area_entered(area) -> void:
	print("x")
	if area.name == "FrogArea":
		print("detected!")
