class_name GDUT_StepsMotionTransitionFactory extends GDUT_PerceivedMotionTransitionFactory

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_name() -> StringName:
	return &"Steps"

func set_segments(value: int) -> void:
	if value < GDUT_StepsMotionTransition.MIN_SEGMENTS:
<<<<<<< Updated upstream
		GDUT_Motion.print_warning(
			&"BAD_SEGMENTS",
			get_name(),
			value)
=======
		GDUT_Motion.print_warning(&"BAD_SEGMENTS", get_name(), value)
>>>>>>> Stashed changes
		value = GDUT_StepsMotionTransition.MIN_SEGMENTS
	_segments = value

func set_round(value: int) -> void:
	if value not in GDUT_StepsMotionTransition.VALID_ROUND:
<<<<<<< Updated upstream
		GDUT_Motion.print_warning(
			&"BAD_ROUND",
			get_name(),
			value)
=======
		GDUT_Motion.print_warning(&"BAD_ROUND", get_name(), value)
>>>>>>> Stashed changes
		value = GDUT_StepsMotionTransition.DEFAULT_ROUND
	_round = value

func create_transition(completion: Array) -> GDUT_MotionTransition:
	return GDUT_StepsMotionTransition.new(
		_segments,
		_round,
		get_duration(),
		get_initial_position(),
		get_final_position(),
		get_process(),
		completion)

#-------------------------------------------------------------------------------

var _segments := GDUT_StepsMotionTransition.DEFAULT_SEGMENTS
var _round := GDUT_StepsMotionTransition.DEFAULT_ROUND
