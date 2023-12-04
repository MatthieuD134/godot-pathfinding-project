extends CatState
class_name CatIdle

var idle_time: float

func randomize_idle_time():
	idle_time = randf_range(1, 5)


func enter():
	self.cat.velocity = Vector2(0, 0)
	randomize_idle_time()
	self.cat.animated_sprite.play("idle")


func update(delta: float):
	if cat:
		if idle_time > 0:
			idle_time -= delta
		else:
			transitioned.emit(self, "roaming")


func _on_laser_entered_sight(_laser: PlayerLaser):
	transitioned.emit(self, "hunting")
