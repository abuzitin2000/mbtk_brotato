class_name MBTKPlayerEffectBehavior
extends PlayerEffectBehavior


var cabler_scene = preload("res://mods-unpacked/Abuzitin2000-MBTK/content/entities/cable/mbtk_cabler.tscn")

func init(parent: Player) -> PlayerEffectBehavior:
	_parent = parent
	_player_index = _parent.player_index
	
	var effects = RunData.get_player_effects(_player_index)
	
	if effects.has("mbtk_cable"):
		var cabler_instance = cabler_scene.instance()
		cabler_instance.isPlayer = true
		cabler_instance._player_index = _player_index
		_parent.call_deferred("add_child", cabler_instance)
	
	return self
