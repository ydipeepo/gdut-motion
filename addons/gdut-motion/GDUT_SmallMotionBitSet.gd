class_name GDUT_SmallMotionBitSet extends GDUT_MotionBitSet

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
@warning_ignore("unused_parameter")
static func create(value_size: int, array_size: int) -> GDUT_MotionBitSet:
	return new()

func set_value_at(index: int, value: bool) -> void:
	var mask := 1 << index
	if value:
		_value |=  mask
	else:
		_value &= ~mask

func get_value_at(index: int) -> bool:
	var mask := 1 << index
	return _value & mask != 0
=======
#func count() -> int:
#	# //books.google.co.jp/books?id=iBNKMspIlqEC&pg=PA66
#	var c := _value
#	c -= (c >> 1) & 0x5555_5555
#	c = (c & 0x3333_3333) + ((c >> 2) & 0x3333_3333)
#	c += c >> 4
#	c &= 0x0F0F_0F0F
#	c += c >> 8
#	c += c >> 16
#	return c & 0x3F

func get_at(index: int) -> bool:
	assert(0 <= index and index < 32)
	return _value & (1 << index) != 0

func set_at(index: int) -> void:
	assert(0 <= index and index < 32)
	_value |= 1 << index

func clear_at(index: int) -> void:
	assert(0 <= index and index < 32)
	_value &= ~(1 << index)

#func clear() -> void:
#	_value = 0
>>>>>>> Stashed changes

#-------------------------------------------------------------------------------

var _value: int
