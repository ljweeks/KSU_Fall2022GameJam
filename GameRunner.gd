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
var batterySpawnRate = 5
var totalTime = 0

var enemySpawnRateTick = 0
var tick = 0
var batterySpawnTick = 0
var tempPerTick = 1
func _process(delta):
	totalTime += delta
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
		enemySpawnRate -= 0.005
		if(enemySpawnRate < 3.5):
			enemySpawnRate = 3.5
		if(enemySpawnRate > 6):
			enemySpawnRate = 6
	if(overload > 165):
		print("DEAD")
		get_tree().paused = true

	if(enemySpawnRateTick > enemySpawnRate and totalTime > 20):
		spawnEnemy()
		enemySpawnRateTick = 0
	if(batterySpawnTick > batterySpawnRate):
		spawnBattery()
		batterySpawnTick = 0
	if(overload > 70):
		$YSort/Player/Camera2D.addShake(0.04)
	if(overload > 95):
		$YSort/Player/Camera2D.addShake(0.02)
	timeChanges()

func addShake(amount):
	$YSort/Player/Camera2D.addShake(amount)

func timeChanges():
	if totalTime > 240:
		cap = 50
		enemySpawnRate -=0.1
	if totalTime > 180:
		cap = 20
		enemySpawnRate -= 0.05
		return
	if totalTime > 120:
		cap = 15
		enemySpawnRate -=0.025
		return
	if totalTime > 60:
		cap = 10
		return
	

export (int) var totalBattery = 8

func spawnBattery():
	if get_tree().get_nodes_in_group("battery").size() < totalBattery:
		var allBats = []
		for bat in batterySpawnPoints:
			if not bat.bat:
				allBats.append(bat)
		if allBats.size() > 0:
			var battery = load("res://Interactables/PowerObjects/Base/Battery.tscn").instance()
			get_parent().add_child(battery)
			battery.global_position = allBats[rand_range(0, allBats.size())].global_position

export (int) var cap = 8
func spawnEnemy():
	var totalEnemies = get_tree().get_nodes_in_group("Enemy")
	if totalEnemies.size() < cap:
		var enemy = load("res://Enemies/FireFly.tscn").instance()
		get_parent().add_child(enemy)
		enemy.global_position = enemySpawnPoints[rand_range(0, enemySpawnPoints.size())].global_position
