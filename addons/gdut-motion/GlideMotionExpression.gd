## Glide motion expression.
class_name GlideMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target() -> GDUT_MotionTarget:
	return _transition_factory.get_target()

## Loads a preset.
func preset(value: StringName) -> GlideMotionExpression:
	_transition_factory.load_preset(value)
	return self

## Sets the scale factor for estimating the final position from the initial velocity.[br]
## [br]
## [code]V0 * [/code][member power] will be the final displacement.
func power(value: float) -> GlideMotionExpression:
	_transition_factory.set_power(value)
	return self

## Sets the time constant.[br]
## [br]
## The smaller the value, the faster it converges.
func time_constant(value: float) -> GlideMotionExpression:
	_transition_factory.set_time_constant(value)
	return self

## Sets the rest displacement.
func rest_delta(value: float) -> GlideMotionExpression:
	_transition_factory.set_rest_delta(value)
	return self

## Sets the initial position. If omitted, the current position is used.
func from(value: Variant) -> GlideMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

## Sets the final position.
func to(value: Variant) -> GlideMotionExpression:
	_transition_factory.set_final_position(value)
	return self

## Sets the initial velocity. If omitted, the current velocity is used.
func by(value: Variant) -> GlideMotionExpression:
	_transition_factory.set_initial_velocity(value)
	return self

## Sets the update timing.
func process(value: int) -> GlideMotionExpression:
	_transition_factory.set_process(value)
	return self

## Sets the update timing to [constant MotionExpression.PROCESS_IDLE].
func process_idle() -> GlideMotionExpression:
	return super()

## Sets the update timing to [constant MotionExpression.PROCESS_PHYSICS].
func process_physics() -> GlideMotionExpression:
	return super()

## Sets the delay.
func delay(value: float) -> GlideMotionExpression:
	_transition_factory.set_delay(value)
	return self

#-------------------------------------------------------------------------------

var _transition_factory: GDUT_GlideMotionTransitionFactory

func _init(
	completion: Task,
	transition_factory: GDUT_GlideMotionTransitionFactory) -> void:

	super(completion)

	assert(transition_factory != null)

	_transition_factory = transition_factory
