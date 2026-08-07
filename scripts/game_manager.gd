extends Node

var speed: int
var score: int
var highscore: int = 0 # Holds the session highscore
var goodDestroyed: int
var gameEnded: bool
const SPEED_INCREMENT: int = 50

# Path where Godot will securely save the highscore file on the player's device
const SAVE_PATH = "user://savegame.cfg"

func _ready() -> void:
	load_highscore() # Load the saved highscore when the game starts up
	reset_game_state()

func reset_game_state() -> void:
	GameManager.speed = 980
	GameManager.score = 0
	GameManager.goodDestroyed = 0
	GameManager.gameEnded = false

func _gameOverMenu():
	var active_scene = get_tree().current_scene
	var game_over_win = active_scene.find_child("GameOver", true, false)
	if game_over_win:
		var tween = create_tween()
		tween.tween_property(game_over_win, "position:y", -330, 0.5) 
		tween.tween_property(game_over_win, "position:y", -310, 0.1) 

func add_score(amount: int):
	var old_score = score
	score += amount
	
	# Check and update highscore in real-time
	if score > highscore:
		highscore = score
		
	if (score / 10) > (old_score / 10):
		speed += SPEED_INCREMENT
		
func dec_score(lostCount: int):
	goodDestroyed += lostCount
	if goodDestroyed >= 5:
		add_score(-1)
		goodDestroyed = 0
	
func game_over():
	speed = 0
	gameEnded = true
	save_highscore() # Save the highscore to disk as soon as the game ends
	_gameOverMenu()

func _on_button_pressed() -> void:
	restartGame()
	
func restartGame():
	if get_tree().current_scene.scene_file_path == "res://scenes/maingame.tscn":
		reset_game_state()
		get_tree().reload_current_scene()
	
func _on_exit_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/home screen.tscn")

func _on_play_button_pressed() -> void:
	reset_game_state()
	get_tree().change_scene_to_file("res://scenes/maingame.tscn")

# --- SAVE & LOAD SYSTEM ---

func save_highscore():
	var config = ConfigFile.new()
	# Store the value under a section called "Player" and key "highscore"
	config.set_value("Player", "highscore", highscore)
	config.save(SAVE_PATH)

func load_highscore():
	var config = ConfigFile.new()
	# Load the file, if it returns OK (0), read the value. Otherwise, default to 0.
	if config.load(SAVE_PATH) == OK:
		highscore = config.get_value("Player", "highscore", 0)
		
func reset_highscore():
	highscore = 0
	save_highscore()
