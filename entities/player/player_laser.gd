extends Area2D
class_name PlayerLaser

signal movement_check_triggered(laser: PlayerLaser, global_position: Vector2)

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

var _can_be_activated: bool = true


func _physics_process(_delta) -> void:
	self.global_position = self.get_global_mouse_position()
	
	if Input.is_action_just_pressed("leftClick") and self._can_be_activated:
		self.movement_check_triggered.emit(self, self.global_position)
		animatedSprite.play("activate")
		self._can_be_activated = false

func _on_animated_sprite_2d_animation_finished() -> void:
	self._can_be_activated = true
