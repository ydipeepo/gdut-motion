class_name GDUT_SmallMotionBitSet extends GDUT_MotionBitSet

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

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

#-------------------------------------------------------------------------------

var _value: int
