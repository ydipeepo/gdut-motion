class_name GDUT_Transform2DMotionPosition extends GDUT_MotionPosition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const DEFAULT_VALUE := Transform2D.IDENTITY

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func can_convert(value: Variant, array_size: int) -> bool:
	var can_convert: Callable = _transform_2d_can_convert_map.get(typeof(value))
	return can_convert.is_valid() and can_convert.call(value, array_size)

func set_value(value: Variant) -> void:
	var convert: Callable = _transform_2d_convert_map.get(typeof(value))
	assert(convert.is_valid())
	_value = convert.call(value)

func get_value() -> Variant:
	return _value

func set_value_at(index: int, value: float) -> void:
	@warning_ignore("integer_division")
	_value[index / 2][index % 2] = value

func get_value_at(index: int) -> float:
	@warning_ignore("integer_division")
	return _value[index / 2][index % 2]

#-------------------------------------------------------------------------------

var _value: Transform2D

#region converters

static var _transform_2d_can_convert_map: Dictionary[int, Callable] = {
	TYPE_TRANSFORM2D: _can_convert_from_transform_2d,
	TYPE_ARRAY: _can_convert_from_array,
}

static var _transform_2d_convert_map: Dictionary[int, Callable] = {
	TYPE_TRANSFORM2D: _convert_from_transform_2d,
	TYPE_ARRAY: _convert_from_array,
}

@warning_ignore("unused_parameter")
static func _can_convert_from_transform_2d(value: Transform2D, array_size: int) -> bool:
	return array_size == 1

static func _can_convert_from_array(value: Array, array_size: int) -> bool:
	if array_size != 1:
		return false
	match value.size():
		2:
			match typeof(value[0]):
				TYPE_INT, \
				TYPE_FLOAT:
					pass
				_:
					return false
			match typeof(value[1]):
				TYPE_VECTOR2, \
				TYPE_VECTOR2I:
					pass
				_:
					return false
		3:
			for index: int in 3:
				match typeof(value[index]):
					TYPE_VECTOR2, \
					TYPE_VECTOR2I:
						pass
					_:
						return false
		4:
			match typeof(value[0]):
				TYPE_INT, \
				TYPE_FLOAT:
					pass
				_:
					return false
			match typeof(value[1]):
				TYPE_VECTOR2, \
				TYPE_VECTOR2I:
					pass
				_:
					return false
			match typeof(value[2]):
				TYPE_INT, \
				TYPE_FLOAT:
					pass
				_:
					return false
			match typeof(value[3]):
				TYPE_VECTOR2, \
				TYPE_VECTOR2I:
					pass
				_:
					return false
		6:
			for index: int in 6:
				match typeof(value[index]):
					TYPE_INT, \
					TYPE_FLOAT:
						pass
					_:
						return false
		_:
			return false
	return true

static func _convert_from_transform_2d(value: Transform2D) -> Transform2D:
	return value

static func _convert_from_array(value: Array) -> Transform2D:
	var converted_value: Transform2D
	match value.size():
		2:
			converted_value = Transform2D(value[0], value[1])
		3:
			converted_value = Transform2D(value[0], value[1], value[2])
		4:
			converted_value = Transform2D(value[0], value[1], value[2], value[3])
		6:
			for index: int in 6:
				@warning_ignore("integer_division")
				converted_value[index / 2][index % 2] = value[index]
	return converted_value

#endregion

@warning_ignore("unused_parameter")
func _init(array_size: int) -> void:
	pass
