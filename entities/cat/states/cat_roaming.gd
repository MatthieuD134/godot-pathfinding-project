extends CatState
class_name CatRoaming

@export var movement_range: int = 200

var move_position: Vector2

func randomize_wander():
	move_position = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * movement_range
	self.cat.navigation_agent.set_target_position(cat.global_position + move_position)


func enter():
	randomize_wander()
	self.cat.animated_sprite.play("walk")


func physics_update(_delta: float):
	if self.cat:
		if not self.cat.navigation_agent.is_navigation_finished():
			var next_path_position: Vector2 = self.cat.navigation_agent.get_next_path_position()
			self.cat.velocity = (next_path_position - self.cat.global_position).normalized() * self.movement_speed
		else:
			transitioned.emit(self, "idle")

func _on_laser_entered_sight(_laser: PlayerLaser):
	transitioned.emit(self, "hunting")
