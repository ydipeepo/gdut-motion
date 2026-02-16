## Irregular motion expression.
class_name IrregularMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target() -> GDUT_MotionTarget:
	return _transition_factory.get_target()

## Loads a preset.
func preset(value: StringName) -> IrregularMotionExpression:
	_transition_factory.load_preset(value)
	return self

## Sets the number of divisions.[br]
## [br]
## Higher values result in finer irregularities.
func segments(value: int) -> IrregularMotionExpression:
	_transition_factory.set_segments(value)
	return self

## Sets the intensity.[br]
## [br]
## Higher values result in greater changes.
func intensity(value: float) -> IrregularMotionExpression:
	_transition_factory.set_intensity(value)
	return self

## Sets the duration.
func duration(value: float) -> IrregularMotionExpression:
	_transition_factory.set_duration(value)
	return self

## Sets the initial position. If omitted, the current position is used.
func from(value: Variant) -> IrregularMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

## Sets the final position.
func to(value: Variant) -> IrregularMotionExpression:
	_transition_factory.set_final_position(value)
	return self

## Sets the update timing.
func process(value: int) -> IrregularMotionExpression:
	_transition_factory.set_process(value)
	return self

## Sets the update timing to [constant MotionExpression.PROCESS_IDLE].
func process_idle() -> IrregularMotionExpression:
	return super()

## Sets the update timing to [constant MotionExpression.PROCESS_PHYSICS].
func process_physics() -> IrregularMotionExpression:
	return super()

## Sets the delay.
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
