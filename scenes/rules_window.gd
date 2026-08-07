extends TextureRect
var winActive: bool
@onready var rule_window: TextureRect = $"../ruleWindow"
@onready var warn_win: TextureRect = $"../warnWin"

func _ready() -> void:
	winActive = false

func _on_info_pressed() -> void:
	if !winActive:
		var tween = create_tween()
		tween.tween_property(rule_window, "position:y", 170, 0.3)
		tween.tween_property(rule_window, "position:y", 200, 0.3)
		winActive = true
	else:
		_on_cross_button_pressed()
		winActive = false


func _on_delete_pressed() -> void:
	if !winActive:
		var tween = create_tween()
		tween.tween_property(warn_win, "position:y", 200, 0.3)
		tween.tween_property(warn_win, "position:y", 170, 0.2)
		winActive = true
	else:
		_on_cross_button_pressed()
		winActive = false

func _on_cross_button_pressed() -> void:
	if winActive == true:
		var tween = create_tween()
		tween.tween_property(warn_win, "position:y", -500, 0.3)
		tween.tween_property(rule_window, "position:y", 890, 0.3)
		winActive=false

func _on_delete_highscore_pressed() -> void:
	_on_cross_button_pressed()
	GameManager.reset_highscore()
