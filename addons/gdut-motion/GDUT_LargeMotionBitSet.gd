class_name GDUT_LargeMotionBitSet extends GDUT_MotionBitSet

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func create(value_size: int, array_size: int) -> GDUT_MotionBitSet:
	return \
		GDUT_SmallMotionBitSet.create(value_size, array_size) \
		if value_size * array_size <= 32 else \
		new(value_size, array_size)

func set_value_at(index: int, value: bool) -> void:
	var mask := 1 << (index & 31)
	if value:
		_array[index >> 5] |=  mask
	else:
		_array[index >> 5] &= ~mask

func get_value_at(index: int) -> bool:
	var mask := 1 << (index & 31)
	return _array[index >> 5] & mask != 0

#-------------------------------------------------------------------------------

var _array: Array[int]

func _init(value_size: int, array_size: int) -> void:
	assert(1 <= value_size and value_size <= 4)
	assert(0 <= array_size)
	_array.resize((value_size * array_size - 1 >> 5) + 1)
