class_name GDUT_GlideMotionPresetPreview extends GDUT_PhysicsMotionPresetPreview

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_duration() -> float:
	return _get_duration()

func get_minimum_initial_velocity() -> float:
	return 0.0

func get_maximum_initial_velocity() -> float:
	return 5.0

func reset() -> void:
	var preset := get_preset() as GlideMotionPreset
	_power = preset.power
	_time_constant = preset.time_constant
	_rest_delta = preset.rest_delta

func solve(t: float) -> float:
	var p1 := _get_final_position()
	var d := p1 * exp(-t / _time_constant)
	var p := p1 - d
	if absf(d) <= _rest_delta:
		p = p1
	return p

#-------------------------------------------------------------------------------

var _power: float
var _time_constant: float
var _rest_delta: float

func _get_final_position() -> float:
	return get_initial_velocity() * _power

func _get_duration() -> float:
	var p1 := _get_final_position()
	var d := absf(p1)
	return \
		0.0 \
		if d <= _rest_delta else \
		_time_constant * log(d / _rest_delta)
