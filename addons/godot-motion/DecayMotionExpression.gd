class_name DecayMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const PREFER_VELOCITY := _DECAY_CLASS.PREFER_VELOCITY
const PREFER_POSITION := _DECAY_CLASS.PREFER_POSITION

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target() -> MotionTarget:
	return _transition_factory.get_target()

func preset(preset_name: StringName) -> DecayMotionExpression:
	_transition_factory.load_preset(preset_name)
	return self

func process(value: int) -> DecayMotionExpression:
	_transition_factory.set_process(value)
	return self

func process_idle() -> DecayMotionExpression:
	return super()

func process_physics() -> DecayMotionExpression:
	return super()

func prefer(value: int) -> DecayMotionExpression:
	_transition_factory.set_prefer(value)
	return self

func prefer_velocity() -> DecayMotionExpression:
	return prefer(PREFER_VELOCITY)

func prefer_position() -> DecayMotionExpression:
	return prefer(PREFER_POSITION)

func power(value: float) -> DecayMotionExpression:
	_transition_factory.set_power(value)
	return self

func time_constant(value: float) -> DecayMotionExpression:
	_transition_factory.set_time_constant(value)
	return self

func rest_delta(value: float) -> DecayMotionExpression:
	_transition_factory.set_rest_delta(value)
	return self

func from(value: Variant) -> DecayMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

func to(value: Variant) -> DecayMotionExpression:
	_transition_factory.set_final_position(value)
	return self

func by(value: Variant) -> DecayMotionExpression:
	_transition_factory.set_initial_velocity(value)
	return self

func wait(cancel: Cancel = null) -> Variant:
	return await _completion.wait(cancel)

#-------------------------------------------------------------------------------

const _DECAY_CLASS := preload("uid://4jaswbuq2e7w")

var _completion: Task
var _transition_factory: _DECAY_CLASS

func _init(
	completion: Task,
	transition_factory: _DECAY_CLASS) -> void:

	assert(is_instance_valid(completion))
	assert(is_instance_valid(transition_factory))

	_completion = completion
	_transition_factory = transition_factory
