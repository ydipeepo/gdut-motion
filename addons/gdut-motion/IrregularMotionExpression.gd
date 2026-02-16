<<<<<<< Updated upstream
=======
## Irregular motion expression.
>>>>>>> Stashed changes
class_name IrregularMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
func get_proxy() -> MotionProxy:
	return _transition_factory.get_proxy()

=======
func get_target() -> GDUT_MotionTarget:
	return _transition_factory.get_target()

## Loads a preset.
>>>>>>> Stashed changes
func preset(value: StringName) -> IrregularMotionExpression:
	_transition_factory.load_preset(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the number of divisions.[br]
## [br]
## Higher values result in finer irregularities.
>>>>>>> Stashed changes
func segments(value: int) -> IrregularMotionExpression:
	_transition_factory.set_segments(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the intensity.[br]
## [br]
## Higher values result in greater changes.
>>>>>>> Stashed changes
func intensity(value: float) -> IrregularMotionExpression:
	_transition_factory.set_intensity(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the duration.
>>>>>>> Stashed changes
func duration(value: float) -> IrregularMotionExpression:
	_transition_factory.set_duration(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the initial position. If omitted, the current position is used.
>>>>>>> Stashed changes
func from(value: Variant) -> IrregularMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the final position.
>>>>>>> Stashed changes
func to(value: Variant) -> IrregularMotionExpression:
	_transition_factory.set_final_position(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the update timing.
>>>>>>> Stashed changes
func process(value: int) -> IrregularMotionExpression:
	_transition_factory.set_process(value)
	return self

<<<<<<< Updated upstream
func process_idle() -> IrregularMotionExpression:
	return super()

func process_physics() -> IrregularMotionExpression:
	return super()

=======
## Sets the update timing to [constant MotionExpression.PROCESS_IDLE].
func process_idle() -> IrregularMotionExpression:
	return super()

## Sets the update timing to [constant MotionExpression.PROCESS_PHYSICS].
func process_physics() -> IrregularMotionExpression:
	return super()

## Sets the delay.
>>>>>>> Stashed changes
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
