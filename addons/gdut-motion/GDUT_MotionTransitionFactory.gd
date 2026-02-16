@abstract
class_name GDUT_MotionTransitionFactory

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target() -> GDUT_MotionTarget:
	return _target

@abstract
func get_name() -> StringName

func set_process(value: int) -> void:
	if value not in GDUT_MotionTransition.VALID_PROCESS:
		GDUT_Motion.print_warning(&"BAD_PROCESS", get_name(), value)
		value = GDUT_MotionTransition.PROCESS_IDLE
	_process = value

func get_process() -> int:
	return _process

func set_delay(value: float) -> void:
	if value < 0.0:
		GDUT_Motion.print_warning(&"BAD_DELAY", get_name(), value)
		value = 0.0
	_delay = value

func load_preset(preset_name: StringName) -> void:
	if \
		not preset_name.is_empty() and \
		not MotionPresetBank.apply_preset(preset_name, self):

		GDUT_Motion.print_warning(&"PRESET_NOT_FOUND", preset_name)

@abstract
func create_transition(completion: Array) -> GDUT_MotionTransition

func create(
	completion: Array,
	transition_before: GDUT_MotionTransition = null) -> GDUT_MotionTransition:

	var transition := create_transition(completion)
	if 0.0 < _delay:
		transition = GDUT_DelayMotionTransition.new(
			transition,
			_delay)
	if transition_before != null:
		transition = GDUT_ChainMotionTransition.new(
			transition_before,
			transition)
	return transition

#-------------------------------------------------------------------------------

var _target: GDUT_MotionTarget
var _process := GDUT_MotionTransition.DEFAULT_PROCESS
var _delay: float

func _init(target: GDUT_MotionTarget) -> void:
	assert(target != null)

	_target = target
