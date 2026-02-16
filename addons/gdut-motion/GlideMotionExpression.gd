<<<<<<< Updated upstream
=======
## Glide motion expression.
>>>>>>> Stashed changes
class_name GlideMotionExpression extends MotionExpression

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
func preset(value: StringName) -> GlideMotionExpression:
	_transition_factory.load_preset(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the scale factor for estimating the final position from the initial velocity.[br]
## [br]
## [code]V0 * [/code][member power] will be the final displacement.
>>>>>>> Stashed changes
func power(value: float) -> GlideMotionExpression:
	_transition_factory.set_power(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the time constant.[br]
## [br]
## The smaller the value, the faster it converges.
>>>>>>> Stashed changes
func time_constant(value: float) -> GlideMotionExpression:
	_transition_factory.set_time_constant(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the rest displacement.
>>>>>>> Stashed changes
func rest_delta(value: float) -> GlideMotionExpression:
	_transition_factory.set_rest_delta(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the initial position. If omitted, the current position is used.
>>>>>>> Stashed changes
func from(value: Variant) -> GlideMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the final position.
>>>>>>> Stashed changes
func to(value: Variant) -> GlideMotionExpression:
	_transition_factory.set_final_position(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the initial velocity. If omitted, the current velocity is used.
>>>>>>> Stashed changes
func by(value: Variant) -> GlideMotionExpression:
	_transition_factory.set_initial_velocity(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the update timing.
>>>>>>> Stashed changes
func process(value: int) -> GlideMotionExpression:
	_transition_factory.set_process(value)
	return self

<<<<<<< Updated upstream
func process_idle() -> GlideMotionExpression:
	return super()

func process_physics() -> GlideMotionExpression:
	return super()

=======
## Sets the update timing to [constant MotionExpression.PROCESS_IDLE].
func process_idle() -> GlideMotionExpression:
	return super()

## Sets the update timing to [constant MotionExpression.PROCESS_PHYSICS].
func process_physics() -> GlideMotionExpression:
	return super()

## Sets the delay.
>>>>>>> Stashed changes
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
