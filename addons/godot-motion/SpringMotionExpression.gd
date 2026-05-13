class_name SpringMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target() -> MotionTarget:
	return _transition_factory.get_target()

func preset(preset_name: StringName) -> SpringMotionExpression:
	_transition_factory.load_preset(preset_name)
	return self

func process(value: int) -> SpringMotionExpression:
	_transition_factory.set_process(value)
	return self

func process_idle() -> SpringMotionExpression:
	return super()

func process_physics() -> SpringMotionExpression:
	return super()

func stiffness(value: float) -> SpringMotionExpression:
	_transition_factory.set_stiffness(value)
	return self

func damping(value: float) -> SpringMotionExpression:
	_transition_factory.set_damping(value)
	return self

func mass(value: float) -> SpringMotionExpression:
	_transition_factory.set_mass(value)
	return self

func rest_energy(value: float) -> SpringMotionExpression:
	_transition_factory.set_rest_energy(value)
	return self

func limit_overdamping(value := true) -> SpringMotionExpression:
	_transition_factory.set_limit_overdamping(value)
	return self

func limit_overshooting(value := true) -> SpringMotionExpression:
	_transition_factory.set_limit_overshooting(value)
	return self

func from(value: Variant) -> SpringMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

func to(value: Variant) -> SpringMotionExpression:
	_transition_factory.set_final_position(value)
	return self

func by(value: Variant) -> SpringMotionExpression:
	_transition_factory.set_initial_velocity(value)
	return self

func wait(cancel: Cancel = null) -> Variant:
	return await _completion.wait(cancel)

#-------------------------------------------------------------------------------

const _SPRING_CLASS := preload("uid://cu530wnsnvp3d")

var _completion: Task
var _transition_factory: _SPRING_CLASS

func _init(
	completion: Task,
	transition_factory: _SPRING_CLASS) -> void:

	assert(is_instance_valid(completion))
	assert(is_instance_valid(transition_factory))

	_completion = completion
	_transition_factory = transition_factory
