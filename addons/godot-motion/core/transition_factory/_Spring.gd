extends MotionTransitionFactory

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_STIFFNESS := _SPRING_CLASS.MIN_STIFFNESS
const DEFAULT_STIFFNESS := 100.0

const MIN_DAMPING := _SPRING_CLASS.MIN_DAMPING
const DEFAULT_DAMPING := 10.0

const MIN_MASS := _SPRING_CLASS.MIN_MASS
const DEFAULT_MASS := 1.0

const MIN_REST_ENERGY := _SPRING_CLASS.MIN_REST_ENERGY
const DEFAULT_REST_ENERGY := 0.0001

const DEFAULT_LIMIT_OVERDAMPING := true

const DEFAULT_LIMIT_OVERSHOOTING := false

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_expression_name() -> StringName:
	return &"Spring"

func set_process(value: int) -> void:
	if value not in MotionTransition.VALID_PROCESS:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_PROCESS",
			get_expression_name(),
			value)
		value = MotionTransition.PROCESS_IDLE
	_process = value

func get_process() -> int:
	return _process

func set_initial_position(value: Variant) -> void:
	if not is_valid_position(value):
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_INITIAL_POSITION",
			get_expression_name(),
			value)
		value = null
	_initial_position = value

func get_initial_position() -> Variant:
	return _initial_position

func set_final_position(value: Variant) -> void:
	var target := get_target()
	if not is_valid_position(value):
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_FINAL_POSITION",
			get_expression_name(),
			value)
		value = null
	_final_position = value

func get_final_position() -> Variant:
	return _final_position

func set_initial_velocity(value: Variant) -> void:
	var target := get_target()
	if not is_valid_velocity(value):
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_INITIAL_VELOCITY",
			get_expression_name(),
			value)
		value = null
	_initial_velocity = value

func get_initial_velocity() -> Variant:
	return _initial_velocity

func set_stiffness(value: float) -> void:
	if value < MIN_STIFFNESS:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_STIFFNESS",
			get_expression_name(),
			value,
			MIN_STIFFNESS)
		value = MIN_STIFFNESS
	_stiffness = value

func set_damping(value: float) -> void:
	if value < MIN_DAMPING:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_DAMPING",
			get_expression_name(),
			value,
			MIN_DAMPING)
		value = MIN_DAMPING
	_damping = value

func set_mass(value: float) -> void:
	if value < MIN_MASS:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_MASS",
			get_expression_name(),
			value,
			MIN_MASS)
		value = MIN_MASS
	_mass = value

func set_rest_energy(value: float) -> void:
	if value < MIN_REST_ENERGY:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_REST_ENERGY",
			get_expression_name(),
			value,
			MIN_REST_ENERGY)
		value = MIN_REST_ENERGY
	_rest_energy = value

func set_limit_overdamping(value: bool) -> void:
	_limit_overdamping = value

func set_limit_overshooting(value: bool) -> void:
	_limit_overshooting = value

func create_transition(completion: Array) -> MotionTransition:
	return _SPRING_CLASS.create(
		completion,
		_process,
		_initial_position,
		_final_position,
		_initial_velocity,
		_stiffness,
		_damping,
		_mass,
		_rest_energy,
		_limit_overdamping,
		_limit_overshooting)

#-------------------------------------------------------------------------------

const _AUTOLOAD_CLASS := preload("uid://p04dph4xrfh3")
const _SPRING_CLASS := preload("uid://cvx11b4u7pqhn")

var _process := DEFAULT_PROCESS
var _initial_position: Variant
var _final_position: Variant
var _initial_velocity: Variant
var _stiffness := DEFAULT_STIFFNESS
var _damping := DEFAULT_DAMPING
var _mass := DEFAULT_MASS
var _rest_energy := DEFAULT_REST_ENERGY
var _limit_overdamping := DEFAULT_LIMIT_OVERDAMPING
var _limit_overshooting := DEFAULT_LIMIT_OVERSHOOTING
