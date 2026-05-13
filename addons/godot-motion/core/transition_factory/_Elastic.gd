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

const MIN_AMPLITUDE := ElasticEasing.MIN_AMPLITUDE
const MAX_AMPLITUDE := ElasticEasing.MAX_AMPLITUDE
const AMPLITUDE_STEP := ElasticEasing.AMPLITUDE_STEP
const DEFAULT_AMPLITUDE := ElasticEasing.DEFAULT_AMPLITUDE

const MIN_PERIOD := ElasticEasing.MIN_PERIOD
const MAX_PERIOD := ElasticEasing.MAX_PERIOD
const PERIOD_STEP := ElasticEasing.PERIOD_STEP
const DEFAULT_PERIOD := ElasticEasing.DEFAULT_PERIOD

const EASE_IN := ElasticEasing.EASE_IN
const EASE_OUT := ElasticEasing.EASE_OUT
const EASE_IN_OUT := ElasticEasing.EASE_IN_OUT
const EASE_OUT_IN := ElasticEasing.EASE_OUT_IN
const VALID_EASE := ElasticEasing.VALID_EASE
const DEFAULT_EASE := ElasticEasing.DEFAULT_EASE

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_expression_name() -> StringName:
	return &"Elastic"

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

func set_amplitude(value: float) -> void:
	if value < MIN_AMPLITUDE or MAX_AMPLITUDE < value:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_AMPLITUDE",
			get_expression_name(),
			value,
			MIN_AMPLITUDE,
			MAX_AMPLITUDE)
		value = clampf(value, MIN_AMPLITUDE, MAX_AMPLITUDE)
	_amplitude = value

func set_period(value: float) -> void:
	if value < MIN_PERIOD or MAX_PERIOD < value:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_PERIOD",
			get_expression_name(),
			value,
			MIN_PERIOD,
			MAX_PERIOD)
		value = clampf(value, MIN_PERIOD, MAX_PERIOD)
	_period = value

func set_ease(value: int) -> void:
	if value not in VALID_EASE:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_EASE",
			get_expression_name(),
			value)
		value = DEFAULT_EASE
	_ease = value

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
		EasingFunction.create_elastic(
			_amplitude,
			_period,
			_ease))

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
var _amplitude := DEFAULT_AMPLITUDE
var _period := DEFAULT_PERIOD
var _ease := DEFAULT_EASE
