class_name GDUT_LinearMotionPresetPreview extends GDUT_PerceivedMotionPresetPreview

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func reset() -> void:
	var preset := get_preset() as LinearMotionPreset
	_y_array.clear()
	_y_array.append(0.0)
	_y_array.append_array(preset.y_array)
	_y_array.append(1.0)

func solve(t: float) -> float:
	t /= get_duration()
	if 1.0 <= t:
		return 1.0
	var count := _y_array.size() - 1
	var i1 := floori(t * count)
	var i2 := i1 + 1
	return lerpf(
		_y_array[i1],
		_y_array[i2],
		fmod(t * count, 1.0))

#-------------------------------------------------------------------------------

var _y_array: Array[float]
