extends Control

func _on_button_start_tween_preset_pressed() -> void:
	Motion \
		.tween(%Icon, ^"position") \
		.preset(&"random") \
		.to(Vector2(
			randf() * (%Panel.size.x - %Icon.size.x),
			randf() * (%Panel.size.y - %Icon.size.y)))

func _on_button_start_easing_preset_pressed() -> void:
	Motion \
		.easing(%Icon, ^"position") \
		.preset(&"random") \
		.to(Vector2(
			randf() * (%Panel.size.x - %Icon.size.x),
			randf() * (%Panel.size.y - %Icon.size.y)))
