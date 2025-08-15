extends Node2D


onready var _hitbox: Area2D = $"%Hitbox"

var firstArea: Area2D
var secondArea: Area2D

var connected: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if firstArea.get_parent().dead or secondArea.get_parent().dead:
		firstArea.cabling = false
		secondArea.cabling = false
		firstArea.completedCables.erase(self)
		secondArea.completedCables.erase(self)
		self.queue_free()
	
	var startPosition = firstArea.global_position
	var endPosition = secondArea.global_position
	var mid_point = (startPosition + endPosition) / 2
	var distance = startPosition.distance_to(endPosition)
	var angle = (endPosition - startPosition).angle()

	global_position = mid_point
	rotation = angle
	scale.x = distance / 240


func readyHitbox(_player_index: int, damage: int):
	# Setup Hitbox Properties
	_hitbox.damage = damage
	_hitbox.crit_damage = 2
	_hitbox.crit_chance = RunData.get_stat("stat_crit_chance", _player_index) / 100
	_hitbox.from = self
