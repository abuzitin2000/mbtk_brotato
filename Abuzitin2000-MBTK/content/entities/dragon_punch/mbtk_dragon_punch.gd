extends Node

onready var _hitbox: Area2D = $"%Hitbox"
onready var _sprite: Sprite = $"%Sprite"

var _player_index: = -1
var _knockback_direction: Vector2

func _ready():
	# Calculate Damage
	var damage = 10
	damage *= 1 + RunData.get_player_level(_player_index)
	damage += RunData.get_stat("stat_melee_damage", _player_index)
	damage *= RunData.get_stat("stat_percent_damage", _player_index) / 100
	
	# Setup Hitbox Properties
	_hitbox.damage = damage
	_hitbox.crit_damage = 2
	_hitbox.crit_chance = RunData.get_stat("stat_crit_chance", _player_index)
	_hitbox.knockback_direction = _knockback_direction
	_hitbox.knockback_amount = 40
	_hitbox.from = self
	
	# Setup Sprite
	_sprite.rotation = _knockback_direction.angle()


func setup_dragon_punch(player_index: int, knockback_direction: Vector2):
	_player_index = player_index
	_knockback_direction = knockback_direction


func _on_Timer_timeout():
	call_deferred("queue_free")


func _process(delta):
	# Fade Sprite
	if _sprite.modulate.a > 0.0:
		_sprite.modulate.a -= 1.5 * delta
