extends Sprite2D
@onready var checktag = get_children()
@onready var speeed = GameManager.speed
@export var is_good :bool
func _process(delta: float) -> void:
	position.y += speeed * delta
	if !GameManager.gameEnded:
		_fallManager()
	
func _fallManager():
	if position.y > 800:
		if is_good:
			if GameManager.score > 0:
				queue_free()
				GameManager.dec_score(1)
		else:
			queue_free()
			
			
func checkClicks():
	if !is_good:
		GameManager.game_over()
		queue_free()
	else:
		GameManager.add_score(1)
		queue_free()
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	# Checks if the input is either a mouse click or a touch tap
	if event is InputEventMouseButton or event is InputEventScreenTouch:
		if event.pressed:
			checkClicks()
		
