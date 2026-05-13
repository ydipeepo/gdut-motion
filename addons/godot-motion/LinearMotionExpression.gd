class_name LinearMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target() -> MotionTarget:
	return _transition_factory.get_target()

func preset(preset_name: StringName) -> LinearMotionExpression:
	_transition_factory.load_preset(preset_name)
	return self

func process(value: int) -> LinearMotionExpression:
	_transition_factory.set_process(value)
	return self

func process_idle() -> LinearMotionExpression:
	return super()

func process_physics() -> LinearMotionExpression:
	return super()

func duration(value: float) -> LinearMotionExpression:
	_transition_factory.set_duration(value)
	return self

func delay(value: float) -> LinearMotionExpression:
	_transition_factory.set_delay(value)
	return self

func loop(value: int) -> LinearMotionExpression:
	_transition_factory.set_loop(value)
	return self

func loop_delay(value: float) -> LinearMotionExpression:
	_transition_factory.set_loop_delay(value)
	return self

func alternate(value: bool) -> LinearMotionExpression:
	_transition_factory.set_alternate(value)
	return self

func reversed(value: bool) -> LinearMotionExpression:
	_transition_factory.set_reversed(value)
	return self

func from(value: Variant) -> LinearMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

func to(value: Variant) -> LinearMotionExpression:
	_transition_factory.set_final_position(value)
	return self

func y_array(y_array: Array[float]) -> LinearMotionExpression:
	_transition_factory.set_y_array(y_array)
	return self

func y(y: float) -> LinearMotionExpression:
	_transition_factory.add_y(y)
	return self

func wait(cancel: Cancel = null) -> Variant:
	return await _completion.wait(cancel)

#-------------------------------------------------------------------------------

const _LINEAR_CLASS := preload("uid://cbnayo3750njw")

var _completion: Task
var _transition_factory: _LINEAR_CLASS

func _init(
	completion: Task,
	transition_factory: _LINEAR_CLASS) -> void:

	assert(is_instance_valid(completion))
	assert(is_instance_valid(transition_factory))

	_completion = completion
	_transition_factory = transition_factory
