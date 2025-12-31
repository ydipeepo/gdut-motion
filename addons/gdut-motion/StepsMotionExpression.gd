class_name StepsMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const ROUND_CEIL := GDUT_StepsMotionTransition.ROUND_CEIL
const ROUND_FLOOR := GDUT_StepsMotionTransition.ROUND_FLOOR

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_proxy() -> MotionProxy:
	return _transition_factory.get_proxy()

func preset(value: StringName) -> StepsMotionExpression:
	_transition_factory.load_preset(value)
	return self

func segments(value: int) -> StepsMotionExpression:
	_transition_factory.set_segments(value)
	return self

func round(value: int) -> StepsMotionExpression:
	_transition_factory.set_round(value)
	return self

func round_ceil() -> StepsMotionExpression:
	return round(ROUND_CEIL)

func round_floor() -> StepsMotionExpression:
	return round(ROUND_FLOOR)

func duration(value: float) -> StepsMotionExpression:
	_transition_factory.set_duration(value)
	return self

func from(value: Variant) -> StepsMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

func to(value: Variant) -> StepsMotionExpression:
	_transition_factory.set_final_position(value)
	return self

func process(value: int) -> StepsMotionExpression:
	_transition_factory.set_process(value)
	return self

func process_idle() -> StepsMotionExpression:
	return super()

func process_physics() -> StepsMotionExpression:
	return super()

func delay(value: float) -> StepsMotionExpression:
	_transition_factory.set_delay(value)
	return self

#-------------------------------------------------------------------------------

var _transition_factory: GDUT_StepsMotionTransitionFactory

func _init(
	completion: Task,
	transition_factory: GDUT_StepsMotionTransitionFactory) -> void:

	super(completion)

	assert(transition_factory != null)

	_transition_factory = transition_factory
