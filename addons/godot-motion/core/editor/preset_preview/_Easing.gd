extends "../_PresetPreview.gd"

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func is_playable() -> bool:
	return _easing_function != null

func get_duration() -> float:
	return _duration + _delay + _loop * (_duration + _loop_delay)

func get_position_(t: float) -> float:
	var x := _compute_x(t)
	var y := _easing_function.get_value(x)
	var dy := _easing_function.get_slope(x)
	return lerpf(_P0, _P1, y)

func get_velocity(t: float) -> float:
	var x := _compute_x(t)
	var y := _easing_function.get_value(x)
	var dy := _easing_function.get_slope(x)
	var v: float
	if _is_in_delay(t) or _duration == 0.0:
		v = 0.0
	else:
		v = (_P1 - _P0) * dy / _duration
		if _is_flipped(t):
			v = -v
	return v

func reset() -> void:
	var preset := get_resource() as EasingMotionPreset
	var easing := preset.get_easing()
	_duration = preset.get_duration()
	_delay = preset.get_delay()
	_loop = preset.get_loop()
	_loop_delay = preset.get_loop_delay()
	_alternate = preset.get_alternate()
	_reversed = preset.get_reversed()
	_easing_function = easing.create() if is_instance_valid(easing) else null

#-------------------------------------------------------------------------------

const _P0 := 0.0
const _P1 := 1.0

var _duration: float
var _delay: float
var _loop: int
var _loop_delay: float
var _alternate: bool
var _reversed: bool
var _easing_function: EasingFunction

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
