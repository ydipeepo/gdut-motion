class_name GDUT_LinearMotionTransition extends GDUT_PerceivedMotionTransition

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

var _y_array: Array[float]

func _init(
	y_array: Array[float],
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

	_y_array.append(0.0)
	_y_array.append_array(y_array)
	_y_array.append(1.0)
