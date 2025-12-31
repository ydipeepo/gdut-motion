extends Control

func _on_button_start_pressed() -> void:
	var x := randf() * float(%Panel.size.x - %Icon_2.size.x)
	await Task.wait_all_v([
		Motion.spring(%Icon_1, "position:x").delay(0.0).to(x),
		Motion.spring(%Icon_2, "position:x").delay(0.1).to(x),
		Motion.spring(%Icon_3, "position:x").delay(0.2).to(x),
	])
