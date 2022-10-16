extends Node2D

onready var overload = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var maxTemp = 175
var enemySpawnPoints
var batterySpawnPoints
# Called when the node enters the scene tree for the first time.
func _ready():
	enemySpawnPoints = get_tree().get_nodes_in_group("EnemySpawn")
	batterySpawnPoints = get_tree().get_nodes_in_group("BatterySpawn")
	# OS.window_fullscreen = true

# how often things happen
var tickRate = 0.5
var enemySpawnRate = 5.4
var batterySpawnRate = 10

var enemySpawnRateTick = 0
var tick = 0
var batterySpawnTick = 0
var tempPerTick = 1
func _process(delta):
	
	tick += delta
	enemySpawnRateTick += delta
	batterySpawnTick += delta
	
	if(tick > tickRate):
		overload += tempPerTick
		if(overload > 60):
			enemySpawnRate += 0.1
		if(overload > maxTemp):
			overload = maxTemp
		elif(overload < 0):
			overload = 0
		tick = 0
		enemySpawnRate -= 0.0075
		if(enemySpawnRate < 3.5):
			enemySpawnRate = 4
		if(enemySpawnRate > 6):
			enemySpawnRate = 5.5
	if(overload > 165):
		print("DEAD")
		get_tree().paused = true

	if(enemySpawnRateTick > enemySpawnRate):
		spawnEnemy()
		enemySpawnRateTick = 0
		
	if(batterySpawnTick > batterySpawnRate):
		spawnBattery()
		batterySpawnTick = 0
		
export (int) var totalBattery = 5
func spawnBattery():
	if get_tree().get_nodes_in_group("battery").size() < totalBattery:
		var battery = load("res://Interactables/PowerObjects/Base/Battery.tscn").instance()
		get_parent().add_child(battery)
		battery.global_position = batterySpawnPoints[rand_range(0, batterySpawnPoints.size())].global_position

func spawnEnemy():
	var enemy = load("res://Enemies/FireFly.tscn").instance()
	get_parent().add_child(enemy)
	enemy.global_position = enemySpawnPoints[rand_range(0, enemySpawnPoints.size())].global_position
