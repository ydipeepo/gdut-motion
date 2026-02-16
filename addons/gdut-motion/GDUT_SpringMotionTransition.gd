class_name GDUT_SpringMotionTransition extends GDUT_PhysicsMotionTransition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_STIFFNESS := EPSILON
const DEFAULT_STIFFNESS := 100.0

const MIN_DAMPING := 0.0
const DEFAULT_DAMPING := 10.0

const MIN_MASS := EPSILON
const DEFAULT_MASS := 1.0

const MIN_REST_DELTA := EPSILON
const DEFAULT_REST_DELTA := 0.01

const MIN_REST_SPEED := EPSILON
const DEFAULT_REST_SPEED := 0.01

const DEFAULT_LIMIT_OVERDAMPING := true

const DEFAULT_LIMIT_OVERSHOOTING := false

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
func physics_init(state: GDUT_MotionState) -> void:
=======
func get_duration_approx(state: GDUT_MotionState) -> float:
	return 0.0

func reset(state: GDUT_MotionState) -> void:
	var rest_delta_sq := _rest_delta * _rest_delta
	var rest_speed_sq := _rest_speed * _rest_speed

>>>>>>> Stashed changes
	var stride := state.get_value_size()
	for i: int in state.get_array_size():
		var offset := i * stride
		var d_sq := 0.0
		var v_sq := 0.0
		for j: int in stride:
			var k := offset + j
			var p0 := state.get_initial_position_at(k)
			var p1 := state.get_final_position_at(k)
			var v0 := state.get_initial_velocity_at(k)
			var v := v0
			var d := p1 - p0
			d_sq += d * d
			v_sq += v * v
<<<<<<< Updated upstream
		if v_sq <= _rest_speed_sq and d_sq <= _rest_delta_sq:
=======
		if v_sq <= rest_speed_sq and d_sq <= rest_delta_sq:
>>>>>>> Stashed changes
			for j: int in stride:
				var k := offset + j
				var p := state.get_final_position_at(k)
				var v := 0.0
				state.set_position_at(k, p)
				state.set_velocity_at(k, v)
<<<<<<< Updated upstream
				state.set_rest_at(k, true)
=======
				state.set_rest_at(k)
>>>>>>> Stashed changes
		else:
			for j: int in stride:
				var k := offset + j
				var p0 := state.get_initial_position_at(k)
				var v0 := state.get_initial_velocity_at(k)
				var p := p0
				var v := v0
				state.set_position_at(k, p)
				state.set_velocity_at(k, v)
<<<<<<< Updated upstream
				state.set_rest_at(k, false)

func physics_next(state: GDUT_MotionState, t: float) -> bool:
	#
	# This damped harmonic oscillator model
	# from 'wobbly' by Adam Miskiewicz (@skevy).
	#
	# Quote:
	# //github.com/skevy/wobble?tab=readme-ov-file#math
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

=======
				state.clear_rest_at(k)

func solve(state: GDUT_MotionState, t: float) -> bool:
>>>>>>> Stashed changes
	var neg_omega0_t := -_omega0 * t
	var exp_neg_omega0_t := exp(neg_omega0_t)
	var exp_neg_omega0_t_zeta := exp(neg_omega0_t * _zeta)
	var omega2_t := minf(_omega2 * t, _MAX_OMEGA2_T)
	var cos_omega1_t := cos(_omega1 * t)
	var sin_omega1_t := sin(_omega1 * t)
	var cosh_omega2_t := cosh(omega2_t)
	var sinh_omega2_t := sinh(omega2_t)

<<<<<<< Updated upstream
=======
	var rest_delta_sq := _rest_delta * _rest_delta
	var rest_speed_sq := _rest_speed * _rest_speed

