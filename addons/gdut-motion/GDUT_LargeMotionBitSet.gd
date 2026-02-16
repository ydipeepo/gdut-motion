class_name GDUT_LargeMotionBitSet extends GDUT_MotionBitSet

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

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

#-------------------------------------------------------------------------------

var _array: Array[int]

func _init(size: int) -> void:
	_array.resize((size - 1 >> 5) + 1)
