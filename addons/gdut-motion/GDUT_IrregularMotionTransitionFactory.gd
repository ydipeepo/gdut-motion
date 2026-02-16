class_name GDUT_IrregularMotionTransitionFactory extends GDUT_PerceivedMotionTransitionFactory

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_name() -> StringName:
	return &"Irregular"

func set_segments(value: int) -> void:
	if value < GDUT_IrregularMotionTransition.MIN_SEGMENTS:
		GDUT_Motion.print_warning(&"BAD_SEGMENTS", get_name(), value)
		value = GDUT_IrregularMotionTransition.MIN_SEGMENTS
	_segments = value

func set_intensity(value: float) -> void:
	if value < GDUT_IrregularMotionTransition.MIN_INTENSITY:
		GDUT_Motion.print_warning(&"BAD_INTENSITY", get_name(), value)
		value = GDUT_IrregularMotionTransition.MIN_INTENSITY
	elif GDUT_IrregularMotionTransition.MAX_INTENSITY < value:
		GDUT_Motion.print_warning(&"BAD_INTENSITY", get_name(), value)
		value = GDUT_IrregularMotionTransition.MAX_INTENSITY
	_intensity = value

func create_transition(completion: Array) -> GDUT_MotionTransition:
	return GDUT_IrregularMotionTransition.new(
		_segments,
		_intensity,
		get_duration(),
		get_initial_position(),
		get_final_position(),
		get_process(),
		completion)

#-------------------------------------------------------------------------------

var _segments := GDUT_IrregularMotionTransition.DEFAULT_SEGMENTS
var _intensity := GDUT_IrregularMotionTransition.DEFAULT_INTENSITY
