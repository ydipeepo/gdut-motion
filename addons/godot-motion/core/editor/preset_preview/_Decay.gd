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
	return 0.0

func get_max_initial_velocity() -> float:
	return 5.0

func get_duration() -> float:
	return _duration

func get_position_(t: float) -> float:
	if t < 0.0:
		return _P0

	var p1 := _resolve_target()
	var d := p1 - _P0
	var a := exp(-t / _time_constant)
	if absf(d) * a <= _rest_delta:
		return p1
	return p1 - d * a

func get_velocity(t: float) -> float:
	if t < 0.0:
		return 0.0

	var p1 := _resolve_target()
	var d := p1 - _P0
	var a := exp(-t / _time_constant)
	if absf(d) * a <= _rest_delta:
		return 0.0
	return (d / _time_constant) * a

func reset() -> void:
	var preset := get_resource() as DecayMotionPreset
	_prefer = preset.get_prefer()
	_power = preset.get_power()
	_time_constant = preset.get_time_constant()
	_rest_delta = preset.get_rest_delta()

	var p1 := _resolve_target()
	var d := p1 - _P0
	if absf(d) <= _rest_delta:
		_duration = 0.0
	else:
		_duration = _time_constant * log(absf(d) / _rest_delta)

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

const _P0 := 0.0
const _P1 := 1.0
const _V0_COLOR := Color.BLUE

var _v0 := 0.0
var _duration: float
var _power: float
var _time_constant: float
var _rest_delta: float
var _prefer: int

func _resolve_target() -> float:
	var target := _P1
	if _prefer == DecayMotionPreset.PREFER_VELOCITY:
		target = _P0 + _v0 * _power
	return target

func _get_rest_time() -> float:
	var p1 := _resolve_target()
	var d := p1 - _P0
	if absf(d) <= _rest_delta:
		return 0.0
	return _time_constant * log(absf(d) / _rest_delta)
