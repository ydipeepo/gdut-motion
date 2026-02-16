class_name GDUT_PackedVector2ArrayMotionPosition extends GDUT_MotionPosition

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func can_convert(value: Variant, array_size: int) -> bool:
	var can_convert: Callable = _packed_vector2_array_can_convert_map.get(typeof(value))
	return can_convert.is_valid() and can_convert.call(value, array_size)

func set_value(value: Variant) -> void:
	var convert: Callable = _packed_vector2_array_convert_map.get(typeof(value))
	assert(convert.is_valid())
	convert.call(value, _array)

func get_value() -> Variant:
	return _array

func set_value_at(index: int, value: float) -> void:
	@warning_ignore("integer_division")
	_array[index / 2][index % 2] = value

func get_value_at(index: int) -> float:
	@warning_ignore("integer_division")
	return _array[index / 2][index % 2]

#-------------------------------------------------------------------------------

var _array: PackedVector2Array

#region converters

static var _packed_vector2_array_can_convert_map: Dictionary[int, Callable] = {
	TYPE_ARRAY: _can_convert_from_array,
	TYPE_PACKED_VECTOR2_ARRAY: _can_convert_from_packed_vector2_array,
}

static var _packed_vector2_array_convert_map: Dictionary[int, Callable] = {
	TYPE_ARRAY: _convert_from_array,
	TYPE_PACKED_VECTOR2_ARRAY: _convert_from_packed_vector2_array,
}

static func _can_convert_from_array(array: Array, array_size: int) -> bool:
	if array.size() != array_size:
		return false
	for value: Variant in array:
		match typeof(value):
			TYPE_INT, \
			TYPE_FLOAT, \
			TYPE_VECTOR2, \
			TYPE_VECTOR2I:
				pass
			TYPE_ARRAY:
				if value.size() != 2:
					return false
				for index: int in value.size():
					match typeof(value[index]):
						TYPE_INT, \
						TYPE_FLOAT:
							pass
						_:
							return false
			_:
				return false
	return true

static func _can_convert_from_packed_vector2_array(array: PackedVector2Array, array_size: int) -> bool:
	return array.size() == array_size

static func _convert_from_array(array: Array, converted_array: PackedVector2Array) -> void:
	var write := 0
	for value: Variant in array:
		match typeof(value):
			TYPE_INT, \
			TYPE_FLOAT:
				converted_array[write] = Vector2(value, value)
				write += 1
			TYPE_VECTOR2, \
			TYPE_VECTOR2I:
				converted_array[write] = value
				write += 1
			TYPE_ARRAY:
				var converted_value: Vector2
				match typeof(value[0]):
					TYPE_INT, \
					TYPE_FLOAT:
						converted_value.x = value[0]
				match typeof(value[1]):
					TYPE_INT, \
					TYPE_FLOAT:
						converted_value.y = value[1]
				converted_array[write] = converted_value
				write += 1

static func _convert_from_packed_vector2_array(array: PackedVector2Array, converted_array: PackedVector2Array) -> void:
	var write := 0
	for value: Vector2 in array:
		converted_array[write] = value
		write += 1

#endregion

func _init(array_size: int) -> void:
	_array.resize(array_size)
