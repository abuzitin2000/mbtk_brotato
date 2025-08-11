extends Effect


static func get_id() -> String:
	return "random_stats"


func apply(player_index: int) -> void:
	var effects = RunData.get_player_effects(player_index)
	if effects.has(key) == false:
		effects[key] = true
		
		var rng_stats = Utils.brotils_get_primary_stat_keys().duplicate()
		rng_stats.shuffle()
		
		var rng_positives = rng_stats.slice(0, 8)
		var rng_negatives = rng_stats.slice(8, 15)
		
		for rng_stat in rng_positives:
			effects["gain_" + rng_stat] += value
		
		for rng_stat in rng_negatives:
			effects["gain_" + rng_stat] -= value
	
	Utils.reset_stat_cache(player_index)


func get_text(player_index: int, colored: bool = true) -> String:
	var effects = RunData.get_player_effects(player_index)
	
	if effects["gain_" + "stat_max_hp"] != 0:
		var rng_text = "{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7} modifications are increased by {8}\n{9}, {10}, {11}, {12}, {13}, {14}, {15} modifications are reduced by {16}"
		
		var rng_stats = Utils.brotils_get_primary_stat_keys().duplicate()
		var rng_positives = []
		var rng_negatives = []
		var args = []
		
		for rng_stat in rng_stats:
			if effects["gain_" + rng_stat] > 0:
				rng_positives.append(rng_stat)
			if effects["gain_" + rng_stat] < 0:
				rng_negatives.append(rng_stat)
		
		for rng_stat in rng_positives:
			args.append(get_stat_name_text(rng_stat))
		
		args.append(str(value) + "%")
		
		for rng_stat in rng_negatives:
			args.append(get_stat_name_text(rng_stat))
		
		args.append(str(value) + "%")
		
		var signs = []
		for _i in range(9):
			signs.append(Sign.POSITIVE)
		for _i in range(9):
			signs.append(Sign.NEGATIVE)
		
		return Text.text(rng_text, args, signs)
	
	var key_text = key.to_upper() if text_key.length() == 0 else text_key
	var args = ["8 Random Stat", str(value) + "%", "8 Random Stat", str(value) + "%"]
	var signs = [Sign.POSITIVE, Sign.POSITIVE, Sign.NEGATIVE, Sign.NEGATIVE]

	return Text.text(key_text, args, [] if !colored else signs)

func get_stat_name_text(stat_name: String) -> String:
	if stat_name == "stat_max_hp":
		return "Max HP"
	elif stat_name == "stat_hp_regeneration":
		return "HP Regeneration"
	elif stat_name == "stat_lifesteal":
		return "Life Steal"
	elif stat_name == "stat_percent_damage":
		return "Damage"
	elif stat_name == "stat_melee_damage":
		return "Melee Damage"
	elif stat_name == "stat_ranged_damage":
		return "Ranged Damage"
	elif stat_name == "stat_elemental_damage":
		return "Elemental Damage"
	elif stat_name == "stat_attack_speed":
		return "Attack Speed"
	elif stat_name == "stat_crit_chance":
		return "Crit Chance"
	elif stat_name == "stat_engineering":
		return "Engineering"
	elif stat_name == "stat_range":
		return "Range"
	elif stat_name == "stat_armor":
		return "Armor"
	elif stat_name == "stat_dodge":
		return "Dodge"
	elif stat_name == "stat_speed":
		return "Speed"
	elif stat_name == "stat_luck":
		return "Luck"
	elif stat_name == "stat_harvesting":
		return "Harvesting"
	else:
		return "?"
