class_name GDUT_LargeMotionBitSet extends GDUT_MotionBitSet

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
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
=======
#func count() -> int:
#	var t := 0
#	for c: int in _array:
#		# //books.google.co.jp/books?id=iBNKMspIlqEC&pg=PA66
#		c -= (c >> 1) & 0x5555_5555
#		c = (c & 0x3333_3333) + ((c >> 2) & 0x3333_3333)
#		c += c >> 4
#		c &= 0x0F0F_0F0F
#		c += c >> 8
#		c += c >> 16
#		t += c & 0x3F
#	return t

func get_at(index: int) -> bool:
	return _array[index >> 5] & (1 << (index & 31)) != 0

func set_at(index: int) -> void:
	_array[index >> 5] |= 1 << (index & 31)

func clear_at(index: int) -> void:
	_array[index >> 5] &= ~(1 << (index & 31))

#func clear() -> void:
#	_array.fill(0)
>>>>>>> Stashed changes

#-------------------------------------------------------------------------------

var _array: Array[int]

<<<<<<< Updated upstream
func _init(value_size: int, array_size: int) -> void:
	assert(1 <= value_size and value_size <= 4)
	assert(0 <= array_size)
	_array.resize((value_size * array_size - 1 >> 5) + 1)
=======
func _init(size: int) -> void:
	_array.resize((size - 1 >> 5) + 1)
>>>>>>> Stashed changes
