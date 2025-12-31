@abstract
class_name GDUT_PerceivedMotionTransitionFactory extends GDUT_MotionTransitionFactory

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func set_duration(value: float) -> void:
	if value < GDUT_PerceivedMotionTransition.MIN_DURATION:
		GDUT_Motion.print_warning(
			&"BAD_DURATION",
			get_name(),
			value)
		value = GDUT_PerceivedMotionTransition.MIN_DURATION
	_duration = value

func get_duration() -> float:
	return _duration

func set_initial_position(value: Variant) -> void:
	if not GDUT_Motion.validate_incoming_position(get_proxy(), value):
		GDUT_Motion.print_warning(
			&"BAD_INITIAL_POSITION",
			get_name(),
			value)
		value = null
	_initial_position = value

func get_initial_position() -> Variant:
	return _initial_position

func set_final_position(value: Variant) -> void:
	if not GDUT_Motion.validate_incoming_position(get_proxy(), value):
		GDUT_Motion.print_warning(
			&"BAD_FINAL_POSITION",
			get_name(),
			value)
		value = null
	_final_position = value

func get_final_position() -> Variant:
	return _final_position

#-------------------------------------------------------------------------------

var _duration := GDUT_PerceivedMotionTransition.DEFAULT_DURATION
var _initial_position: Variant
var _final_position: Variant
