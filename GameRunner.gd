extends Node2D

onready var overload = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var maxTemp = 150
var enemySpawnPoints

# Called when the node enters the scene tree for the first time.
func _ready():
	enemySpawnPoints = get_tree().get_nodes_in_group("EnemySpawn")



# how often things happen
var tickRate = 1
var enemySpawnRate = 5
var batterySpawnRate = 10

var enemySpawnRateTick = 0
var tick = 0
var batterySpawnTick = 0

func _process(delta):
	
	tick += delta
	enemySpawnRateTick += delta
	batterySpawnTick += delta
	
	if(tick > tickRate):
		overload += 1
		if(overload > maxTemp):
			overload = maxTemp
		elif(overload < 0):
			overload = 0
		tick = 0

	if(enemySpawnRateTick > enemySpawnRate):
		spawnEnemy()
		enemySpawnRateTick = 0
		
	if(batterySpawnTick > batterySpawnRate):
		spawnBattery()
		batterySpawnTick = 0

func spawnBattery():
	var battery = load("res://Interactables/PowerObjects/Base/Battery.tscn").instance()
	get_parent().add_child(battery)
		
func spawnEnemy():
	var enemy = load("res://Enemies/FireFly.tscn").instance()
	get_parent().add_child(enemy)
	#enemy.global_position = enemySpawnPoints[rand_range(0, enemySpawnPoints.size())].global_position
