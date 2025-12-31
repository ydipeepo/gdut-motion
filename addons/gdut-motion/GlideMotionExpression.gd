class_name GlideMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_proxy() -> MotionProxy:
	return _transition_factory.get_proxy()

func preset(value: StringName) -> GlideMotionExpression:
	_transition_factory.load_preset(value)
	return self

func power(value: float) -> GlideMotionExpression:
	_transition_factory.set_power(value)
	return self

func time_constant(value: float) -> GlideMotionExpression:
	_transition_factory.set_time_constant(value)
	return self

func rest_delta(value: float) -> GlideMotionExpression:
	_transition_factory.set_rest_delta(value)
	return self

func from(value: Variant) -> GlideMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

func to(value: Variant) -> GlideMotionExpression:
	_transition_factory.set_final_position(value)
	return self

func by(value: Variant) -> GlideMotionExpression:
	_transition_factory.set_initial_velocity(value)
	return self

func process(value: int) -> GlideMotionExpression:
	_transition_factory.set_process(value)
	return self

func process_idle() -> GlideMotionExpression:
	return super()

func process_physics() -> GlideMotionExpression:
	return super()

func delay(value: float) -> GlideMotionExpression:
	_transition_factory.set_delay(value)
	return self

#-------------------------------------------------------------------------------

var _transition_factory: GDUT_GlideMotionTransitionFactory

func _init(
	completion: Task,
	transition_factory: GDUT_GlideMotionTransitionFactory) -> void:

	super(completion)

	assert(transition_factory != null)

	_transition_factory = transition_factory
