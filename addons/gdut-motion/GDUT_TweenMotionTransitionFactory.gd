class_name GDUT_TweenMotionTransitionFactory extends GDUT_PerceivedMotionTransitionFactory

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_name() -> StringName:
	return &"Tween"

func set_ease(value: int) -> void:
	if value not in GDUT_TweenMotionTransition.VALID_EASE:
		GDUT_Motion.print_warning(
			&"BAD_EASE",
			get_name(),
			value)
		value = GDUT_TweenMotionTransition.DEFAULT_EASE
	_ease = value

func set_trans(value: int) -> void:
	if value not in GDUT_TweenMotionTransition.VALID_TRANS:
		GDUT_Motion.print_warning(
			&"BAD_TRANS",
			get_name(),
			value)
		value = GDUT_TweenMotionTransition.DEFAULT_TRANS
	_trans = value

func create_transition(completion: Array) -> GDUT_MotionTransition:
	return GDUT_TweenMotionTransition.new(
		_ease,
		_trans,
		get_duration(),
		get_initial_position(),
		get_final_position(),
		get_process(),
		completion)

#-------------------------------------------------------------------------------

var _ease := GDUT_TweenMotionTransition.DEFAULT_EASE
var _trans := GDUT_TweenMotionTransition.DEFAULT_TRANS
