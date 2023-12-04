extends CatState
class_name CatFollowing

var update_timer: float
var laser_in_sight: bool = true


func update_target_position():
	if laser_in_sight:
		self.cat.navigation_agent.set_target_position(self.cat.active_laser.get_global_position())
	update_timer = .1

func enter():
	update_target_position()
	self.cat.animated_sprite.play("run")


func physics_update(delta: float):
	if self.cat:
		print("following")
		if not update_timer > 0:
			update_target_position()
		else:
			update_timer -= delta
		
		if not self.cat.navigation_agent.is_navigation_finished():
			var next_path_position: Vector2 = self.cat.navigation_agent.get_next_path_position()
			self.cat.velocity = (next_path_position - self.cat.global_position).normalized() * self.movement_speed
		else:
			if not laser_in_sight:
				transitioned.emit(self, "idle")
				print("end")

func _on_laser_entered_sight(laser: PlayerLaser):
	if laser == self.cat.active_laser:
		laser_in_sight = true

func _on_laser_left_sight(laser: PlayerLaser):
	if laser == self.cat.active_laser:
		laser_in_sight = false

