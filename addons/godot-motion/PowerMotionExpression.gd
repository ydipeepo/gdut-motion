class_name PowerMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_EXPONENT := _POWER_CLASS.MIN_EXPONENT
const MAX_EXPONENT := _POWER_CLASS.MAX_EXPONENT
const EXPONENT_STEP := PowerEasing.EXPONENT_STEP
const DEFAULT_EXPONENT := _POWER_CLASS.DEFAULT_EXPONENT

const EASE_IN := _POWER_CLASS.EASE_IN
const EASE_OUT := _POWER_CLASS.EASE_OUT
const EASE_IN_OUT := _POWER_CLASS.EASE_IN_OUT
const EASE_OUT_IN := _POWER_CLASS.EASE_OUT_IN

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target() -> MotionTarget:
	return _transition_factory.get_target()

func preset(preset_name: StringName) -> PowerMotionExpression:
	_transition_factory.load_preset(preset_name)
	return self

func process(value: int) -> PowerMotionExpression:
	_transition_factory.set_process(value)
	return self

func process_idle() -> PowerMotionExpression:
	return super()

func process_physics() -> PowerMotionExpression:
	return super()

func duration(value: float) -> PowerMotionExpression:
	_transition_factory.set_duration(value)
	return self

func delay(value: float) -> PowerMotionExpression:
	_transition_factory.set_delay(value)
	return self

func loop(value: int) -> PowerMotionExpression:
	_transition_factory.set_loop(value)
	return self

func loop_delay(value: float) -> PowerMotionExpression:
	_transition_factory.set_loop_delay(value)
	return self

func alternate(value: bool) -> PowerMotionExpression:
	_transition_factory.set_alternate(value)
	return self

func reversed(value: bool) -> PowerMotionExpression:
	_transition_factory.set_reversed(value)
	return self

func from(value: Variant) -> PowerMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

func to(value: Variant) -> PowerMotionExpression:
	_transition_factory.set_final_position(value)
	return self

func exponent(value: float) -> PowerMotionExpression:
	_transition_factory.set_exponent(value)
	return self

func ease(value: int) -> PowerMotionExpression:
	_transition_factory.set_ease(value)
	return self

func ease_in() -> PowerMotionExpression:
	return self.ease(EASE_IN)

func ease_out() -> PowerMotionExpression:
	return self.ease(EASE_OUT)

func ease_in_out() -> PowerMotionExpression:
	return self.ease(EASE_IN_OUT)

func ease_out_in() -> PowerMotionExpression:
	return self.ease(EASE_OUT_IN)

func wait(cancel: Cancel = null) -> Variant:
	return await _completion.wait(cancel)

#-------------------------------------------------------------------------------

const _POWER_CLASS := preload("uid://b418k13gylvdc")

var _completion: Task
var _transition_factory: _POWER_CLASS

func _init(
	completion: Task,
	transition_factory: _POWER_CLASS) -> void:

	assert(is_instance_valid(completion))
	assert(is_instance_valid(transition_factory))

	_completion = completion
	_transition_factory = transition_factory
