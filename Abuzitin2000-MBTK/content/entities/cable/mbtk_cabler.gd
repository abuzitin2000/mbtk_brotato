extends Node


var cable_scene = preload("res://mods-unpacked/Abuzitin2000-MBTK/content/entities/cable/mbtk_cable.tscn")

var isPlayer: bool = false
var cabling: bool = false

var currentCable: Node2D
var completedCables: Array

var _player_index: int

func _on_mbtk_cabler_area_entered(area: Area2D) -> void :
	if area.name != "mbtk_cabler":
		return
	
	if not isPlayer:
		return
	
	if area.isPlayer:
		return
	
	if cabling:
		stop_cabling(area)
	else:
		start_cabling(area)
	


func start_cabling(turret: Area2D) -> void :
	if turret.cabling:
		return
	
	if turret.completedCables.size() > 0:
		var cable = turret.completedCables[turret.completedCables.size() - 1]
		var firstTurret = cable.firstArea
		var secondTurret = cable.secondArea
		
		firstTurret.completedCables.erase(cable)
		secondTurret.completedCables.erase(cable)
		
		cable.queue_free()
		turret = firstTurret if turret == secondTurret else secondTurret
	
	cabling = true
	turret.cabling = true
	
	var cable_instance = cable_scene.instance()
	cable_instance.firstArea = self
	cable_instance.secondArea = turret
	self.call_deferred("add_child", cable_instance)
	
	currentCable = cable_instance


func stop_cabling(turret: Area2D) -> void :
	if turret.cabling:
		if turret == currentCable.secondArea:
			cabling = false
			turret.cabling = false
			currentCable.queue_free()
		
		return
	
	currentCable.firstArea = turret
	currentCable.connected = true
	
	currentCable.firstArea.cabling = false
	currentCable.secondArea.cabling = false
	currentCable.firstArea.completedCables.append(currentCable)
	currentCable.secondArea.completedCables.append(currentCable)
	
	# Calculate Damage
	var damage = 0
	damage += currentCable.firstArea.get_parent().stats.damage
	damage += currentCable.secondArea.get_parent().stats.damage
	damage /= 2
	
	currentCable.readyHitbox(_player_index, damage)
	
	cabling = false
	currentCable = null

