extends Control

func _on_button_start_storyboard_pressed() -> void:
	Motion \
		.tween_property(%Icon, "position") \
			.ease_out() \
			.trans_quint() \
			.duration(1.0) \
			.to(Vector2(
				randf() * (%Panel.size.x - %Icon.size.x),
				randf() * (%Panel.size.y - %Icon.size.y))) \
		.then_spring() \
			.rest_delta(1.0) \
			.mass(10.0) \
			.to(Vector2(
				randf() * (%Panel.size.x - %Icon.size.x),
				randf() * (%Panel.size.y - %Icon.size.y)))
