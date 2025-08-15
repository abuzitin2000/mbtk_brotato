extends "res://entities/structures/turret/turret.gd"


var cabler_scene = preload("res://mods-unpacked/Abuzitin2000-MBTK/content/entities/cable/mbtk_cabler.tscn")

func set_data(data: Resource) -> void :
	.set_data(data)
	
	for i in RunData.get_player_count():
		var effects = RunData.get_player_effects(i)
		
		if effects.has("mbtk_cable"):
			var cabler_instance = cabler_scene.instance()
			self.call_deferred("add_child", cabler_instance)
			break
