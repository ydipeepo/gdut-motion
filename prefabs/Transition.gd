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
				.process(%Transition_Process.selected)
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
				.process(%Transition_Process.selected)
		2:
			#
			# Linear
			#
			expression = Motion \
				.linear(target, target_property_path) \
				.duration(%Linear_Duration.value) \
				.process(%Transition_Process.selected)
		3:
			#
			# Steps
			#
			expression = Motion \
				.steps(target, target_property_path) \
				.round(%Steps_Round.selected) \
				.segments(%Steps_Segments.value) \
				.duration(%Steps_Duration.value) \
				.process(%Transition_Process.selected)
		4:
			#
			# Random
			#
			expression = Motion \
				.random(target, target_property_path) \
				.segments(%Random_Segments.value) \
				.intensity(%Random_Intensity.value) \
				.duration(%Random_Duration.value) \
				.process(%Transition_Process.selected)
		5:
			#
			# Spring
			#
			expression = Motion \
				.spring(target, target_property_path) \
				.stiffness(%Spring_Stiffness.value) \
				.damping(%Spring_Damping.value) \
				.mass(%Spring_Mass.value) \
				.rest_energy(%Spring_RestEnergy.value) \
				.limit_overdamping(%Spring_Overdamping.button_pressed) \
				.limit_overshooting(%Spring_Overshooting.button_pressed) \
				.process(%Transition_Process.selected)
		6:
			#
			# Decay
			#
			expression = Motion \
				.decay(target, target_property_path) \
				.power(%Decay_Power.value) \
				.time_constant(%Decay_TimeConstant.value) \
				.rest_delta(%Decay_RestDelta.value) \
				.process(%Transition_Process.selected)
	return expression
