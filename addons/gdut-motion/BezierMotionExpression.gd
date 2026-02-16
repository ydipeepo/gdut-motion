<<<<<<< Updated upstream
=======
## Bezier motion expression.
>>>>>>> Stashed changes
class_name BezierMotionExpression extends MotionExpression

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
func preset(value: StringName) -> BezierMotionExpression:
	_transition_factory.load_preset(value)
	return self

<<<<<<< Updated upstream
=======
## Set the first control point X component.
>>>>>>> Stashed changes
func x1(value: float) -> BezierMotionExpression:
	_transition_factory.set_x1(value)
	return self

<<<<<<< Updated upstream
=======
## Set the first control point Y component.
>>>>>>> Stashed changes
func y1(value: float) -> BezierMotionExpression:
	_transition_factory.set_y1(value)
	return self

<<<<<<< Updated upstream
=======
## Set the second control point X component.
>>>>>>> Stashed changes
func x2(value: float) -> BezierMotionExpression:
	_transition_factory.set_x2(value)
	return self

<<<<<<< Updated upstream
=======
## Set the second control point Y component.
>>>>>>> Stashed changes
func y2(value: float) -> BezierMotionExpression:
	_transition_factory.set_y2(value)
	return self

<<<<<<< Updated upstream
func p1(value: Vector2) -> BezierMotionExpression:
=======
## Set the first control point.
func cp1(value: Vector2) -> BezierMotionExpression:
>>>>>>> Stashed changes
	_transition_factory.set_x1(value.x)
	_transition_factory.set_y1(value.y)
	return self

<<<<<<< Updated upstream
func p2(value: Vector2) -> BezierMotionExpression:
=======
## Set the second control point.
func cp2(value: Vector2) -> BezierMotionExpression:
>>>>>>> Stashed changes
	_transition_factory.set_x2(value.x)
	_transition_factory.set_y2(value.y)
	return self

<<<<<<< Updated upstream
=======
## Set the duration.
>>>>>>> Stashed changes
func duration(value: float) -> BezierMotionExpression:
	_transition_factory.set_duration(value)
	return self

<<<<<<< Updated upstream
=======
## Set the initial position. If omitted, the current position is set.
>>>>>>> Stashed changes
func from(value: Variant) -> BezierMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

<<<<<<< Updated upstream
=======
## Set the final position.
>>>>>>> Stashed changes
func to(value: Variant) -> BezierMotionExpression:
	_transition_factory.set_final_position(value)
	return self

<<<<<<< Updated upstream
=======
## Set the update timing.
>>>>>>> Stashed changes
func process(value: int) -> BezierMotionExpression:
	_transition_factory.set_process(value)
	return self

<<<<<<< Updated upstream
func process_idle() -> BezierMotionExpression:
	return super()

func process_physics() -> BezierMotionExpression:
	return super()

=======
## Set the update timing to [constant MotionExpression.PROCESS_IDLE].
func process_idle() -> BezierMotionExpression:
	return super()

## Set the update timing to [constant MotionExpression.PROCESS_PHYSICS].
func process_physics() -> BezierMotionExpression:
	return super()

## Set the delay.
>>>>>>> Stashed changes
func delay(value: float) -> BezierMotionExpression:
	_transition_factory.set_delay(value)
	return self

#-------------------------------------------------------------------------------

var _transition_factory: GDUT_BezierMotionTransitionFactory

func _init(
	completion: Task,
	transition_factory: GDUT_BezierMotionTransitionFactory) -> void:

	super(completion)

	assert(transition_factory != null)

	_transition_factory = transition_factory
