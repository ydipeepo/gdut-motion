## Linear motion expression.
class_name LinearMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target() -> GDUT_MotionTarget:
	return _transition_factory.get_target()

## Loads a preset.
func preset(value: StringName) -> LinearMotionExpression:
	_transition_factory.load_preset(value)
	return self

## Sets the array of segment vertices.[br]
## [br]
## [code]0[/code] and [code]1[/code] will be added to the beginning and end of this array.
func y_array(y_array: Array[float]) -> LinearMotionExpression:
	_transition_factory.set_y_array(y_array)
	return self

## Adds a segment vertex.
func y(y: float) -> LinearMotionExpression:
	_transition_factory.add_y(y)
	return self

## Sets the duration.
func duration(value: float) -> LinearMotionExpression:
	_transition_factory.set_duration(value)
	return self

## Sets the initial position. If omitted, the current position will be used.
func from(value: Variant) -> LinearMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

## Sets the final position.
func to(value: Variant) -> LinearMotionExpression:
	_transition_factory.set_final_position(value)
	return self

## Sets the update timing.
func process(value: int) -> LinearMotionExpression:
	_transition_factory.set_process(value)
	return self

## Sets the update timing to [constant MotionExpression.PROCESS_IDLE].
func process_idle() -> LinearMotionExpression:
	return super()

## Sets the update timing to [constant MotionExpression.PROCESS_PHYSICS].
func process_physics() -> LinearMotionExpression:
	return super()

## Sets the delay.
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
