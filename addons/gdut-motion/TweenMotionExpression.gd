class_name TweenMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const EASE_IN := GDUT_TweenMotionTransition.EASE_IN
const EASE_OUT := GDUT_TweenMotionTransition.EASE_OUT
const EASE_IN_OUT := GDUT_TweenMotionTransition.EASE_IN_OUT
const EASE_OUT_IN := GDUT_TweenMotionTransition.EASE_OUT_IN

const TRANS_LINEAR := GDUT_TweenMotionTransition.TRANS_LINEAR
const TRANS_SINE := GDUT_TweenMotionTransition.TRANS_SINE
const TRANS_QUINT := GDUT_TweenMotionTransition.TRANS_QUINT
const TRANS_QUART := GDUT_TweenMotionTransition.TRANS_QUART
const TRANS_QUAD := GDUT_TweenMotionTransition.TRANS_QUAD
const TRANS_EXPO := GDUT_TweenMotionTransition.TRANS_EXPO
const TRANS_ELASTIC := GDUT_TweenMotionTransition.TRANS_ELASTIC
const TRANS_CUBIC := GDUT_TweenMotionTransition.TRANS_CUBIC
const TRANS_CIRC := GDUT_TweenMotionTransition.TRANS_CIRC
const TRANS_BOUNCE := GDUT_TweenMotionTransition.TRANS_BOUNCE
const TRANS_BACK := GDUT_TweenMotionTransition.TRANS_BACK
const TRANS_SPRING := GDUT_TweenMotionTransition.TRANS_SPRING

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_proxy() -> MotionProxy:
	return _transition_factory.get_proxy()

func preset(value: StringName) -> TweenMotionExpression:
	_transition_factory.load_preset(value)
	return self

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

func duration(value: float) -> TweenMotionExpression:
	_transition_factory.set_duration(value)
	return self

func from(value: Variant) -> TweenMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

func to(value: Variant) -> TweenMotionExpression:
	_transition_factory.set_final_position(value)
	return self

func process(value: int) -> TweenMotionExpression:
	_transition_factory.set_process(value)
	return self

func process_idle() -> TweenMotionExpression:
	return super()

func process_physics() -> TweenMotionExpression:
	return super()

func delay(value: float) -> TweenMotionExpression:
	_transition_factory.set_delay(value)
	return self

#-------------------------------------------------------------------------------

var _transition_factory: GDUT_TweenMotionTransitionFactory

func _init(
	completion: Task,
	transition_factory: GDUT_TweenMotionTransitionFactory) -> void:

	super(completion)

	assert(transition_factory != null)

	_transition_factory = transition_factory
