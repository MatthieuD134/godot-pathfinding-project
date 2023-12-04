extends State
class_name CatState

@export var cat: Cat
@export var movement_speed: int = 64


func _ready():
	if cat:
		cat.laser_entered_sight.connect(_on_laser_entered_sight)
		cat.laser_left_sight.connect(_on_laser_left_sight)
	
	for laser in get_tree().get_nodes_in_group("PlayerLasers"):
		if laser as PlayerLaser:
			laser.movement_check_triggered.connect(_on_laser_movement_check_triggered)


func _on_laser_entered_sight(_laser: PlayerLaser):
	pass


func _on_laser_left_sight(_laser: PlayerLaser):
	pass


func _on_laser_movement_check_triggered(_laser: PlayerLaser, _laser_position: Vector2):
	pass
