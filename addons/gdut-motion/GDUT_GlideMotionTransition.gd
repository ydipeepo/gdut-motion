class_name GDUT_GlideMotionTransition extends GDUT_PhysicsMotionTransition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_POWER := EPSILON
const DEFAULT_POWER := 0.8

const MIN_TIME_CONSTANT := 0.0
const DEFAULT_TIME_CONSTANT := 0.35

const MIN_REST_DELTA := EPSILON
const DEFAULT_REST_DELTA := 0.01

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func physics_init(state: GDUT_MotionState) -> void:
	var stride := state.get_value_size()
	for i: int in state.get_array_size():
		var offset := i * stride
		var d_sq := 0.0
		for j: int in stride:
			var k := offset + j
			var p0: float
			var p1: float
			if _final_position == null:
				var v0 := state.get_initial_velocity_at(k)
				p0 = state.get_initial_position_at(k)
				p1 = p0 + v0 * _power
				state.set_final_position_at(k, p1)
			else:
				p0 = state.get_initial_position_at(k)
				p1 = state.get_final_position_at(k)
			var d := p1 - p0
			d_sq += d * d
		if d_sq <= _rest_delta_sq:
			for j: int in stride:
				var k := offset + j
				var p1 := state.get_final_position_at(k)
				var p := p1
				var v := 0.0
				state.set_position_at(k, p)
				state.set_velocity_at(k, v)
				state.set_rest_at(k, true)
		else:
			for j: int in stride:
				var k := offset + j
				var p0 := state.get_initial_position_at(k)
				var p1 := state.get_final_position_at(k)
				var p := p0
				var d := p1 - p0
				var v := d / _time_constant
				state.set_position_at(k, p)
				state.set_velocity_at(k, v)
				state.set_rest_at(k, false)

func physics_next(state: GDUT_MotionState, t: float) -> bool:
	var exp_neg_t := exp(-t / _time_constant)

	var stride := state.get_value_size()
	var all_at_rest := true
	for i: int in state.get_array_size():
		var offset := i * stride
		var d_sq := 0.0
		for j: int in stride:
			var k := offset + j
			var p0 := state.get_initial_position_at(k)
			var p1 := state.get_final_position_at(k)
			var d := (p1 - p0) * exp_neg_t
			var p := p1 - d
			var v := d / _time_constant
			state.set_position_at(k, p)
			state.set_velocity_at(k, v)
			d_sq += d * d
		if d_sq <= _rest_delta_sq:
			for j: int in stride:
				var k := offset + j
				var p1 := state.get_final_position_at(k)
				var p := p1
				var v := 0.0
				state.set_position_at(k, p)
				state.set_velocity_at(k, v)
				state.set_rest_at(k, true)
		else:
			all_at_rest = false
	return all_at_rest

#-------------------------------------------------------------------------------

var _power: float
var _time_constant: float
var _rest_delta_sq: float

func _init(
	power: float,
	time_constant: float,
	rest_delta: float,
	initial_position: Variant,
	final_position: Variant,
	initial_velocity: Variant,
	process: int,
	completion: Array) -> void:

	super(
		initial_position,
		final_position,
		initial_velocity,
		process,
		completion)

	assert(MIN_POWER <= power)
	assert(MIN_TIME_CONSTANT <= time_constant)
	assert(MIN_REST_DELTA <= rest_delta)

	_power = power
	_time_constant = time_constant
	_rest_delta_sq = rest_delta * rest_delta
