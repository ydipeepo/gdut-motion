<<<<<<< Updated upstream
=======
## Spring motion expression.
>>>>>>> Stashed changes
class_name SpringMotionExpression extends MotionExpression

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
func preset(value: StringName) -> SpringMotionExpression:
	_transition_factory.load_preset(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the stiffness (spring constant).[br]
## [br]
## The higher the value, the stronger the restoring force and the faster the vibration.
>>>>>>> Stashed changes
func stiffness(value: float) -> SpringMotionExpression:
	_transition_factory.set_stiffness(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the damping coefficient.[br]
## [br]
## The higher the value, the faster the vibration settles.
>>>>>>> Stashed changes
func damping(value: float) -> SpringMotionExpression:
	_transition_factory.set_damping(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the mass.[br]
## [br]
## The higher the value, the stronger the inertia and the slower the response.
>>>>>>> Stashed changes
func mass(value: float) -> SpringMotionExpression:
	_transition_factory.set_mass(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the maximum displacement to be considered at rest.
>>>>>>> Stashed changes
func rest_speed(value: float) -> SpringMotionExpression:
	_transition_factory.set_rest_speed(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the maximum velocity to be considered at rest.
>>>>>>> Stashed changes
func rest_delta(value: float) -> SpringMotionExpression:
	_transition_factory.set_rest_delta(value)
	return self

<<<<<<< Updated upstream
=======
## Sets whether to limit overdamping to critical damping.
>>>>>>> Stashed changes
func limit_overdamping(value := true) -> SpringMotionExpression:
	_transition_factory.set_limit_overdamping(value)
	return self

<<<<<<< Updated upstream
=======
## Sets whether to limit (prohibit) transient oscillations.
>>>>>>> Stashed changes
func limit_overshooting(value := true) -> SpringMotionExpression:
	_transition_factory.set_limit_overshooting(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the initial position. If omitted, the current position is used.
>>>>>>> Stashed changes
func from(value: Variant) -> SpringMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the final position.
>>>>>>> Stashed changes
func to(value: Variant) -> SpringMotionExpression:
	_transition_factory.set_final_position(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the initial velocity. If omitted, the current velocity is used.
>>>>>>> Stashed changes
func by(value: Variant) -> SpringMotionExpression:
	_transition_factory.set_initial_velocity(value)
	return self

<<<<<<< Updated upstream
=======
## Sets the update timing.
>>>>>>> Stashed changes
func process(value: int) -> SpringMotionExpression:
	_transition_factory.set_process(value)
	return self

<<<<<<< Updated upstream
func process_idle() -> SpringMotionExpression:
	return super()

func process_physics() -> SpringMotionExpression:
	return super()

=======
## Sets the update timing to [constant MotionExpression.PROCESS_IDLE].
func process_idle() -> SpringMotionExpression:
	return super()

## Sets the update timing to [constant MotionExpression.PROCESS_PHYSICS].
func process_physics() -> SpringMotionExpression:
	return super()

## Sets the delay.
>>>>>>> Stashed changes
func delay(value: float) -> SpringMotionExpression:
	_transition_factory.set_delay(value)
	return self

#-------------------------------------------------------------------------------

var _transition_factory: GDUT_SpringMotionTransitionFactory

func _init(
	completion: Task,
	transition_factory: GDUT_SpringMotionTransitionFactory) -> void:

	super(completion)

	assert(transition_factory != null)

	_transition_factory = transition_factory
