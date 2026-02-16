<<<<<<< Updated upstream
=======
## Steps motion expression.
>>>>>>> Stashed changes
class_name StepsMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
const ROUND_CEIL := GDUT_StepsMotionTransition.ROUND_CEIL
=======
## Uses the ceiling function for interpolation of each segment.
const ROUND_CEIL := GDUT_StepsMotionTransition.ROUND_CEIL
## Uses the floor function for interpolation of each segment.
>>>>>>> Stashed changes
const ROUND_FLOOR := GDUT_StepsMotionTransition.ROUND_FLOOR

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
func preset(value: StringName) -> StepsMotionExpression:
	_transition_factory.load_preset(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the number of divisions.
>>>>>>> Stashed changes
func segments(value: int) -> StepsMotionExpression:
	_transition_factory.set_segments(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the rounding function.
>>>>>>> Stashed changes
func round(value: int) -> StepsMotionExpression:
	_transition_factory.set_round(value)
	return self

<<<<<<< Updated upstream
func round_ceil() -> StepsMotionExpression:
	return round(ROUND_CEIL)

func round_floor() -> StepsMotionExpression:
	return round(ROUND_FLOOR)

=======
## Sets the rounding function to [constant ROUND_CEIL].
func round_ceil() -> StepsMotionExpression:
	return round(ROUND_CEIL)

## Sets the rounding function to [constant ROUND_FLOOR].
func round_floor() -> StepsMotionExpression:
	return round(ROUND_FLOOR)

## Sets the duration.
>>>>>>> Stashed changes
func duration(value: float) -> StepsMotionExpression:
	_transition_factory.set_duration(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the initial position. If omitted, the current position is used.
>>>>>>> Stashed changes
func from(value: Variant) -> StepsMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the final position.
>>>>>>> Stashed changes
func to(value: Variant) -> StepsMotionExpression:
	_transition_factory.set_final_position(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the update timing.
>>>>>>> Stashed changes
func process(value: int) -> StepsMotionExpression:
	_transition_factory.set_process(value)
	return self

<<<<<<< Updated upstream
func process_idle() -> StepsMotionExpression:
	return super()

func process_physics() -> StepsMotionExpression:
	return super()

=======
## Sets the update timing to [constant MotionExpression.PROCESS_IDLE].
func process_idle() -> StepsMotionExpression:
	return super()

## Sets the update timing to [constant MotionExpression.PROCESS_PHYSICS].
func process_physics() -> StepsMotionExpression:
	return super()

## Sets the delay.
>>>>>>> Stashed changes
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
