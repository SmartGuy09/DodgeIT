extends Label


func _ready() -> void:
	add_theme_constant_override("spacing_glyph", 5)
	
func _process(delta: float) -> void:
	text = "%d" % GameManager.highscore
