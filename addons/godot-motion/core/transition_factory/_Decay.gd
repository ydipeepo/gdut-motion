extends MotionTransitionFactory

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_POWER := _DECAY_CLASS.MIN_POWER
const DEFAULT_POWER := 0.8

const MIN_TIME_CONSTANT := _DECAY_CLASS.MIN_TIME_CONSTANT
const DEFAULT_TIME_CONSTANT := 0.35

const MIN_REST_DELTA := _DECAY_CLASS.MIN_REST_DELTA
const DEFAULT_REST_DELTA := 0.0001

const PREFER_VELOCITY := _DECAY_CLASS.PREFER_VELOCITY
const PREFER_POSITION := _DECAY_CLASS.PREFER_POSITION
const VALID_PREFER := _DECAY_CLASS.VALID_PREFER
const DEFAULT_PREFER := PREFER_VELOCITY

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_expression_name() -> StringName:
	return &"Decay"

func set_process(value: int) -> void:
	if value not in VALID_PROCESS:
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
	if not is_valid_velocity(value):
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_INITIAL_VELOCITY",
			get_expression_name(),
			value)
		value = null
	_initial_velocity = value

func get_initial_velocity() -> Variant:
	return _initial_velocity

func set_power(value: float) -> void:
	if value < MIN_POWER:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_POWER",
			get_expression_name(),
			value,
			MIN_POWER)
		value = MIN_POWER
	_power = value

func set_time_constant(value: float) -> void:
	if value < MIN_TIME_CONSTANT:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_TIME_CONSTANT",
			get_expression_name(),
			value,
			MIN_TIME_CONSTANT)
		value = MIN_TIME_CONSTANT
	_time_constant = value

func set_rest_delta(value: float) -> void:
	if value < MIN_REST_DELTA:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_REST_DELTA",
			get_expression_name(),
			value,
			MIN_REST_DELTA)
		value = MIN_REST_DELTA
	_rest_delta = value

func set_prefer(value: int) -> void:
	if value not in VALID_PREFER:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_PREFER",
			get_expression_name(),
			value)
		value = DEFAULT_PREFER
	_prefer = value

func create_transition(completion: Array) -> MotionTransition:
	return _DECAY_CLASS.create(
		completion,
		_process,
		_initial_position,
		_final_position,
		_initial_velocity,
		_power,
		_time_constant,
		_rest_delta,
		_prefer)

#-------------------------------------------------------------------------------

const _AUTOLOAD_CLASS := preload("uid://p04dph4xrfh3")
const _DECAY_CLASS := preload("uid://bvliunx5v525h")

var _process := DEFAULT_PROCESS
var _initial_position: Variant
var _final_position: Variant
var _initial_velocity: Variant
var _prefer := DEFAULT_PREFER
var _power := DEFAULT_POWER
var _time_constant := DEFAULT_TIME_CONSTANT
var _rest_delta := DEFAULT_REST_DELTA
#var _delay := DEFAULT_DELAY
