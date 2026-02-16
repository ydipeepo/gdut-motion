class_name GDUT_IrregularMotionPresetPreview extends GDUT_PerceivedMotionPresetPreview

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func reset() -> void:
	var preset := get_preset() as IrregularMotionPreset
	var count := preset.segments + 1
	var i2 := 1
	var y1: float
	var y2 := 0.0
	_y_array.clear()
	_y_array.append(y2)
	while i2 < count:
		var spacing := i2 / float(count)
		var segment_end := (i2 + 1) / float(count)
		var random_variation := spacing + (segment_end - spacing) * randf()
		var random := spacing * (1.0 - preset.intensity) + random_variation * preset.intensity
		y1 = y2
		y2 = clampf(random, y1, 1.0)
		i2 += 1
		_y_array.append(y2)
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

var _y_array: PackedFloat32Array
