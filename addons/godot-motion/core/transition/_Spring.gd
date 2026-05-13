#
# Based on 'wobbly' (@skevy) implementation:
# //github.com/skevy/wobble/blob/develop/src/index.ts
#
# > The ODE for damped harmonic motion is:
# > $$
# > \frac{\mathrm{d}^2x}{\mathrm{d}t^2}+2\zeta\omega_0\frac{\mathrm{d}x}{\mathrm{d}t}+\omega_0^2x = 0
# > $$
# >
# > Solving this ODE yields:
# > $$
# > x(t) = \frac{e^{-\zeta\omega_0^t}}{\omega_2}\lbrace(v_0+\zeta\omega_0x_0)\sinh\omega_2t+\omega_2x_0\cosh\omega_2t\rbrace
# > $$
# >
# > And from this general solution, we're able to easily derive the solutions for
# > under-damped, critically-damped, and over-damped damped harmonic oscillation.
#

@abstract
extends MotionTransition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MAX := 1e20
const EPS := 1e-5

const MIN_STIFFNESS := 1e-4

const MIN_DAMPING := 1e-4

const MIN_MASS := 1e-4

const MIN_REST_ENERGY := 1e-4

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func create(
	completion: Array,
	process: int,
	initial_position: Variant,
	final_position: Variant,
	initial_velocity: Variant,
	stiffness: float,
	damping: float,
	mass: float,
	rest_energy: float,
	limit_overdamping: bool,
	limit_overshooting: bool) -> MotionTransition:

	assert(completion.size() == 3)
	assert(process in VALID_PROCESS)
	assert(MIN_STIFFNESS <= stiffness)
	assert(MIN_DAMPING <= damping)
	assert(MIN_MASS <= mass)
	assert(MIN_REST_ENERGY <= rest_energy)

	var zeta := damping / (2.0 * sqrt(stiffness * mass))
	var zeta_sq := zeta * zeta
	var omega := Vector3.ZERO
	omega.x = sqrt(stiffness / mass)
	omega.y = omega.x * sqrt(maxf(0.0, 1.0 - zeta_sq))
	omega.z = omega.x * sqrt(maxf(0.0, zeta_sq - 1.0))

	if zeta != 1.0:
		if zeta < 1.0:
			return _UNDERDAMPED_CLASS.new(
				completion,
				process,
				initial_position,
				final_position,
				initial_velocity,
				stiffness,
				damping,
				mass,
				rest_energy,
				limit_overshooting,
				zeta,
				omega)
		elif not limit_overdamping:
			return _OVERDAMPED_CLASS.new(
				completion,
				process,
				initial_position,
				final_position,
				initial_velocity,
				stiffness,
				damping,
				mass,
				rest_energy,
				limit_overshooting,
				zeta,
				omega)
		zeta = 1.0
		zeta_sq = 1.0
		omega.y = 0.0
		omega.z = 0.0
	return _CRITICALLY_DAMPED_CLASS.new(
		completion,
		process,
		initial_position,
		final_position,
		initial_velocity,
		stiffness,
		damping,
		mass,
		rest_energy,
		limit_overshooting,
		zeta,
		omega)

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
			if not _is_at_rest(p0, p1, v0, 0.0):
				active = true
				break
		if active:
			for j: int in stride:
				var k := offset + j
				var p0 := state.get_initial_position_at(k)
				var p1 := state.get_final_position_at(k)
				var v0 := state.get_initial_velocity_at(k)
				var pv := solve_pv(p0, p1, v0, 0.0)
				var p := pv.x
				var v := pv.y
				state.set_position_at(k, p)
				state.set_velocity_at(k, v)
				state.clear_rest_at(k)
				_duration = maxf(_get_rest_time(p0, p1, v0), _duration)
		else:
			for j: int in stride:
				var k := offset + j
				var p1 := state.get_final_position_at(k)
				var v0 := state.get_initial_velocity_at(k)
				var p := p1
				var v := 0.0
				state.set_position_at(k, p)
				state.set_velocity_at(k, v)
				state.set_rest_at(k)

