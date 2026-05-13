class_name BackMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_OVERSHOOT := _BACK_CLASS.MIN_OVERSHOOT
const MAX_OVERSHOOT := _BACK_CLASS.MAX_OVERSHOOT
const OVERSHOOT_STEP := BackEasing.OVERSHOOT_STEP
const DEFAULT_OVERSHOOT := _BACK_CLASS.DEFAULT_OVERSHOOT

const EASE_IN := _BACK_CLASS.EASE_IN
const EASE_OUT := _BACK_CLASS.EASE_OUT
const EASE_IN_OUT := _BACK_CLASS.EASE_IN_OUT
const EASE_OUT_IN := _BACK_CLASS.EASE_OUT_IN

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target() -> MotionTarget:
	return _transition_factory.get_target()

func preset(preset_name: StringName) -> BackMotionExpression:
	_transition_factory.load_preset(preset_name)
	return self

func process(value: int) -> BackMotionExpression:
	_transition_factory.set_process(value)
	return self

func process_idle() -> BackMotionExpression:
	return super()

func process_physics() -> BackMotionExpression:
	return super()

func duration(value: float) -> BackMotionExpression:
	_transition_factory.set_duration(value)
	return self

func delay(value: float) -> BackMotionExpression:
	_transition_factory.set_delay(value)
	return self

func loop(value: int) -> BackMotionExpression:
	_transition_factory.set_loop(value)
	return self

func loop_delay(value: float) -> BackMotionExpression:
	_transition_factory.set_loop_delay(value)
	return self

func alternate(value: bool) -> BackMotionExpression:
	_transition_factory.set_alternate(value)
	return self

func reversed(value: bool) -> BackMotionExpression:
	_transition_factory.set_reversed(value)
	return self

func from(value: Variant) -> BackMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

func to(value: Variant) -> BackMotionExpression:
	_transition_factory.set_final_position(value)
	return self

func overshoot(value: float) -> BackMotionExpression:
	_transition_factory.set_overshoot(value)
	return self

func ease(value: int) -> BackMotionExpression:
	_transition_factory.set_ease(value)
	return self

func ease_in() -> BackMotionExpression:
	return self.ease(EASE_IN)

func ease_out() -> BackMotionExpression:
	return self.ease(EASE_OUT)

func ease_in_out() -> BackMotionExpression:
	return self.ease(EASE_IN_OUT)

func ease_out_in() -> BackMotionExpression:
	return self.ease(EASE_OUT_IN)

func wait(cancel: Cancel = null) -> Variant:
	return await _completion.wait(cancel)

#-------------------------------------------------------------------------------

const _BACK_CLASS := preload("uid://bjpg1boh2yayy")

var _completion: Task
var _transition_factory: _BACK_CLASS

func _init(
	completion: Task,
	transition_factory: _BACK_CLASS) -> void:

	assert(is_instance_valid(completion))
	assert(is_instance_valid(transition_factory))

	_completion = completion
	_transition_factory = transition_factory
