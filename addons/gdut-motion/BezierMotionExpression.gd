## Bezier motion expression.
class_name BezierMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target() -> GDUT_MotionTarget:
	return _transition_factory.get_target()

## Loads a preset.
func preset(value: StringName) -> BezierMotionExpression:
	_transition_factory.load_preset(value)
	return self

## Set the first control point X component.
func x1(value: float) -> BezierMotionExpression:
	_transition_factory.set_x1(value)
	return self

## Set the first control point Y component.
func y1(value: float) -> BezierMotionExpression:
	_transition_factory.set_y1(value)
	return self

## Set the second control point X component.
func x2(value: float) -> BezierMotionExpression:
	_transition_factory.set_x2(value)
	return self

## Set the second control point Y component.
func y2(value: float) -> BezierMotionExpression:
	_transition_factory.set_y2(value)
	return self

## Set the first control point.
func cp1(value: Vector2) -> BezierMotionExpression:
	_transition_factory.set_x1(value.x)
	_transition_factory.set_y1(value.y)
	return self

## Set the second control point.
func cp2(value: Vector2) -> BezierMotionExpression:
	_transition_factory.set_x2(value.x)
	_transition_factory.set_y2(value.y)
	return self

## Set the duration.
func duration(value: float) -> BezierMotionExpression:
	_transition_factory.set_duration(value)
	return self

## Set the initial position. If omitted, the current position is set.
func from(value: Variant) -> BezierMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

## Set the final position.
func to(value: Variant) -> BezierMotionExpression:
	_transition_factory.set_final_position(value)
	return self

## Set the update timing.
func process(value: int) -> BezierMotionExpression:
	_transition_factory.set_process(value)
	return self

## Set the update timing to [constant MotionExpression.PROCESS_IDLE].
func process_idle() -> BezierMotionExpression:
	return super()

## Set the update timing to [constant MotionExpression.PROCESS_PHYSICS].
func process_physics() -> BezierMotionExpression:
	return super()

## Set the delay.
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
