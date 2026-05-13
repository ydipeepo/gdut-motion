class_name EasingMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target() -> MotionTarget:
	return _transition_factory.get_target()

func preset(preset_name: StringName) -> EasingMotionExpression:
	_transition_factory.load_preset(preset_name)
	return self

func process(value: int) -> EasingMotionExpression:
	_transition_factory.set_process(value)
	return self

func process_idle() -> EasingMotionExpression:
	return super()

func process_physics() -> EasingMotionExpression:
	return super()

func duration(value: float) -> EasingMotionExpression:
	_transition_factory.set_duration(value)
	return self

func delay(value: float) -> EasingMotionExpression:
	_transition_factory.set_delay(value)
	return self

func loop(value: int) -> EasingMotionExpression:
	_transition_factory.set_loop(value)
	return self

func loop_delay(value: float) -> EasingMotionExpression:
	_transition_factory.set_loop_delay(value)
	return self

func alternate(value: bool) -> EasingMotionExpression:
	_transition_factory.set_alternate(value)
	return self

func reversed(value: bool) -> EasingMotionExpression:
	_transition_factory.set_reversed(value)
	return self

func from(value: Variant) -> EasingMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

func to(value: Variant) -> EasingMotionExpression:
	_transition_factory.set_final_position(value)
	return self

func function(value: EasingFunction) -> EasingMotionExpression:
	_transition_factory.set_function(value)
	return self

func wait(cancel: Cancel = null) -> Variant:
	return await _completion.wait(cancel)

#-------------------------------------------------------------------------------

const _EASING_CLASS := preload("uid://cvoofu1h8pec1")

var _completion: Task
var _transition_factory: _EASING_CLASS

func _init(
	completion: Task,
	transition_factory: _EASING_CLASS) -> void:

	assert(is_instance_valid(completion))
	assert(is_instance_valid(transition_factory))

	_completion = completion
	_transition_factory = transition_factory
