@abstract
extends MotionTransition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const PREFER_VELOCITY := 0
const PREFER_POSITION := 1
const VALID_PREFER: Array[int] = [
	PREFER_VELOCITY,
	PREFER_POSITION,
]

const MIN_POWER := 1e-4

const MIN_TIME_CONSTANT := 1e-4

const MIN_REST_DELTA := 1e-6

const MIN_DELAY := 0.0

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func create(
	completion: Array,
	process: int,
	initial_position: Variant,
	final_position: Variant,
	initial_velocity: Variant,
	power: float,
	time_constant: float,
	rest_delta: float,
	prefer: int) -> MotionTransition:

	assert(completion.size() == 3)
	assert(process in VALID_PROCESS)
	assert(MIN_POWER <= power)
	assert(MIN_TIME_CONSTANT <= time_constant)
	assert(MIN_REST_DELTA <= rest_delta)
	assert(prefer in VALID_PREFER)

	return _NEW_MAP[prefer].call(
		completion,
		process,
		initial_position,
		final_position,
		initial_velocity,
		power,
		time_constant,
		rest_delta)

func get_completion() -> Task:
	return _completion[0]

func get_process() -> int:
	return _process

func get_duration() -> float:
	return _duration

func start(state: MotionState) -> void:
	state.reset_initial_position(_initial_position)
	state.reset_final_position(_final_position)
	state.reset_initial_velocity(_initial_velocity)

	_duration = 0.0
	var stride := state.get_value_size()
	for i: int in state.get_array_size():
		var active := false
		var offset := i * stride
		for j: int in stride:
			var k := offset + j
			var p0 := state.get_initial_position_at(k)
			var p1 := state.get_final_position_at(k)
			var v0 := state.get_initial_velocity_at(k)
			var target := resolve_target(p0, p1, v0)
			var d := target - p0
			if _rest_delta < absf(d):
				active = true
				break
		if active:
			for j: int in stride:
				var k := offset + j
				var p0 := state.get_initial_position_at(k)
				var p1 := state.get_final_position_at(k)
				var v0 := state.get_initial_velocity_at(k)
				var target := resolve_target(p0, p1, v0)
				var d := target - p0
				var p := target - d
				var v := d / _time_constant
				state.set_position_at(k, p)
				state.set_velocity_at(k, v)
				state.clear_rest_at(k)
				_duration = maxf(_get_rest_time(p0, p1, v0), _duration)
		else:
			for j: int in stride:
				var k := offset + j
				var p0 := state.get_initial_position_at(k)
				var p1 := state.get_final_position_at(k)
				var v0 := state.get_initial_velocity_at(k)
				var target := resolve_target(p0, p1, v0)
				var p := target
				var v := 0.0
				state.set_position_at(k, p)
				state.set_velocity_at(k, v)
				state.set_rest_at(k)

func apply(state: MotionState, timer: MotionTimer) -> bool:
	var t := timer.get_total()
	var a := exp(-t / _time_constant)
	var any_active := false
	var stride := state.get_value_size()
	for i: int in state.get_array_size():
		var active := false
		var offset := i * stride
		for j: int in stride:
			var k := offset + j
			if not state.get_rest_at(k):
				var p0 := state.get_initial_position_at(k)
				var p1 := state.get_final_position_at(k)
				var v0 := state.get_initial_velocity_at(k)
				var target := resolve_target(p0, p1, v0)
				var d := target - p0
				if _rest_delta < absf(d) * a:
					active = true
					break
		if active:
			for j: int in stride:
				var k := offset + j
				if not state.get_rest_at(k):
					var p0 := state.get_initial_position_at(k)
					var p1 := state.get_final_position_at(k)
					var v0 := state.get_initial_velocity_at(k)
					var target := resolve_target(p0, p1, v0)
					var d := target - p0
					var p := target - d * a
					var v := (d / _time_constant) * a
					state.set_position_at(k, p)
					state.set_velocity_at(k, v)
			any_active = true
		else:
			for j: int in stride:
				var k := offset + j
				if not state.get_rest_at(k):
					var p0 := state.get_initial_position_at(k)
					var p1 := state.get_final_position_at(k)
					var v0 := state.get_initial_velocity_at(k)
					var target := resolve_target(p0, p1, v0)
					var p := target
					var v := 0.0
					state.set_position_at(k, p)
					state.set_velocity_at(k, v)
					state.set_rest_at(k)
	if any_active:
		return true
	else:
		_completion[1].call(maxf(t - _duration, 0.0))
		return false

func abort() -> void:
	_completion[2].call()

func get_power() -> float:
	return _power

@abstract
func resolve_target(p0: float, p1: float, v0: float) -> float

#-------------------------------------------------------------------------------

const _VELOCITY_CLASS := preload("uid://dqiqctycfqw4m")
const _POSITION_CLASS := preload("uid://df5qr5rax1d22")

const _NEW_MAP: Array[Callable] = [
	_VELOCITY_CLASS.new,
	_POSITION_CLASS.new,
]

var _completion: Array
var _process: int
var _duration: float
var _initial_position: Variant
var _final_position: Variant
var _initial_velocity: Variant
var _power: float
var _time_constant: float
var _rest_delta: float

func _get_rest_time(p0: float, p1: float, v0: float) -> float:
	p1 = resolve_target(p0, p1, v0)
	var d := p1 - p0
	if _rest_delta < absf(d):
		return _time_constant * log(absf(d) / _rest_delta)
	return 0.0

func _init(
	completion: Array,
	process: int,
	initial_position: Variant,
	final_position: Variant,
	initial_velocity: Variant,
	power: float,
	time_constant: float,
	rest_delta: float) -> void:

	_completion = completion
	_process = process
	_initial_position = initial_position
	_final_position = final_position
	_initial_velocity = initial_velocity
	_power = power
	_time_constant = time_constant
	_rest_delta = rest_delta
