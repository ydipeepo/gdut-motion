class_name GDUT_SpringMotionPresetPreview extends GDUT_PhysicsMotionPresetPreview

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_duration() -> float:
	return _duration_approx

func get_minimum_initial_velocity() -> float:
	return -50.0

func get_maximum_initial_velocity() -> float:
	return 50.0

func reset() -> void:
	var preset := get_preset() as SpringMotionPreset
	var zeta := preset.damping / (2.0 * sqrt(preset.stiffness * preset.mass))
	var zeta_sq := zeta * zeta
	var omega := sqrt(preset.stiffness / preset.mass)
	_zeta = minf(1.0, zeta) if preset.limit_overdamping else zeta
	_omega0 = omega
	_omega1 = omega * sqrt(1.0 - zeta_sq)
	_omega2 = omega * sqrt(zeta_sq - 1.0)
	_rest_delta = preset.rest_delta
	_rest_speed = preset.rest_speed
	_duration_approx = _get_duration_approx(preset.limit_overshooting)

func solve(t: float) -> float:
	var v0 := get_initial_velocity()
	var p: float
	var v: float
	if _zeta < 1.0:
		var cos_omega1_t := cos(_omega1 * t)
		var sin_omega1_t := sin(_omega1 * t)
		var e := exp(-_omega0 * t * _zeta)
		var u := _zeta * _omega0 - v0
		p = 1.0 - e * (u / _omega1 * sin_omega1_t + cos_omega1_t)
		v = e * _zeta * _omega0 * (sin_omega1_t * u / _omega1 + cos_omega1_t) - e * (cos_omega1_t * u - _omega1 * sin_omega1_t)
	elif _zeta == 1.0:
		var e := exp(-_omega0 * t)
		p = 1.0 - e * (1.0 + (-v0 + _omega0) * t)
		v = e * (-v0 * (t * _omega0 - 1.0) + t * _omega0 * _omega0)
	else:
		var omega2_t := minf(_omega2 * t, _MAX_OMEGA2_T)
		var cosh_omega2_t := cosh(omega2_t)
		var sinh_omega2_t := sinh(omega2_t)
		var e := exp(-_omega0 * t * _zeta)
		var u := _zeta * _omega0 - v0
		p = 1.0 - e * (u * sinh_omega2_t + _omega2 * cosh_omega2_t) / _omega2
		v = e * _zeta * _omega0 * (sinh_omega2_t * u + _omega2 * cosh_omega2_t) / _omega2 - e * (_omega2 * cosh_omega2_t * u + _omega2 * _omega2 * sinh_omega2_t) / _omega2
	return p

#-------------------------------------------------------------------------------

const _MAX_OMEGA2_T := 350.0

var _zeta: float
var _omega0: float
var _omega1: float
var _omega2: float
var _rest_delta: float
var _rest_speed: float
var _duration_approx: float

func _get_duration_approx(limit_overshooting: bool) -> float:
	var t_rest := INF
	var v := get_initial_velocity()
	if _zeta < 1.0:
		if limit_overshooting:
			var u := _zeta * _omega0 - v
			if not is_zero_approx(u):
				var t := atan2(-_omega1, u) / _omega1
				if t < 0.0:
					t += PI / _omega1
				t_rest = maxf(t, 0.0)
		var l := _zeta * _omega0
		var u := l - v
		var a := sqrt(1.0 + pow(u / _omega1, 2))
		var b := a * sqrt(pow(l * _zeta, 2) + pow(_omega1, 2))
		t_rest = minf(
			t_rest,
			maxf(
				log(a / _rest_delta) / l,
				log(b / _rest_speed) / l))
	elif _zeta == 1.0:
		var l := _omega0
		var a := 1.0 + absf(v - l) / l
		var b := absf(v) + absf(l)
		t_rest = minf(
			t_rest,
			maxf(
				log(a / _rest_delta) / l,
				log(b / _rest_speed) / l))
	else:
		var l := _omega0 * (_zeta - sqrt(_zeta * _zeta - 1.0))
		var a := 1.0
		var b := absf(v) + absf(l)
		t_rest = minf(
			t_rest,
			maxf(
				log(a / _rest_delta) / l,
				log(b / _rest_speed) / l))
	return maxf(t_rest, 0.0)
