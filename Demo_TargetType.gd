extends Control

func _on_button_animate_property_pressed() -> void:
	#
	# To animate property, please do the following:
	#

	Motion \
		.spring(%Icon, "position") \
		.to([
			randf() * (%Panel.size.x - %Icon.size.x),
			randf() * (%Panel.size.y - %Icon.size.y),
		])

	#
	# It supports following types as target property:
	#
	# - float,
	# - int,
	# - Packed*Array,
	# - Basis,
	# - Transform2D,
	# - Transform3D,
	# - Color,
	# - Vector2/3/4i and
	# - Vector2/3/4.
	#
	# If no type annotation is provided, you must supply a type hint as follows:
	#
	# Motion.tween(%Icon, "position", TYPE_VECTOR2)
	#                                 ^^^^^^^^^^^^

func _on_button_animate_method_1_pressed() -> void:
	#
	# To animate method, please do the following:
	#

	var w := randf()
	Motion \
		.spring(%Icon, "set_scale") \
		.from(%Icon.scale) \
		.to([
			lerpf(0.5, 3.0, w),
			lerpf(0.5, 3.0, w),
		])

	#
	# If no type annotation is provided, you must supply a type hint as follows:
	#
	# Motion.tween(self, "_set_scale", TYPE_VECTOR2)
	#                                  ^^^^^^^^^^^^
	# ".from" can be omitted, but it is specified to inherit the current value.
	#

func _on_button_animate_method_2_pressed() -> void:
	#
	# Callables can also be animated:
	#

	@warning_ignore("shadowed_variable_base_class")
	Motion \
		.spring(%Icon.set_rotation) \
		#.spring(
		#	func (rotation: float) -> void:
		#		%Icon.rotation_degrees = rotation,
		#	TYPE_FLOAT) \
		.from(%Icon.rotation) \
		.to(randf_range(-PI, PI))

	#
	# ".from" can be omitted, but it is specified to
	# inherit the current value.
	#
	# If no type annotation is provided,
	# you must supply a type hint as follows:
	#
	# Motion.tween(_set_scale, TYPE_FLOAT)
	#                          ^^^^^^^^^^
	# When animating a lambda defined on the spot,
	# duplicates are not eliminated.
	# Because different instances cannot be determined to be identical.
	#
