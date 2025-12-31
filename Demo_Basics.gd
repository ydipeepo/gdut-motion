extends Control

func _on_button_spring_pressed() -> void:
	Motion \
		.spring_property(%Icon, "position") \
		.to(Vector2(
			randf() * (%Panel.size.x - %Icon.size.x),
			randf() * (%Panel.size.y - %Icon.size.y)))

func _on_button_glide_pressed() -> void:
	Motion \
		.glide_property(%Icon, "position") \
		.power(0.25) \
		.time_constant(0.25)

func _on_button_tween_pressed() -> void:
	Motion \
		.tween_property(%Icon, "position") \
		.trans_elastic() \
		.duration(2.0) \
		.to(Vector2(
			randf() * (%Panel.size.x - %Icon.size.x),
			randf() * (%Panel.size.y - %Icon.size.y)))

func _on_button_bezier_pressed() -> void:
	Motion \
		.bezier_property(%Icon, "position") \
		.duration(2.0) \
		.to(Vector2(
			randf() * (%Panel.size.x - %Icon.size.x),
			randf() * (%Panel.size.y - %Icon.size.y)))
