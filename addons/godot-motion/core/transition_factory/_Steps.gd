extends MotionTransitionFactory

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_DURATION := _EASING_CLASS.MIN_DURATION
const DEFAULT_DURATION := 1.0

const MIN_DELAY := _EASING_CLASS.MIN_DELAY
const DEFAULT_DELAY := 0.0

const MIN_LOOP := _EASING_CLASS.MIN_LOOP
const DEFAULT_LOOP := 0

const MIN_LOOP_DELAY := _EASING_CLASS.MIN_LOOP_DELAY
const DEFAULT_LOOP_DELAY := 0.0

const DEFAULT_ALTERNATE := true

const DEFAULT_REVERSED := false

const ROUND_CEIL := StepsEasing.ROUND_CEIL
const ROUND_ROUND := StepsEasing.ROUND_ROUND
const ROUND_FLOOR := StepsEasing.ROUND_FLOOR
const VALID_ROUND := StepsEasing.VALID_ROUND
const DEFAULT_ROUND := StepsEasing.DEFAULT_ROUND

const MIN_SEGMENTS := StepsEasing.MIN_SEGMENTS
const DEFAULT_SEGMENTS := StepsEasing.DEFAULT_SEGMENTS

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_expression_name() -> StringName:
	return &"Steps"

func set_process(value: int) -> void:
	if value not in VALID_PROCESS:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_PROCESS",
			get_expression_name(),
			value)
		value = PROCESS_IDLE
	_process = value

func get_process() -> int:
	return _process

func set_duration(value: float) -> void:
	if value < MIN_DURATION:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_DURATION",
			get_expression_name(),
			value,
			MIN_DURATION)
		value = MIN_DURATION
	_duration = value

func set_delay(value: float) -> void:
	if value < MIN_DELAY:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_DELAY",
			get_expression_name(),
			value,
			MIN_DELAY)
		value = MIN_DELAY
	_delay = value

func set_loop(value: int) -> void:
	if value < MIN_LOOP:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_LOOP",
			get_expression_name(),
			value,
			MIN_LOOP)
		value = MIN_LOOP
	_loop = value

func set_loop_delay(value: float) -> void:
	if value < MIN_LOOP_DELAY:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_LOOP_DELAY",
			get_expression_name(),
			value,
			MIN_LOOP_DELAY)
		value = MIN_LOOP_DELAY
	_loop_delay = value

func set_alternate(value: bool) -> void:
	_alternate = value

func set_reversed(value: bool) -> void:
	_reversed = value

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

func set_segments(value: int) -> void:
	if value < MIN_SEGMENTS:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_SEGMENTS",
			get_expression_name(),
			value,
			MIN_SEGMENTS)
		value = MIN_SEGMENTS
	_segments = value

func set_round(value: int) -> void:
	if value not in VALID_ROUND:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_ROUND",
			get_expression_name(),
			value)
		value = DEFAULT_ROUND
	_round = value

func create_transition(completion: Array) -> MotionTransition:
	return _EASING_CLASS.new(
		completion,
		_process,
		_duration,
		_delay,
		_loop,
		_loop_delay,
		_alternate,
		_reversed,
		_initial_position,
		_final_position,
		EasingFunction.create_steps(
			_segments,
			_round))

#-------------------------------------------------------------------------------

const _AUTOLOAD_CLASS := preload("uid://p04dph4xrfh3")
const _EASING_CLASS := preload("uid://dblm7txp5wyj2")

var _process := DEFAULT_PROCESS
var _duration := DEFAULT_DURATION
var _delay := DEFAULT_DELAY
var _loop := DEFAULT_LOOP
var _loop_delay := DEFAULT_LOOP_DELAY
var _alternate := DEFAULT_ALTERNATE
var _reversed := DEFAULT_REVERSED
var _initial_position: Variant
var _final_position: Variant
var _segments := DEFAULT_SEGMENTS
var _round := DEFAULT_ROUND
