class_name GDUT_SpringMotionTransitionFactory extends GDUT_PhysicsMotionTransitionFactory

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_name() -> StringName:
	return &"Spring"

func set_stiffness(value: float) -> void:
	if value < GDUT_SpringMotionTransition.MIN_STIFFNESS:
<<<<<<< Updated upstream
		GDUT_Motion.print_warning(
			&"BAD_STIFFNESS",
			get_name(),
			value)
=======
		GDUT_Motion.print_warning(&"BAD_STIFFNESS", get_name(), value)
>>>>>>> Stashed changes
		value = GDUT_SpringMotionTransition.MIN_STIFFNESS
	_stiffness = value

func set_damping(value: float) -> void:
	if value < GDUT_SpringMotionTransition.MIN_DAMPING:
<<<<<<< Updated upstream
		GDUT_Motion.print_warning(
			&"BAD_DAMPING",
			get_name(),
			value)
=======
		GDUT_Motion.print_warning(&"BAD_DAMPING", get_name(), value)
>>>>>>> Stashed changes
		value = GDUT_SpringMotionTransition.MIN_DAMPING
	_damping = value

func set_mass(value: float) -> void:
	if value < GDUT_SpringMotionTransition.MIN_MASS:
<<<<<<< Updated upstream
		GDUT_Motion.print_warning(
			&"BAD_MASS",
			get_name(),
			value)
=======
		GDUT_Motion.print_warning(&"BAD_MASS", get_name(), value)
>>>>>>> Stashed changes
		value = GDUT_SpringMotionTransition.MIN_MASS
	_mass = value

func set_rest_speed(value: float) -> void:
	if value < GDUT_SpringMotionTransition.MIN_REST_SPEED:
<<<<<<< Updated upstream
		GDUT_Motion.print_warning(
			&"BAD_REST_SPEED",
			get_name(),
			value)
=======
		GDUT_Motion.print_warning(&"BAD_REST_SPEED", get_name(), value)
>>>>>>> Stashed changes
		value = GDUT_SpringMotionTransition.MIN_REST_SPEED
	_rest_speed = value

func set_rest_delta(value: float) -> void:
	if value < GDUT_SpringMotionTransition.MIN_REST_DELTA:
<<<<<<< Updated upstream
		GDUT_Motion.print_warning(
			&"BAD_REST_DELTA",
			get_name(),
			value)
=======
		GDUT_Motion.print_warning(&"BAD_REST_DELTA", get_name(), value)
>>>>>>> Stashed changes
		value = GDUT_SpringMotionTransition.MIN_REST_DELTA
	_rest_delta = value

func set_limit_overdamping(value: bool) -> void:
	_limit_overdamping = value

func set_limit_overshooting(value: bool) -> void:
	_limit_overshooting = value

func create_transition(completion: Array) -> GDUT_MotionTransition:
	return GDUT_SpringMotionTransition.new(
		_stiffness,
		_damping,
		_mass,
		_rest_delta,
		_rest_speed,
		_limit_overdamping,
		_limit_overshooting,
		get_initial_position(),
		get_final_position(),
		get_initial_velocity(),
		get_process(),
		completion)

#-------------------------------------------------------------------------------

var _stiffness := GDUT_SpringMotionTransition.DEFAULT_STIFFNESS
var _damping := GDUT_SpringMotionTransition.DEFAULT_DAMPING
var _mass := GDUT_SpringMotionTransition.DEFAULT_MASS
var _rest_delta := GDUT_SpringMotionTransition.DEFAULT_REST_DELTA
var _rest_speed := GDUT_SpringMotionTransition.DEFAULT_REST_SPEED
var _limit_overdamping := GDUT_SpringMotionTransition.DEFAULT_LIMIT_OVERDAMPING
var _limit_overshooting := GDUT_SpringMotionTransition.DEFAULT_LIMIT_OVERSHOOTING