func apply(state: MotionState, timer: MotionTimer) -> bool:
	var t := timer.get_total()
	var any_active := false
	var stride := state.get_value_size()
	for i: int in state.get_array_size():
		var offset := i * stride
		var active := false
		for j: int in stride:
			var k := offset + j
			if not state.get_rest_at(k):
				var p0 := state.get_initial_position_at(k)
				var p1 := state.get_final_position_at(k)
				var v0 := state.get_initial_velocity_at(k)
				if not _is_at_rest(p0, p1, v0, t):
					active = true
					break
		if active:
			for j: int in stride:
				var k := offset + j
				if not state.get_rest_at(k):
					var p0 := state.get_initial_position_at(k)
					var p1 := state.get_final_position_at(k)
					var v0 := state.get_initial_velocity_at(k)
					var pv := solve_pv(p0, p1, v0, t)
					var p := pv.x
					var v := pv.y
					state.set_position_at(k, p)
					state.set_velocity_at(k, v)
			any_active = true
		else:
			for j: int in stride:
				var k := offset + j
				if not state.get_rest_at(k):
					var p1 := state.get_final_position_at(k)
					var p := p1
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

func get_zeta() -> float:
	return _zeta

func get_omega(index: int) -> float:
	return _omega[index]

@abstract
func get_cross_t(p0: float, p1: float, v0: float) -> float

@abstract
func solve_pv(p0: float, p1: float, v0: float, t: float) -> Vector2

func solve_pvE(p0: float, p1: float, v0: float, t: float) -> Vector3:
	var pv := solve_pv(p0, p1, v0, t)
	var x := pv.x - p1
	var E := (pv.y * pv.y * _mass + x * x * _stiffness) * 0.5
	return Vector3(pv.x, pv.y, E)

#-------------------------------------------------------------------------------

const _UNDERDAMPED_CLASS := preload("uid://csei1b1j8s42i")
const _CRITICALLY_DAMPED_CLASS := preload("uid://bpdpba8nvrhsq")
const _OVERDAMPED_CLASS := preload("uid://d2yccg1rse2il")

const _MAX_REST_TIME := 100.0

var _completion: Array
var _process: int
var _duration: float
var _initial_position: Variant
var _final_position: Variant
var _initial_velocity: Variant
var _stiffness: float
var _damping: float
var _mass: float
var _rest_energy: float
var _limit_overshooting: bool
var _zeta: float
var _omega: Vector3

func _is_at_rest(p0: float, p1: float, v0: float, t: float) -> bool:
	if _limit_overshooting:
		var t_cross := get_cross_t(p0, p1, v0)
		if t_cross <= t:
			return true

	var pvE := solve_pvE(p0, p1, v0, t)
	return pvE.z <= _rest_energy

func _get_rest_time(p0: float, p1: float, v0: float) -> float:
	if _limit_overshooting:
		var t_cross := get_cross_t(p0, p1, v0)
		if t_cross < INF:
			return t_cross

	var t := 1.0 / _omega.x
	var log_rest_energy := log(_rest_energy)
	for i: int in 12:
		var pvE := solve_pvE(p0, p1, v0, t)
		var v := pvE.y
		var E := pvE.z
		if E <= _rest_energy:
			return t
		var dEdt := -_damping * v * v
		if abs(dEdt) < 1e-8 or E <= 0.0:
			break
		var diff := log(E) - log_rest_energy
		var dlogEdt := dEdt / E
		if abs(dlogEdt) < 1e-8:
			break
		var dt := -diff / dlogEdt
		dt = clampf(dt, -0.5, 0.5)
		if E < _rest_energy * 10.0:
			dt *= 0.5
		if dt < 0.0:
			dt = 0.0
		t += dt

	var t_min := 0.0
	var t_max := 1.0 / _omega.x
	while t_max < _MAX_REST_TIME:
		if _is_at_rest(p0, p1, v0, t_max):
			break
		t_max *= 2.0
	for i: int in 16:
		var t_mid := 0.5 * (t_min + t_max)
		if _is_at_rest(p0, p1, v0, t_mid):
			t_max = t_mid
		else:
			t_min = t_mid
	return minf(t_max, _MAX_REST_TIME)

func _init(
	completion: Array,
	process: int,
	initial_position: Variant,
	final_position: Variant,
	initial_velocity: Variant,
	stiffness: float,
	damping: float,
	mass: float,
	rest_energy: float,
	limit_overshooting: bool,
	zeta: float,
	omega: Vector3) -> void:

	_completion = completion
	_process = process
	_initial_position = initial_position
	_final_position = final_position
	_initial_velocity = initial_velocity
	_stiffness = stiffness
	_damping = damping
	_mass = mass
	_rest_energy = rest_energy
	_limit_overshooting = limit_overshooting
	_zeta = zeta
	_omega = omega
