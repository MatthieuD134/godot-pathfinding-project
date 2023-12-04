extends CatState
class_name CatHunting


func enter():
	self.cat.velocity = Vector2(0, 0)
	self.cat.animated_sprite.play("hunting")


func _on_laser_left_sight(_laser: PlayerLaser):
	transitioned.emit(self, "idle")

func _on_laser_movement_check_triggered(laser: PlayerLaser, _laser_position: Vector2):
	self.cat.active_laser = laser
	self.transitioned.emit(self, "following")
