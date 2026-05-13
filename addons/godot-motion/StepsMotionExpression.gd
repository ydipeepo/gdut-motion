class_name StepsMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const ROUND_CEIL := _STEPS_CLASS.ROUND_CEIL
const ROUND_ROUND := _STEPS_CLASS.ROUND_ROUND
const ROUND_FLOOR := _STEPS_CLASS.ROUND_FLOOR

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target() -> MotionTarget:
	return _transition_factory.get_target()

func preset(preset_name: StringName) -> StepsMotionExpression:
	_transition_factory.load_preset(preset_name)
	return self

func process(value: int) -> StepsMotionExpression:
	_transition_factory.set_process(value)
	return self

func process_idle() -> StepsMotionExpression:
	return super()

func process_physics() -> StepsMotionExpression:
	return super()

func duration(value: float) -> StepsMotionExpression:
	_transition_factory.set_duration(value)
	return self

func delay(value: float) -> StepsMotionExpression:
	_transition_factory.set_delay(value)
	return self

func loop(value: int) -> StepsMotionExpression:
	_transition_factory.set_loop(value)
	return self

func loop_delay(value: float) -> StepsMotionExpression:
	_transition_factory.set_loop_delay(value)
	return self

func alternate(value: bool) -> StepsMotionExpression:
	_transition_factory.set_alternate(value)
	return self

func reversed(value: bool) -> StepsMotionExpression:
	_transition_factory.set_reversed(value)
	return self

func from(value: Variant) -> StepsMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

func to(value: Variant) -> StepsMotionExpression:
	_transition_factory.set_final_position(value)
	return self

func segments(value: int) -> StepsMotionExpression:
	_transition_factory.set_segments(value)
	return self

func round(value: int) -> StepsMotionExpression:
	_transition_factory.set_round(value)
	return self

func round_ceil() -> StepsMotionExpression:
	return self.round(ROUND_CEIL)

func round_round() -> StepsMotionExpression:
	return self.round(ROUND_ROUND)

func round_floor() -> StepsMotionExpression:
	return self.round(ROUND_FLOOR)

func wait(cancel: Cancel = null) -> Variant:
	return await _completion.wait(cancel)

#-------------------------------------------------------------------------------

const _STEPS_CLASS := preload("uid://1qfbdejoesif")

var _completion: Task
var _transition_factory: _STEPS_CLASS

func _init(
	completion: Task,
	transition_factory: _STEPS_CLASS) -> void:

	assert(is_instance_valid(completion))
	assert(is_instance_valid(transition_factory))

	_completion = completion
	_transition_factory = transition_factory
