class_name IrregularMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_proxy() -> MotionProxy:
	return _transition_factory.get_proxy()

func preset(value: StringName) -> IrregularMotionExpression:
	_transition_factory.load_preset(value)
	return self

func segments(value: int) -> IrregularMotionExpression:
	_transition_factory.set_segments(value)
	return self

func intensity(value: float) -> IrregularMotionExpression:
	_transition_factory.set_intensity(value)
	return self

func duration(value: float) -> IrregularMotionExpression:
	_transition_factory.set_duration(value)
	return self

func from(value: Variant) -> IrregularMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

func to(value: Variant) -> IrregularMotionExpression:
	_transition_factory.set_final_position(value)
	return self

func process(value: int) -> IrregularMotionExpression:
	_transition_factory.set_process(value)
	return self

func process_idle() -> IrregularMotionExpression:
	return super()

func process_physics() -> IrregularMotionExpression:
	return super()

func delay(value: float) -> IrregularMotionExpression:
	_transition_factory.set_delay(value)
	return self

#-------------------------------------------------------------------------------

var _transition_factory: GDUT_IrregularMotionTransitionFactory

func _init(
	completion: Task,
	transition_factory: GDUT_IrregularMotionTransitionFactory) -> void:

	super(completion)

	assert(transition_factory != null)

	_transition_factory = transition_factory
