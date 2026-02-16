<<<<<<< Updated upstream
=======
## Linear motion expression.
>>>>>>> Stashed changes
class_name LinearMotionExpression extends MotionExpression

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
func preset(value: StringName) -> LinearMotionExpression:
	_transition_factory.load_preset(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the array of segment vertices.[br]
## [br]
## [code]0[/code] and [code]1[/code] will be added to the beginning and end of this array.
>>>>>>> Stashed changes
func y_array(y_array: Array[float]) -> LinearMotionExpression:
	_transition_factory.set_y_array(y_array)
	return self

<<<<<<< Updated upstream
=======
## Adds a segment vertex.
>>>>>>> Stashed changes
func y(y: float) -> LinearMotionExpression:
	_transition_factory.add_y(y)
	return self

<<<<<<< Updated upstream
=======
## Sets the duration.
>>>>>>> Stashed changes
func duration(value: float) -> LinearMotionExpression:
	_transition_factory.set_duration(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the initial position. If omitted, the current position will be used.
>>>>>>> Stashed changes
func from(value: Variant) -> LinearMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the final position.
>>>>>>> Stashed changes
func to(value: Variant) -> LinearMotionExpression:
	_transition_factory.set_final_position(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the update timing.
>>>>>>> Stashed changes
func process(value: int) -> LinearMotionExpression:
	_transition_factory.set_process(value)
	return self

<<<<<<< Updated upstream
func process_idle() -> LinearMotionExpression:
	return super()

func process_physics() -> LinearMotionExpression:
	return super()

=======
## Sets the update timing to [constant MotionExpression.PROCESS_IDLE].
func process_idle() -> LinearMotionExpression:
	return super()

## Sets the update timing to [constant MotionExpression.PROCESS_PHYSICS].
func process_physics() -> LinearMotionExpression:
	return super()

## Sets the delay.
>>>>>>> Stashed changes
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
