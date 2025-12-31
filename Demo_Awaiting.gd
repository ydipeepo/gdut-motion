extends Control

func _on_button_tween_pressed() -> void:
	%Button_Tween.disabled = true
	%Button_Bezier.disabled = true
	var final_velocity: Array[float] = await Motion \
		.tween_property(%Icon, "position") \
		.trans_elastic() \
		.to(Vector2(
			randf() * (%Panel.size.x - %Icon.size.x),
			randf() * (%Panel.size.y - %Icon.size.y))) \
		.wait()
	%Button_Tween.text = "Final velocity: " + str(final_velocity)
	%Button_Tween.disabled = false
	%Button_Bezier.disabled = false

func _on_button_bezier_pressed() -> void:
	%Button_Tween.disabled = true
	%Button_Bezier.disabled = true
	var final_velocity: Array[float] = await Motion \
		.bezier_property(%Icon, "position") \
		.to(Vector2(
			randf() * (%Panel.size.x - %Icon.size.x),
			randf() * (%Panel.size.y - %Icon.size.y))) \
		.wait()
	%Button_Bezier.text = "Final velocity: " + str(final_velocity)
	%Button_Tween.disabled = false
	%Button_Bezier.disabled = false