>>>>>>> Stashed changes
	var stride := state.get_value_size()
	var all_at_rest := true
	for i: int in state.get_array_size():
		var offset := i * stride
		var d_sq := 0.0
		var v_sq := 0.0
		var at_rest := true
		for j: int in stride:
			var k := offset + j
			if not state.get_rest_at(k):
				var p0 := state.get_initial_position_at(k)
				var p1 := state.get_final_position_at(k)
				var v0 := state.get_initial_velocity_at(k)
				var d := p1 - p0
				var p: float
				var v: float
				if _zeta < 1.0:
					var e := exp_neg_omega0_t_zeta
					var u := _zeta * _omega0 * d - v0
					p = p1 - e * (u / _omega1 * sin_omega1_t + d * cos_omega1_t)
					v = e * _zeta * _omega0 * (sin_omega1_t * u / _omega1 + d * cos_omega1_t) - e * (cos_omega1_t * u - _omega1 * d * sin_omega1_t)
				elif _zeta == 1.0:
					var e := exp_neg_omega0_t
					p = p1 - e * (d + (-v0 + _omega0 * d) * t)
					v = e * (-v0 * (t * _omega0 - 1.0) + t * d * _omega0 * _omega0)
				else:
					var e := exp_neg_omega0_t_zeta
					var u := _zeta * _omega0 * d - v0
					p = p1 - e * (u * sinh_omega2_t + _omega2 * d * cosh_omega2_t) / _omega2
					v = e * _zeta * _omega0 * (sinh_omega2_t * u + d * _omega2 * cosh_omega2_t) / _omega2 - e * (_omega2 * cosh_omega2_t * u + _omega2 * _omega2 * d * sinh_omega2_t) / _omega2
				if _limit_overshooting and (p1 < p if p0 < p1 else p < p1):
					p = p1
					v = 0.0
					state.set_position_at(k, p)
					state.set_velocity_at(k, v)
<<<<<<< Updated upstream
					state.set_rest_at(k, true)
=======
					state.set_rest_at(k)
>>>>>>> Stashed changes
				else:
					d = p1 - p
					d_sq += d * d
					v_sq += v * v
					state.set_position_at(k, p)
					state.set_velocity_at(k, v)
					at_rest = false
		if not at_rest:
<<<<<<< Updated upstream
			if v_sq <= _rest_speed_sq and d_sq <= _rest_delta_sq:
=======
			if v_sq <= rest_speed_sq and d_sq <= rest_delta_sq:
>>>>>>> Stashed changes
				for j: int in stride:
					var k := offset + j
					if not state.get_rest_at(k):
						var p1 := state.get_final_position_at(k)
						var p := p1
						var v := 0.0
						state.set_position_at(k, p)
						state.set_velocity_at(k, v)
<<<<<<< Updated upstream
						state.set_rest_at(k, true)
=======
						state.set_rest_at(k)
>>>>>>> Stashed changes
			all_at_rest = false
	return all_at_rest

#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
=======
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

>>>>>>> Stashed changes
const _MAX_OMEGA2_T := 350.0

var _zeta: float
var _omega0: float
var _omega1: float
var _omega2: float
<<<<<<< Updated upstream
var _rest_delta_sq: float
var _rest_speed_sq: float
=======
var _rest_delta: float
var _rest_speed: float
>>>>>>> Stashed changes
var _limit_overshooting: bool

func _init(
	stiffness: float,
	damping: float,
	mass: float,
	rest_delta: float,
	rest_speed: float,
	limit_overdamping: bool,
	limit_overshooting: bool,
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

	assert(MIN_STIFFNESS <= stiffness)
	assert(MIN_DAMPING <= damping)
	assert(MIN_MASS <= mass)
	assert(MIN_REST_DELTA <= rest_delta)
	assert(MIN_REST_SPEED <= rest_speed)

	var zeta := damping / (2.0 * sqrt(stiffness * mass))
	var zeta_sq := zeta * zeta
	var omega := sqrt(stiffness / mass)

	_zeta = minf(1.0, zeta) if limit_overdamping else zeta
	_omega0 = omega
	_omega1 = omega * sqrt(1.0 - zeta_sq)
	_omega2 = omega * sqrt(zeta_sq - 1.0)
<<<<<<< Updated upstream
	_rest_delta_sq = rest_delta * rest_delta
	_rest_speed_sq = rest_speed * rest_speed
=======
	_rest_delta = rest_delta
	_rest_speed = rest_speed
>>>>>>> Stashed changes
	_limit_overshooting = limit_overshooting
