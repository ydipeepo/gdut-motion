class_name LinearMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_proxy() -> MotionProxy:
	return _transition_factory.get_proxy()

func preset(value: StringName) -> LinearMotionExpression:
	_transition_factory.load_preset(value)
	return self

func y_array(y_array: Array[float]) -> LinearMotionExpression:
	_transition_factory.set_y_array(y_array)
	return self

func y(y: float) -> LinearMotionExpression:
	_transition_factory.add_y(y)
	return self

func duration(value: float) -> LinearMotionExpression:
	_transition_factory.set_duration(value)
	return self

func from(value: Variant) -> LinearMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

func to(value: Variant) -> LinearMotionExpression:
	_transition_factory.set_final_position(value)
	return self

func process(value: int) -> LinearMotionExpression:
	_transition_factory.set_process(value)
	return self

func process_idle() -> LinearMotionExpression:
	return super()

func process_physics() -> LinearMotionExpression:
	return super()

func delay(value: float) -> LinearMotionExpression:
	_transition_factory.set_delay(value)
	return self

#-------------------------------------------------------------------------------

var _transition_factory: GDUT_LinearMotionTransitionFactory

func _init(
	completion: Task,
	transition_factory: GDUT_LinearMotionTransitionFactory) -> void:

	super(completion)

	assert(transition_factory != null)

	_transition_factory = transition_factory
