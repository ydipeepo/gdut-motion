class_name GDUT_MotionTimer

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

var delta_ticks: int:
	get:
		return _delta_ticks
	set(value):
		_delta_ticks = maxi(value, 0)

var total_ticks: int:
	get:
		return _total_ticks

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

#static func get_raw_ticks() -> int:
#	return Time.get_ticks_msec()

func is_delta_ticks_left() -> bool:
	return 0 < _delta_ticks

func reset() -> void:
	_last_raw_ticks = GDUT_Motion.get_ticks()
	_delta_ticks = 0
	_total_ticks = 0
	_kahan_compensation = 0.0
	_kahan_accumulated_sum = 0.0

func tick() -> void:
	var raw_delta_ticks := _get_raw_delta_ticks()
	var time_scale := GDUT_Motion.get_composite_time_scale()
	if time_scale == 1.0:
		_delta_ticks = raw_delta_ticks
	elif time_scale == 0.0:
		_delta_ticks = 0
	else:
		_delta_ticks = _kahan_scale(raw_delta_ticks, time_scale)
	_total_ticks += _delta_ticks

#-------------------------------------------------------------------------------

var _last_raw_ticks: int
var _delta_ticks: int
var _total_ticks: int
var _kahan_compensation: float
var _kahan_accumulated_sum: float

func _get_raw_delta_ticks() -> int:
	var raw_ticks := GDUT_Motion.get_ticks()
	var raw_delta_ticks := raw_ticks - _last_raw_ticks
	_last_raw_ticks = raw_ticks
	return raw_delta_ticks

func _kahan_scale(ticks: int, scale: float) -> int:
	var y := ticks * scale - _kahan_compensation
	var t := _kahan_accumulated_sum + y
	_kahan_compensation = (t - _kahan_accumulated_sum) - y
	_kahan_accumulated_sum = t

	ticks = int(_kahan_accumulated_sum)
	_kahan_accumulated_sum -= ticks
	return ticks
