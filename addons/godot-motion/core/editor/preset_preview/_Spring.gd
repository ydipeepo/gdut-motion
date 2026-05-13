extends "../_PresetPreview.gd"

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func has_initial_velocity() -> bool:
	return true

func set_initial_velocity(value: float) -> void:
	_v0 = value
	super(value)

func get_initial_velocity() -> float:
	return _v0

func get_min_initial_velocity() -> float:
	return -25.0

func get_max_initial_velocity() -> float:
	return 25.0

func get_duration() -> float:
	return _duration

func get_position_(t: float) -> float:
	var pv := _solve_pv(t)
	return pv.x

func get_velocity(t: float) -> float:
	var pv := _solve_pv(t)
	return pv.y

func reset() -> void:
	var preset := get_resource() as SpringMotionPreset
	var zeta := preset.get_damping() / (2.0 * sqrt(preset.get_stiffness() * preset.get_mass()))
	var zeta_sq := zeta * zeta
	var omega := Vector3.ZERO
	omega.x = sqrt(preset.get_stiffness() / preset.get_mass())
	omega.y = omega.x * sqrt(maxf(0.0, 1.0 - zeta_sq))
	omega.z = omega.x * sqrt(maxf(0.0, zeta_sq - 1.0))

	_mode = _MODE_CRITICAL
	if zeta != 1.0:
		if zeta < 1.0:
			_mode = _MODE_UNDER
		elif not preset.get_limit_overdamping():
			_mode = _MODE_OVER
		else:
			zeta = 1.0
			zeta_sq = 1.0
			omega.y = 0.0
			omega.z = 0.0
	_stiffness = preset.get_stiffness()
	_damping = preset.get_damping()
	_mass = preset.get_mass()
	_rest_energy = preset.get_rest_energy()
	_limit_overshooting = preset.get_limit_overshooting()
	_zeta = zeta
	_omega = omega

	_duration = _get_rest_time()

func draw(transform: Transform2D) -> void:
	super(transform)
	draw_dashed_line(
		transform * Vector2.ZERO,
		transform * Vector2(1.0, _v0 * get_duration()),
		_V0_COLOR,
		0.5,
		3.0,
		true,
		true)

#-------------------------------------------------------------------------------

enum {
	_MODE_UNDER,
	_MODE_CRITICAL,
	_MODE_OVER,
}

const _MAX_OMEGA_T := 500.0
const _MAX_REST_TIME := 100.0
const _MAX := 1e20
const _EPS := 1e-5

const _P0 := 0.0
const _P1 := 1.0
const _V0_COLOR := Color.BLUE

var _v0 := 0.0
var _mode: int
var _duration: float
var _stiffness: float
var _damping: float
var _mass: float
var _rest_energy: float
var _limit_overshooting: bool
var _zeta: float
var _omega: Vector3

func _is_at_rest(t: float) -> bool:
	if _limit_overshooting:
		var t_cross := _get_cross_t()
		if t_cross <= t:
			return true

	var pvE := _solve_pvE(t)
	return pvE.z <= _rest_energy

func _get_cross_t() -> float:
	var A := _P0 - _P1
	if _EPS <= absf(A):
		match _mode:
			_MODE_UNDER:
				var B := (_v0 + _omega.x * _zeta * A) / _omega.y
				if _EPS <= absf(A) or _EPS <= absf(B):
					var phi := atan2(B, A)
					var t_cross := (phi + PI * 0.5) / _omega.y
					var period := PI / _omega.y
					if t_cross <= 0.0:
						t_cross += period * ceilf(-t_cross / period)
					return maxf(0.0, t_cross)
			_MODE_CRITICAL:
				var B := _v0 + _omega.x * A
				if _EPS <= absf(B):
					var t := -A / B
					if 0.0 < t:
						var t_cross := t
						return maxf(0.0, t_cross)
			_MODE_OVER:
				var B := (_v0 + _omega.x * _zeta * A) / _omega.z
				if _EPS <= absf(B):
					var r := -A / B
					if absf(r) < 1.0 - _EPS:
						var t_cross := atanh(r) / _omega.z
						return maxf(0.0, t_cross)
	return _MAX

func _get_rest_time() -> float:
	if _limit_overshooting:
		var t_cross := _get_cross_t()
		if t_cross < INF:
			return t_cross

	var t := 1.0 / _omega.x
	for i: int in 12:
		var pvE := _solve_pvE(t)
		var v := pvE.y
		var E := pvE.z
		if E <= _rest_energy:
			return t
		var dEdt := -_damping * v * v
		if abs(dEdt) < 1e-8 or E <= 0.0:
			break
		var diff := log(E) - log(_rest_energy)
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
	var t_max := 1.0
	while t_max < _MAX_REST_TIME:
		if _is_at_rest(t_max):
			break
		t_max *= 2.0
	for i: int in 16:
		var t_mid := 0.5 * (t_min + t_max)
		if _is_at_rest(t_mid):
			t_max = t_mid
		else:
			t_min = t_mid
	return minf(t_max, _MAX_REST_TIME)

func _solve_pv(t: float) -> Vector2:
	var A := _P0 - _P1
	match _mode:
		_MODE_UNDER:
			var B := (_v0 + _omega.x * _zeta * A) / _omega.y
			if _EPS <= sqrt(A * A + B * B):
				var theta := _omega.y * t
				var c := cos(theta)
				var s := sin(theta)
				var envelope := exp(-_omega.x * _zeta * t)
				var common := A * c + B * s
				return Vector2(
					envelope * common + _P1,
					envelope * (-_omega.x * _zeta * common + (-A * _omega.y * s + B * _omega.y * c)))
		_MODE_CRITICAL:
			var envelope := exp(-_omega.x * _zeta * t)
			var common := A + (_v0 + _omega.x * A) * t
			return Vector2(
				envelope * common + _P1,
				envelope * (-_omega.x * _zeta * common + (_v0 + _omega.x * A)))
		_MODE_OVER:
			var B := (_v0 + _omega.x * _zeta * A) / _omega.z
			var theta := minf(_omega.z * t, _MAX_OMEGA_T)
			var c := cosh(theta)
			var s := sinh(theta)
			var envelope := exp(-_omega.x * _zeta * t)
			var common := A * c + B * s
			return Vector2(
				envelope * common + _P1,
				envelope * (-_omega.x * _zeta * common + (A * _omega.z * s + B * _omega.z * c)))
	return Vector2(_P1, 0.0)

func _solve_pvE(t: float) -> Vector3:
	var pv := _solve_pv(t)
	var x := pv.x - _P1
	var E := (pv.y * pv.y * _mass + x * x * _stiffness) * 0.5
	return Vector3(pv.x, pv.y, E)
