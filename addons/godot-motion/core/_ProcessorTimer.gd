extends MotionTimer

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_total_ticks() -> int:
	return _total_ticks

func get_delta_ticks() -> int:
	return _delta_ticks

func reset_and_forward_ticks(value: int) -> void:
	_previous_raw_ticks = _AUTOLOAD_CLASS.get_ticks()
	_delta_ticks = 0
	_total_ticks = 0
	_compensation = 0.0
	_accumulated_sum = value * 1000.0

func reset_and_forward(value: float) -> void:
	reset_and_forward_ticks(int(value * 1000.0))

func tick() -> bool:
	var scale := _AUTOLOAD_CLASS.get_composite_time_scale()
	if 0.0 < scale:
		var raw_delta_ticks := _get_raw_delta_ticks()
		var y := raw_delta_ticks * scale - _compensation
		var t := _accumulated_sum + y
		_compensation = (t - _accumulated_sum) - y
		_accumulated_sum = t
		_delta_ticks = int(_accumulated_sum)
		_accumulated_sum -= _delta_ticks
		_total_ticks += _delta_ticks
		if 0 < _delta_ticks:
			return true
	return false

func consume() -> void:
	_total_ticks -= _delta_ticks
	_delta_ticks = 0

#-------------------------------------------------------------------------------

const _AUTOLOAD_CLASS := preload("uid://p04dph4xrfh3")

var _previous_raw_ticks: int
var _total_ticks: int
var _delta_ticks: int
var _compensation: float
var _accumulated_sum: float

func _get_raw_delta_ticks() -> int:
	var raw_ticks := _AUTOLOAD_CLASS.get_ticks()
	var raw_delta_ticks := raw_ticks - _previous_raw_ticks
	_previous_raw_ticks = raw_ticks
	return raw_delta_ticks
