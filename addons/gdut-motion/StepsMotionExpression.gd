## Steps motion expression.
class_name StepsMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

## Uses the ceiling function for interpolation of each segment.
const ROUND_CEIL := GDUT_StepsMotionTransition.ROUND_CEIL
## Uses the floor function for interpolation of each segment.
const ROUND_FLOOR := GDUT_StepsMotionTransition.ROUND_FLOOR

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target() -> GDUT_MotionTarget:
	return _transition_factory.get_target()

## Loads a preset.
func preset(value: StringName) -> StepsMotionExpression:
	_transition_factory.load_preset(value)
	return self

## Sets the number of divisions.
func segments(value: int) -> StepsMotionExpression:
	_transition_factory.set_segments(value)
	return self

## Sets the rounding function.
func round(value: int) -> StepsMotionExpression:
	_transition_factory.set_round(value)
	return self

## Sets the rounding function to [constant ROUND_CEIL].
func round_ceil() -> StepsMotionExpression:
	return round(ROUND_CEIL)

## Sets the rounding function to [constant ROUND_FLOOR].
func round_floor() -> StepsMotionExpression:
	return round(ROUND_FLOOR)

## Sets the duration.
func duration(value: float) -> StepsMotionExpression:
	_transition_factory.set_duration(value)
	return self

## Sets the initial position. If omitted, the current position is used.
func from(value: Variant) -> StepsMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

## Sets the final position.
func to(value: Variant) -> StepsMotionExpression:
	_transition_factory.set_final_position(value)
	return self

## Sets the update timing.
func process(value: int) -> StepsMotionExpression:
	_transition_factory.set_process(value)
	return self

## Sets the update timing to [constant MotionExpression.PROCESS_IDLE].
func process_idle() -> StepsMotionExpression:
	return super()

## Sets the update timing to [constant MotionExpression.PROCESS_PHYSICS].
func process_physics() -> StepsMotionExpression:
	return super()

## Sets the delay.
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
