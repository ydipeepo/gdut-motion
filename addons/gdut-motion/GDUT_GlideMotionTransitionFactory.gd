class_name GDUT_GlideMotionTransitionFactory extends GDUT_PhysicsMotionTransitionFactory

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_name() -> StringName:
	return &"Glide"

func set_power(value: float) -> void:
	if value < GDUT_GlideMotionTransition.MIN_POWER:
<<<<<<< Updated upstream
		GDUT_Motion.print_warning(
			&"BAD_POWER",
			get_name(),
			value)
=======
		GDUT_Motion.print_warning(&"BAD_POWER", get_name(), value)
>>>>>>> Stashed changes
		value = GDUT_GlideMotionTransition.MIN_POWER
	_power = value

func set_time_constant(value: float) -> void:
	if value < GDUT_GlideMotionTransition.MIN_TIME_CONSTANT:
<<<<<<< Updated upstream
		GDUT_Motion.print_warning(
			&"BAD_TIME_CONSTANT",
			get_name(),
			value)
=======
		GDUT_Motion.print_warning(&"BAD_TIME_CONSTANT", get_name(), value)
>>>>>>> Stashed changes
		value = GDUT_GlideMotionTransition.MIN_TIME_CONSTANT
	_time_constant = value

func set_rest_delta(value: float) -> void:
	if value < GDUT_GlideMotionTransition.MIN_REST_DELTA:
<<<<<<< Updated upstream
		GDUT_Motion.print_warning(
			&"BAD_REST_DELTA",
			get_name(),
			value)
=======
		GDUT_Motion.print_warning(&"BAD_REST_DELTA", get_name(), value)
>>>>>>> Stashed changes
		value = GDUT_GlideMotionTransition.MIN_REST_DELTA
	_rest_delta = value

func create_transition(completion: Array) -> GDUT_MotionTransition:
	return GDUT_GlideMotionTransition.new(
		_power,
		_time_constant,
		_rest_delta,
		get_initial_position(),
		get_final_position(),
		get_initial_velocity(),
		get_process(),
		completion)

#-------------------------------------------------------------------------------

var _power := GDUT_GlideMotionTransition.DEFAULT_POWER
var _time_constant := GDUT_GlideMotionTransition.DEFAULT_TIME_CONSTANT
var _rest_delta := GDUT_GlideMotionTransition.DEFAULT_REST_DELTA
