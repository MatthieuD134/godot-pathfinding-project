extends CharacterBody2D
class_name Cat

signal laser_entered_sight(laser: PlayerLaser)
signal laser_left_sight(laser: PlayerLaser)

@export var movement_speed: float = 128

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var laser_detection_area: Area2D = $LaserDetectionArea

var next_animation
var active_laser: PlayerLaser


func _ready() -> void:
	self.navigation_agent.set_path_desired_distance(4.0)
	self.navigation_agent.set_target_desired_distance(4.0)
	self.set_movement_target_position(self.global_position)
	self.animated_sprite.animation_finished.connect(_on_animated_sprite_animation_finished)

func _physics_process(_delta) -> void:
	move_and_slide()
	animated_sprite.flip_h = self.velocity.x < 0

func set_movement_target_position(target_position: Vector2) -> void:
	self.navigation_agent.set_target_position(target_position)
	self.animated_sprite.play("run")


func _on_laser_detection_area_area_entered(area: Area2D) -> void:
	if area as PlayerLaser:
		laser_entered_sight.emit(area)


func _on_laser_detection_area_area_exited(area: Area2D) -> void:
	if area as PlayerLaser:
		laser_left_sight.emit(area)


func _on_navigation_agent_2d_link_reached(_details):
	next_animation = self.animated_sprite.get_animation()
	self.animated_sprite.play("jump")

func _on_animated_sprite_animation_finished():
	if next_animation:
		animated_sprite.play(next_animation)
		next_animation = null
