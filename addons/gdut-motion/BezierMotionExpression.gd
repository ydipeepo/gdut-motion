class_name BezierMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_proxy() -> MotionProxy:
	return _transition_factory.get_proxy()

func preset(value: StringName) -> BezierMotionExpression:
	_transition_factory.load_preset(value)
	return self

func x1(value: float) -> BezierMotionExpression:
	_transition_factory.set_x1(value)
	return self

func y1(value: float) -> BezierMotionExpression:
	_transition_factory.set_y1(value)
	return self

func x2(value: float) -> BezierMotionExpression:
	_transition_factory.set_x2(value)
	return self

func y2(value: float) -> BezierMotionExpression:
	_transition_factory.set_y2(value)
	return self

func p1(value: Vector2) -> BezierMotionExpression:
	_transition_factory.set_x1(value.x)
	_transition_factory.set_y1(value.y)
	return self

func p2(value: Vector2) -> BezierMotionExpression:
	_transition_factory.set_x2(value.x)
	_transition_factory.set_y2(value.y)
	return self

func duration(value: float) -> BezierMotionExpression:
	_transition_factory.set_duration(value)
	return self

func from(value: Variant) -> BezierMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

func to(value: Variant) -> BezierMotionExpression:
	_transition_factory.set_final_position(value)
	return self

func process(value: int) -> BezierMotionExpression:
	_transition_factory.set_process(value)
	return self

func process_idle() -> BezierMotionExpression:
	return super()

func process_physics() -> BezierMotionExpression:
	return super()

func delay(value: float) -> BezierMotionExpression:
	_transition_factory.set_delay(value)
	return self

#-------------------------------------------------------------------------------

var _transition_factory: GDUT_BezierMotionTransitionFactory

func _init(
	completion: Task,
	transition_factory: GDUT_BezierMotionTransitionFactory) -> void:

	super(completion)

	assert(transition_factory != null)

	_transition_factory = transition_factory
