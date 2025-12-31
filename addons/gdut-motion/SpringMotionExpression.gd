class_name SpringMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_proxy() -> MotionProxy:
	return _transition_factory.get_proxy()

func preset(value: StringName) -> SpringMotionExpression:
	_transition_factory.load_preset(value)
	return self

func stiffness(value: float) -> SpringMotionExpression:
	_transition_factory.set_stiffness(value)
	return self

func damping(value: float) -> SpringMotionExpression:
	_transition_factory.set_damping(value)
	return self

func mass(value: float) -> SpringMotionExpression:
	_transition_factory.set_mass(value)
	return self

func rest_speed(value: float) -> SpringMotionExpression:
	_transition_factory.set_rest_speed(value)
	return self

func rest_delta(value: float) -> SpringMotionExpression:
	_transition_factory.set_rest_delta(value)
	return self

func limit_overdamping(value := true) -> SpringMotionExpression:
	_transition_factory.set_limit_overdamping(value)
	return self

func limit_overshooting(value := true) -> SpringMotionExpression:
	_transition_factory.set_limit_overshooting(value)
	return self

func from(value: Variant) -> SpringMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

func to(value: Variant) -> SpringMotionExpression:
	_transition_factory.set_final_position(value)
	return self

func by(value: Variant) -> SpringMotionExpression:
	_transition_factory.set_initial_velocity(value)
	return self

func process(value: int) -> SpringMotionExpression:
	_transition_factory.set_process(value)
	return self

func process_idle() -> SpringMotionExpression:
	return super()

func process_physics() -> SpringMotionExpression:
	return super()

func delay(value: float) -> SpringMotionExpression:
	_transition_factory.set_delay(value)
	return self

#-------------------------------------------------------------------------------

var _transition_factory: GDUT_SpringMotionTransitionFactory

func _init(
	completion: Task,
	transition_factory: GDUT_SpringMotionTransitionFactory) -> void:

	super(completion)

	assert(transition_factory != null)

	_transition_factory = transition_factory
