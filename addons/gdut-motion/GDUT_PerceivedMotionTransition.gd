@abstract
class_name GDUT_PerceivedMotionTransition extends GDUT_MotionTransition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_DURATION := 0.0
const DEFAULT_DURATION := 1.0

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_completion() -> Task:
	return _completion[0]

func get_process() -> int:
	return _process

func finish(state: GDUT_MotionState) -> void:
	_completion[1].call(state.get_velocity())

func cancel() -> void:
	_completion[2].call()

func next(
	state: GDUT_MotionState,
	timer: GDUT_MotionTimer) -> GDUT_MotionTransition:

	if _first_call:
		state.create_initial_position(_initial_position)
		state.create_final_position(_final_position)

		@warning_ignore("confusable_local_declaration")
		var dy := get_prime(0.0)
		for k: int in state.get_array_size() * state.get_value_size():
			var p0 := state.get_initial_position_at(k)
			var p1 := state.get_final_position_at(k)
			var p := p0
			var v := (p1 - p0) * dy * _inv_duration
			state.set_position_at(k, p)
			state.set_velocity_at(k, v)
			state.set_rest_at(k, false)
		_first_call = false

	_elapsed_ticks += timer.delta_ticks

	if _elapsed_ticks < _duration_ticks - _trim_ticks:
		var x := float(_elapsed_ticks) / float(_duration_ticks)
		var y := get_value(x)
		@warning_ignore("confusable_local_declaration")
		var dy := get_prime(x)
		for k: int in state.get_array_size() * state.get_value_size():
			var p0 := state.get_initial_position_at(k)
			var p1 := state.get_final_position_at(k)
			var p := lerpf(p0, p1, y)
			var v := (p1 - p0) * dy * _inv_duration
			state.set_position_at(k, p)
			state.set_velocity_at(k, v)
		timer.delta_ticks = 0
		return self

	var dy := get_prime(1.0)
	for k: int in state.get_array_size() * state.get_value_size():
		var p0 := state.get_initial_position_at(k)
		var p1 := state.get_final_position_at(k)
		var p := p1
		var v := (p1 - p0) * dy * _inv_duration
		state.set_position_at(k, p)
		state.set_velocity_at(k, v)
		state.set_rest_at(k, true)
	timer.delta_ticks = _elapsed_ticks - (_duration_ticks - _trim_ticks)
	finish(state)
	return null

@abstract
func get_value(x: float) -> float

@abstract
func get_prime(x: float) -> float

#-------------------------------------------------------------------------------

var _first_call := true
var _elapsed_ticks: int

var _inv_duration: float
var _duration_ticks: int
var _trim_ticks: int
var _initial_position: Variant
var _final_position: Variant
var _process: int
var _completion: Array

func _init(
	duration: float,
	initial_position: Variant,
	final_position: Variant,
	process: int,
	completion: Array) -> void:

	assert(MIN_DURATION <= duration)
	assert(process in VALID_PROCESS)
	assert(completion.size() == 3)

	_inv_duration = 1.0 / duration
	_duration_ticks = roundi(duration * 1000.0)
	_initial_position = initial_position
	_final_position = final_position
	_process = process
	_completion = completion
