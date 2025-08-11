extends "res://entities/units/player/player.gd"

var dragon_punch_scene = preload("res://mods-unpacked/Abuzitin2000-MBTK/content/entities/dragon_punch/mbtk_dragon_punch.tscn")

func take_damage(value: int, args: TakeDamageArgs) -> Array:
	var returnValue = .take_damage(value, args)
	
	if dead:
		return returnValue
	
	var effects = RunData.get_player_effects(player_index)
	
	if effects.has("mbtk_dragon_punch"):
		var knockbackDirection = Vector2(args.hitbox.from.position - position).normalized()
		knockback_vector = knockbackDirection * 20
		
		var dragon_punch_instance = dragon_punch_scene.instance()
		dragon_punch_instance.setup_dragon_punch(player_index, knockbackDirection)
		call_deferred("add_child", dragon_punch_instance)
	
	return returnValue
