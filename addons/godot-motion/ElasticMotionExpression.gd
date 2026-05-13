class_name ElasticMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_AMPLITUDE := _ELASTIC_CLASS.MIN_AMPLITUDE
const MAX_AMPLITUDE := _ELASTIC_CLASS.MAX_AMPLITUDE
const AMPLITUDE_STEP := _ELASTIC_CLASS.AMPLITUDE_STEP
const DEFAULT_AMPLITUDE := _ELASTIC_CLASS.DEFAULT_AMPLITUDE

const MIN_PERIOD := _ELASTIC_CLASS.MIN_PERIOD
const MAX_PERIOD := _ELASTIC_CLASS.MAX_PERIOD
const PERIOD_STEP := _ELASTIC_CLASS.PERIOD_STEP
const DEFAULT_PERIOD := _ELASTIC_CLASS.DEFAULT_PERIOD

const EASE_IN := _ELASTIC_CLASS.EASE_IN
const EASE_OUT := _ELASTIC_CLASS.EASE_OUT
const EASE_IN_OUT := _ELASTIC_CLASS.EASE_IN_OUT
const EASE_OUT_IN := _ELASTIC_CLASS.EASE_OUT_IN
const VALID_EASE := _ELASTIC_CLASS.VALID_EASE
const DEFAULT_EASE := _ELASTIC_CLASS.DEFAULT_EASE

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target() -> MotionTarget:
	return _transition_factory.get_target()

func preset(preset_name: StringName) -> ElasticMotionExpression:
	_transition_factory.load_preset(preset_name)
	return self

func process(value: int) -> ElasticMotionExpression:
	_transition_factory.set_process(value)
	return self

func process_idle() -> ElasticMotionExpression:
	return super()

func process_physics() -> ElasticMotionExpression:
	return super()

func duration(value: float) -> ElasticMotionExpression:
	_transition_factory.set_duration(value)
	return self

func delay(value: float) -> ElasticMotionExpression:
	_transition_factory.set_delay(value)
	return self

func loop(value: int) -> ElasticMotionExpression:
	_transition_factory.set_loop(value)
	return self

func loop_delay(value: float) -> ElasticMotionExpression:
	_transition_factory.set_loop_delay(value)
	return self

func alternate(value: bool) -> ElasticMotionExpression:
	_transition_factory.set_alternate(value)
	return self

func reversed(value: bool) -> ElasticMotionExpression:
	_transition_factory.set_reversed(value)
	return self

func from(value: Variant) -> ElasticMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

func to(value: Variant) -> ElasticMotionExpression:
	_transition_factory.set_final_position(value)
	return self

func amplitude(value: float) -> ElasticMotionExpression:
	_transition_factory.set_amplitude(value)
	return self

func period(value: float) -> ElasticMotionExpression:
	_transition_factory.set_period(value)
	return self

func ease(value: int) -> ElasticMotionExpression:
	_transition_factory.set_ease(value)
	return self

func ease_in() -> ElasticMotionExpression:
	return self.ease(EASE_IN)

func ease_out() -> ElasticMotionExpression:
	return self.ease(EASE_OUT)

func ease_in_out() -> ElasticMotionExpression:
	return self.ease(EASE_IN_OUT)

func ease_out_in() -> ElasticMotionExpression:
	return self.ease(EASE_OUT_IN)

func wait(cancel: Cancel = null) -> Variant:
	return await _completion.wait(cancel)

#-------------------------------------------------------------------------------

const _ELASTIC_CLASS := preload("uid://cyc32wca84jau")

var _completion: Task
var _transition_factory: _ELASTIC_CLASS

func _init(
	completion: Task,
	transition_factory: _ELASTIC_CLASS) -> void:

	assert(is_instance_valid(completion))
	assert(is_instance_valid(transition_factory))

	_completion = completion
	_transition_factory = transition_factory
