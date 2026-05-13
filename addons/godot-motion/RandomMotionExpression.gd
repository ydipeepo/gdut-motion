class_name RandomMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target() -> MotionTarget:
	return _transition_factory.get_target()

func preset(preset_name: StringName) -> RandomMotionExpression:
	_transition_factory.load_preset(preset_name)
	return self

func process(value: int) -> RandomMotionExpression:
	_transition_factory.set_process(value)
	return self

func process_idle() -> RandomMotionExpression:
	return super()

func process_physics() -> RandomMotionExpression:
	return super()

func duration(value: float) -> RandomMotionExpression:
	_transition_factory.set_duration(value)
	return self

func delay(value: float) -> RandomMotionExpression:
	_transition_factory.set_delay(value)
	return self

func loop(value: int) -> RandomMotionExpression:
	_transition_factory.set_loop(value)
	return self

func loop_delay(value: float) -> RandomMotionExpression:
	_transition_factory.set_loop_delay(value)
	return self

func alternate(value: bool) -> RandomMotionExpression:
	_transition_factory.set_alternate(value)
	return self

func reversed(value: bool) -> RandomMotionExpression:
	_transition_factory.set_reversed(value)
	return self

func from(value: Variant) -> RandomMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

func to(value: Variant) -> RandomMotionExpression:
	_transition_factory.set_final_position(value)
	return self

func segments(value: int) -> RandomMotionExpression:
	_transition_factory.set_segments(value)
	return self

func intensity(value: float) -> RandomMotionExpression:
	_transition_factory.set_intensity(value)
	return self

func wait(cancel: Cancel = null) -> Variant:
	return await _completion.wait(cancel)

#-------------------------------------------------------------------------------

const _RANDOM_CLASS := preload("uid://cp8mkaedusky0")

var _completion: Task
var _transition_factory: _RANDOM_CLASS

func _init(
	completion: Task,
	transition_factory: _RANDOM_CLASS) -> void:

	assert(is_instance_valid(completion))
	assert(is_instance_valid(transition_factory))

	_completion = completion
	_transition_factory = transition_factory
