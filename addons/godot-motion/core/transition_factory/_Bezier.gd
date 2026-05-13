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

const MIN_X1 := BezierEasing.MIN_X1
const MAX_X1 := BezierEasing.MAX_X1
const DEFAULT_X1 := BezierEasing.DEFAULT_X1

const MIN_Y1 := BezierEasing.MIN_Y1
const MAX_Y1 := BezierEasing.MAX_Y1
const DEFAULT_Y1 := BezierEasing.DEFAULT_Y1

const MIN_X2 := BezierEasing.MIN_X2
const MAX_X2 := BezierEasing.MAX_X2
const DEFAULT_X2 := BezierEasing.DEFAULT_X2

const MIN_Y2 := BezierEasing.MIN_Y2
const MAX_Y2 := BezierEasing.MAX_Y2
const DEFAULT_Y2 := BezierEasing.DEFAULT_Y2

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_expression_name() -> StringName:
	return &"Bezier"

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

func set_x1(value: float) -> void:
	if value < MIN_X1 or MAX_X1 < value:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_X1",
			get_expression_name(),
			value,
			MIN_X1,
			MAX_X1)
		value = clampf(value, MIN_X1, MAX_X1)
	_x1 = value

func set_y1(value: float) -> void:
	if value < MIN_Y1 or MAX_Y1 < value:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_Y1",
			get_expression_name(),
			value,
			MIN_Y1,
			MAX_Y1)
		value = clampf(value, MIN_Y1, MAX_Y1)
	_y1 = value

func set_x2(value: float) -> void:
	if value < MIN_X2 or MAX_X2 < value:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_X2",
			get_expression_name(),
			value,
			MIN_X2,
			MAX_X2)
		value = clampf(value, MIN_X2, MAX_X2)
	_x2 = value

func set_y2(value: float) -> void:
	if value < MIN_Y2 or MAX_Y2 < value:
		_AUTOLOAD_CLASS.print_warning(
			&"BAD_Y2",
			get_expression_name(),
			value,
			MIN_Y2,
			MAX_Y2)
		value = clampf(value, MIN_Y2, MAX_Y2)
	_y2 = value

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
		EasingFunction.create_bezier(_x1, _y1, _x2, _y2))

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
var _x1 := DEFAULT_X1
var _y1 := DEFAULT_Y1
var _x2 := DEFAULT_X2
var _y2 := DEFAULT_Y2
