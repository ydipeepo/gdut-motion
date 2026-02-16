@abstract
class_name GDUT_PhysicsMotionTransition extends GDUT_MotionTransition

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_completion() -> Task:
	return _completion[0]

func get_process() -> int:
	return _process

@abstract
func get_duration_approx(state: GDUT_MotionState) -> float

@abstract
func reset(state: GDUT_MotionState) -> void

@abstract
func solve(state: GDUT_MotionState, t: float) -> bool

func next(
	state: GDUT_MotionState,
	timer: GDUT_MotionTimer) -> GDUT_MotionTransition:

	if _first_call:
		state.reset_initial_position(_initial_position)
		state.reset_final_position(_final_position)
		state.reset_initial_velocity(_initial_velocity)

		reset(state)

		_first_call = false

	_elapsed_ticks += timer.delta_ticks

	timer.delta_ticks = 0

	if not solve(state, _elapsed_ticks / 1000.0):
		return self

	finish(state)
	return null

func finish(state: GDUT_MotionState) -> void:
	_completion[1].call(state.get_velocity())

func cancel() -> void:
	_completion[2].call()

#-------------------------------------------------------------------------------

var _first_call := true
var _elapsed_ticks: int

var _initial_position: Variant
var _final_position: Variant
var _initial_velocity: Variant
var _process: int
var _completion: Array

func _init(
	initial_position: Variant,
	final_position: Variant,
	initial_velocity: Variant,
	process: int,
	completion: Array) -> void:

	assert(process in VALID_PROCESS)
	assert(completion.size() == 3)

	_initial_position = initial_position
	_final_position = final_position
	_initial_velocity = initial_velocity
	_process = process
	_completion = completion
