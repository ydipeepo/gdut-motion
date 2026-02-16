class_name GDUT_IrregularMotionTransition extends GDUT_PerceivedMotionTransition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_SEGMENTS := 1
const DEFAULT_SEGMENTS := 10

const MIN_INTENSITY := 0.0
const MAX_INTENSITY := 4.0
const DEFAULT_INTENSITY := 0.5

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_value(x: float) -> float:
	if 1.0 <= x:
		return 1.0
	var count := _y_array.size() - 1
	var i1 := floori(x * count)
	var i2 := i1 + 1
	return lerpf(
		_y_array[i1],
		_y_array[i2],
		fmod(x * count, 1.0))

func get_prime(x: float) -> float:
	var count := _y_array.size() - 1
	var i1 := \
		count - 1 \
		if 1.0 <= x else \
		floori(x * count)
	var i2 := i1 + 1
	return (_y_array[i2] - _y_array[i1]) * count

#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
=======
#
# Based on Anime.js (@juliangarnier) implementation:
# //github.com/juliangarnier/anime/blob/master/src/easings/irregular/index.js
#

>>>>>>> Stashed changes
var _y_array: PackedFloat32Array

func _init(
	segments: int,
	intensity: float,
	duration: float,
	initial_position: Variant,
	final_position: Variant,
	process: int,
	completion: Array) -> void:

	super(
		duration,
		initial_position,
		final_position,
		process,
		completion)

	assert(MIN_SEGMENTS <= segments)
	assert(MIN_INTENSITY <= intensity and intensity <= MAX_INTENSITY)

	var count := segments + 1
	var i2 := 1
	var y1: float
	var y2 := 0.0
	_y_array.append(y2)
	while i2 < count:
		var spacing := i2 / float(count)
		var segment_end := (i2 + 1) / float(count)
		var random_variation := spacing + (segment_end - spacing) * randf()
		var random := spacing * (1.0 - intensity) + random_variation * intensity
		y1 = y2
		y2 = clampf(random, y1, 1.0)
		i2 += 1
		_y_array.append(y2)
	_y_array.append(1.0)
