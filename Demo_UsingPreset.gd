extends Control

func _on_button_start_preset_pressed() -> void:
	Motion \
		.tween_property(%Icon, "position") \
		.preset(&"random") \
		.to(Vector2(
			randf() * (%Panel.size.x - %Icon.size.x),
			randf() * (%Panel.size.y - %Icon.size.y)))
	
