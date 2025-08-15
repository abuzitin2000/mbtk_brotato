extends Effect


static func get_id() -> String:
	return "cable"


func apply(player_index: int) -> void:
	var effects = RunData.get_player_effects(player_index)
	effects[key] = value


func unapply(player_index: int) -> void :
	var effects = RunData.get_player_effects(player_index)
	effects[key] = null


func get_text(player_index: int, colored: bool = true) -> String:
	var effects = RunData.get_player_effects(player_index)
	
	var key_text = key.to_upper() if text_key.length() == 0 else text_key
	var args = []
	var signs = []

	return Text.text(key_text, args, [] if !colored else signs)
