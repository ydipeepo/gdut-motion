extends MotionTransition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_DURATION := 0.0

const MIN_DELAY := 0.0

const MIN_LOOP := 0

const MIN_LOOP_DELAY := 0.0

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func create(
	completion: Array,
	process: int,
	duration: float,
	delay: float,
	loop: int,
	loop_delay: float,
	alternate: bool,
	reversed: bool,
	initial_position: Variant,
	final_position: Variant,
	function: EasingFunction) -> MotionTransition:

	assert(completion.size() == 3)
	assert(process in VALID_PROCESS)
	assert(MIN_DURATION <= duration)
	assert(MIN_DELAY <= delay)
	assert(MIN_LOOP <= loop)
	assert(MIN_LOOP_DELAY <= loop_delay)
	assert(is_instance_valid(function))

	return new(
		completion,
		process,
		duration,
		delay,
		loop,
		loop_delay,
		alternate,
		reversed,
		initial_position,
		final_position,
		function)

func get_completion() -> Task:
	return _completion[0]

func get_process() -> int:
	return _process

func get_duration() -> float:
	return _compute_total_duration()

func start(state: MotionState) -> void:
	state.reset_initial_position(_initial_position)
	state.reset_final_position(_final_position)
	state.reset_rest()

	var x := _compute_x(0.0)
	var y := _function.get_value(x)
	var dy := _function.get_slope(x)
	var in_delay := _is_in_delay(0.0)
	var flipped := _is_flipped(0.0)
	for k: int in state.get_array_size() * state.get_value_size():
		var p0 := state.get_initial_position_at(k)
		var p1 := state.get_final_position_at(k)
		var p := lerpf(p0, p1, y)
		var v: float
		if in_delay or _duration == 0.0:
			v = 0.0
		else:
			v = (p1 - p0) * dy / _duration
			if flipped:
				v = -v
		state.set_position_at(k, p)
		state.set_velocity_at(k, v)

func apply(state: MotionState, timer: MotionTimer) -> bool:
	var total_duration := _compute_total_duration()
	var t := timer.get_total()
	var x := _compute_x(t)
	var y := _function.get_value(x)
	var dy := _function.get_slope(x)
	var in_delay := _is_in_delay(t)
	var flipped := _is_flipped(t)
	for k: int in state.get_array_size() * state.get_value_size():
		var p0 := state.get_initial_position_at(k)
		var p1 := state.get_final_position_at(k)
		var p := lerpf(p0, p1, y)
		var v: float
		if in_delay or _duration == 0.0:
			v = 0.0
		else:
			v = (p1 - p0) * dy / _duration
			if flipped:
				v = -v
		state.set_position_at(k, p)
		state.set_velocity_at(k, v)
	if total_duration <= t:
		for k: int in state.get_array_size() * state.get_value_size():
			state.set_rest_at(k)
		_completion[1].call(maxf(t - total_duration, 0.0))
		return false
	return true

func abort() -> void:
	_completion[2].call()

#-------------------------------------------------------------------------------

var _completion: Array
var _process: int
var _duration: float
var _delay: float
var _loop: int
var _loop_delay: float
var _alternate: bool
var _reversed: bool
var _initial_position: Variant
var _final_position: Variant
var _function: EasingFunction

func _is_in_delay(t: float) -> bool:
	t -= _delay
	if t < 0.0:
		return true
	var cycle_duration := _duration + _loop_delay
	var cycle_i := int(t / cycle_duration)
	if cycle_i <= _loop:
		var cycle_t := t - cycle_duration * cycle_i
		if _duration <= cycle_t:
			return true
	return false

func _is_flipped(t: float) -> bool:
	t -= _delay
	if t < 0.0:
		return not _reversed
	var cycle_duration := _duration + _loop_delay
	var cycle_i := int(t / cycle_duration)
	if cycle_i <= _loop:
		var flipped := (_alternate and cycle_i % 2 == 1) != _reversed
		return flipped
	return (_alternate and _loop % 2 == 1) != _reversed

func _compute_total_duration() -> float:
	return _duration + _delay + _loop * (_duration + _loop_delay)

func _compute_x(t: float) -> float:
	t -= _delay
	if t < 0.0:
		return 0.0 if not _reversed else 1.0
	var cycle_duration := _duration + _loop_delay
	if t < _duration + _loop * cycle_duration:
		var cycle_i := int(t / cycle_duration)
		if cycle_i <= _loop:
			var flipped := (_alternate and cycle_i % 2 == 1) != _reversed
			var cycle_t := t - cycle_duration * cycle_i
			if _duration <= cycle_t:
				return 0.0 if flipped else 1.0
			if _duration != 0.0:
				if flipped:
					cycle_t = _duration - cycle_t
				return cycle_t / _duration
	return 0.0 if (_alternate and _loop % 2 == 1) != _reversed else 1.0

func _init(
	completion: Array,
	process: int,
	duration: float,
	delay: float,
	loop: int,
	loop_delay: float,
	alternate: bool,
	reversed: bool,
	initial_position: Variant,
	final_position: Variant,
	function: EasingFunction) -> void:

	_completion = completion
	_process = process
	_duration = duration
	_delay = delay
	_loop = loop
	_loop_delay = loop_delay
	_alternate = alternate
	_reversed = reversed
	_initial_position = initial_position
	_final_position = final_position
	_function = function
