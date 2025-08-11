extends Effect


static func get_id() -> String:
	return "dragon_punch"


func apply(player_index: int) -> void:
	var effects = RunData.get_player_effects(player_index)
	effects[key] = value


func unapply(player_index: int) -> void :
	var effects = RunData.get_player_effects(player_index)
	effects[key] = null


func get_text(player_index: int, colored: bool = true) -> String:
	var effects = RunData.get_player_effects(player_index)
	
	var key_text = key.to_upper() if text_key.length() == 0 else text_key
	var args = ["8 Random Stat", str(value) + "%", "8 Random Stat", str(value) + "%"]
	var signs = [Sign.POSITIVE, Sign.POSITIVE, Sign.NEGATIVE, Sign.NEGATIVE]

	return Text.text(key_text, args, [] if !colored else signs)
