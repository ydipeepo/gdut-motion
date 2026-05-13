class_name TweenMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const TRANS_LINEAR := _TWEEN_CLASS.TRANS_LINEAR
const TRANS_SINE := _TWEEN_CLASS.TRANS_SINE
const TRANS_QUINT := _TWEEN_CLASS.TRANS_QUINT
const TRANS_QUART := _TWEEN_CLASS.TRANS_QUART
const TRANS_QUAD := _TWEEN_CLASS.TRANS_QUAD
const TRANS_EXPO := _TWEEN_CLASS.TRANS_EXPO
const TRANS_ELASTIC := _TWEEN_CLASS.TRANS_ELASTIC
const TRANS_CUBIC := _TWEEN_CLASS.TRANS_CUBIC
const TRANS_CIRC := _TWEEN_CLASS.TRANS_CIRC
const TRANS_BOUNCE := _TWEEN_CLASS.TRANS_BOUNCE
const TRANS_BACK := _TWEEN_CLASS.TRANS_BACK
const TRANS_SPRING := _TWEEN_CLASS.TRANS_SPRING

const EASE_IN := _TWEEN_CLASS.EASE_IN
const EASE_OUT := _TWEEN_CLASS.EASE_OUT
const EASE_IN_OUT := _TWEEN_CLASS.EASE_IN_OUT
const EASE_OUT_IN := _TWEEN_CLASS.EASE_OUT_IN

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target() -> MotionTarget:
	return _transition_factory.get_target()

func preset(preset_name: StringName) -> TweenMotionExpression:
	_transition_factory.load_preset(preset_name)
	return self

func process(value: int) -> TweenMotionExpression:
	_transition_factory.set_process(value)
	return self

func process_idle() -> TweenMotionExpression:
	return super()

func process_physics() -> TweenMotionExpression:
	return super()

func duration(value: float) -> TweenMotionExpression:
	_transition_factory.set_duration(value)
	return self

func delay(value: float) -> TweenMotionExpression:
	_transition_factory.set_delay(value)
	return self

func loop(value: int) -> TweenMotionExpression:
	_transition_factory.set_loop(value)
	return self

func loop_delay(value: float) -> TweenMotionExpression:
	_transition_factory.set_loop_delay(value)
	return self

func alternate(value: bool) -> TweenMotionExpression:
	_transition_factory.set_alternate(value)
	return self

func reversed(value: bool) -> TweenMotionExpression:
	_transition_factory.set_reversed(value)
	return self

func from(value: Variant) -> TweenMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

func to(value: Variant) -> TweenMotionExpression:
	_transition_factory.set_final_position(value)
	return self

func trans(value: int) -> TweenMotionExpression:
	_transition_factory.set_trans(value)
	return self

func trans_linear() -> TweenMotionExpression:
	return trans(TRANS_LINEAR)

func trans_sine() -> TweenMotionExpression:
	return trans(TRANS_SINE)

func trans_quint() -> TweenMotionExpression:
	return trans(TRANS_QUINT)

func trans_quart() -> TweenMotionExpression:
	return trans(TRANS_QUART)

func trans_quad() -> TweenMotionExpression:
	return trans(TRANS_QUAD)

func trans_expo() -> TweenMotionExpression:
	return trans(TRANS_EXPO)

func trans_elastic() -> TweenMotionExpression:
	return trans(TRANS_ELASTIC)

func trans_cubic() -> TweenMotionExpression:
	return trans(TRANS_CUBIC)

func trans_circ() -> TweenMotionExpression:
	return trans(TRANS_CIRC)

func trans_bounce() -> TweenMotionExpression:
	return trans(TRANS_BOUNCE)

func trans_back() -> TweenMotionExpression:
	return trans(TRANS_BACK)

func trans_spring() -> TweenMotionExpression:
	return trans(TRANS_SPRING)

func ease(value: int) -> TweenMotionExpression:
	_transition_factory.set_ease(value)
	return self

func ease_in() -> TweenMotionExpression:
	return self.ease(EASE_IN)

func ease_out() -> TweenMotionExpression:
	return self.ease(EASE_OUT)

func ease_in_out() -> TweenMotionExpression:
	return self.ease(EASE_IN_OUT)

func ease_out_in() -> TweenMotionExpression:
	return self.ease(EASE_OUT_IN)

func wait(cancel: Cancel = null) -> Variant:
	return await _completion.wait(cancel)

#-------------------------------------------------------------------------------

const _TWEEN_CLASS := preload("uid://fxlxlw5pced6")

var _completion: Task
var _transition_factory: _TWEEN_CLASS

func _init(
	completion: Task,
	transition_factory: _TWEEN_CLASS) -> void:

	assert(is_instance_valid(completion))
	assert(is_instance_valid(transition_factory))

	_completion = completion
	_transition_factory = transition_factory
