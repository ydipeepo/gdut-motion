class_name Transition extends VBoxContainer

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func create(target: Object, target_property_path: NodePath) -> MotionExpression:
	var expression: MotionExpression
	match %TabContainer.current_tab:
		0:
			#
			# Tween
			#
			expression = Motion \
				.tween(target, target_property_path) \
				.ease(%Tween_Ease.selected) \
				.trans(%Tween_Trans.selected) \
				.duration(%Tween_Duration.value) \
				.process(%Transition_Process.selected) \
				.delay(%Transition_Delay.value)
		1:
			#
			# Bezier
			#
			expression = Motion \
				.bezier(target, target_property_path) \
				.x1(%Bezier_X1.value) \
				.y1(%Bezier_Y1.value) \
				.x2(%Bezier_X2.value) \
				.y2(%Bezier_Y2.value) \
				.duration(%Bezier_Duration.value) \
				.process(%Transition_Process.selected) \
				.delay(%Transition_Delay.value)
		2:
			#
			# Linear
			#
			expression = Motion \
				.linear(target, target_property_path) \
				.duration(%Linear_Duration.value) \
				.process(%Transition_Process.selected) \
				.delay(%Transition_Delay.value)
		3:
			#
			# Steps
			#
			expression = Motion \
				.steps(target, target_property_path) \
				.round(%Steps_Round.selected) \
				.segments(%Steps_Segments.value) \
				.duration(%Steps_Duration.value) \
				.process(%Transition_Process.selected) \
				.delay(%Transition_Delay.value)
		4:
			#
			# Irregular
			#
			expression = Motion \
				.irregular(target, target_property_path) \
				.segments(%Irregular_Segments.value) \
				.intensity(%Irregular_Intensity.value) \
				.duration(%Irregular_Duration.value) \
				.process(%Transition_Process.selected) \
				.delay(%Transition_Delay.value)
		5:
			#
			# Spring
			#
			expression = Motion \
				.spring(target, target_property_path) \
				.stiffness(%Spring_Stiffness.value) \
				.damping(%Spring_Damping.value) \
				.mass(%Spring_Mass.value) \
				.rest_speed(%Spring_RestSpeed.value) \
				.rest_delta(%Spring_RestDelta.value) \
				.limit_overdamping(%Spring_Overdamping.button_pressed) \
				.limit_overshooting(%Spring_Overshooting.button_pressed) \
				.process(%Transition_Process.selected) \
				.delay(%Transition_Delay.value)
		6:
			#
			# Glide
			#
			expression = Motion \
				.glide(target, target_property_path) \
				.power(%Glide_Power.value) \
				.time_constant(%Glide_TimeConstant.value) \
				.rest_delta(%Glide_RestDelta.value) \
				.process(%Transition_Process.selected) \
				.delay(%Transition_Delay.value)
	return expression
