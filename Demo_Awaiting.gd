extends Control

func _on_button_tween_pressed() -> void:
	%Button_Tween.disabled = true
	%Button_Bezier.disabled = true

	#
	# You can use "await" and ".wait()" to wait until the transition finishes:
	#

	%Button_Tween.text = "Animating..."

	await Motion \
		.tween(%Icon, "position") \
		.trans_elastic() \
		.to(Vector2(
			randf() * (%Panel.size.x - %Icon.size.x),
			randf() * (%Panel.size.y - %Icon.size.y))) \
		.wait()

	%Button_Tween.text = "Call Motion.tween"

	%Button_Tween.disabled = false
	%Button_Bezier.disabled = false

func _on_button_bezier_pressed() -> void:
	%Button_Tween.disabled = true
	%Button_Bezier.disabled = true

	var t1 := Motion \
		.bezier(%Icon, "position") \
		.to([
			randf() * (%Panel.size.x - %Icon.size.x),
			randf() * (%Panel.size.y - %Icon.size.y),
		])

	var t2 := t1 \
		.then_spring() \
		.rest_speed(1.0) \
		.to([
			randf() * (%Panel.size.x - %Icon.size.x),
			randf() * (%Panel.size.y - %Icon.size.y),
		])

	#
	# The return value of ".wait()" will be the final velocity.
	#

	var v_final: Variant

	v_final = await t1.wait()
	%Button_Bezier.text = "V_final = " + str(v_final)

	v_final = await t2.wait()
	%Button_Bezier.text = "V_final = " + str(v_final)

	%Button_Tween.disabled = false
	%Button_Bezier.disabled = false
