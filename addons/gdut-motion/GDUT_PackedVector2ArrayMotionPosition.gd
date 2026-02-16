class_name GDUT_PackedVector2ArrayMotionPosition extends GDUT_MotionPosition

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
static func create(array_size: int) -> GDUT_MotionPosition:
	return new(array_size)

static func validate_incoming_value(array: Variant, array_size: int) -> bool:
	assert(0 <= array_size)
	match typeof(array):
		TYPE_ARRAY:
			if array.size() != array_size:
				return false
			for index: int in array.size():
				match typeof(array[index]):
					TYPE_INT:
						if not _can_convert_from_int(array[index]):
							return false
					TYPE_FLOAT:
						if not _can_convert_from_float(array[index]):
							return false
					TYPE_VECTOR2:
						if not _can_convert_from_vector2(array[index]):
							return false
					TYPE_VECTOR2I:
						if not _can_convert_from_vector2i(array[index]):
							return false
					TYPE_ARRAY:
						if not _can_convert_from_array(array[index]):
							return false
					_:
						return false
		TYPE_PACKED_VECTOR2_ARRAY:
			if array.size() != array_size:
				return false
		_:
			return false
	return true

func set_incoming_value(array: Variant) -> void:
	match typeof(array):
		TYPE_ARRAY:
			for index: int in _array.size():
				match typeof(array[index]):
					TYPE_INT:
						_array[index] = _convert_from_int(array[index])
					TYPE_FLOAT:
						_array[index] = _convert_from_float(array[index])
					TYPE_VECTOR2:
						_array[index] = _convert_from_vector2(array[index])
					TYPE_VECTOR2I:
						_array[index] = _convert_from_vector2i(array[index])
					TYPE_ARRAY:
						_array[index] = _convert_from_array(array[index])
		TYPE_PACKED_VECTOR2_ARRAY:
			for index: int in _array.size():
				_array[index] = _convert_from_vector2(array[index])

func get_outgoing_value() -> Variant:
=======
static func can_convert(value: Variant, array_size: int) -> bool:
	var can_convert: Callable = _packed_vector2_array_can_convert_map.get(typeof(value))
	return can_convert.is_valid() and can_convert.call(value, array_size)

func set_value(value: Variant) -> void:
	var convert: Callable = _packed_vector2_array_convert_map.get(typeof(value))
	assert(convert.is_valid())
	convert.call(value, _array)

func get_value() -> Variant:
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
@warning_ignore("unused_parameter")
static func _can_convert_from_int(value: int) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_float(value: float) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_vector2(value: Vector2) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_vector2i(value: Vector2i) -> bool:
	return true

static func _can_convert_from_array(value: Array) -> bool:
	if value.size() != 2:
		return false
	for index: int in value.size():
		match typeof(value[index]):
			TYPE_INT, \
			TYPE_FLOAT:
				pass
=======
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
>>>>>>> Stashed changes
			_:
				return false
	return true

<<<<<<< Updated upstream
static func _convert_from_int(value: int) -> Vector2:
	return Vector2(value, value)

static func _convert_from_float(value: float) -> Vector2:
	return Vector2(value, value)

static func _convert_from_vector2(value: Vector2) -> Vector2:
	return value

static func _convert_from_vector2i(value: Vector2i) -> Vector2:
	return value

static func _convert_from_array(value: Array) -> Vector2:
	var converted_value: Vector2
	match typeof(value[0]):
		TYPE_INT, \
		TYPE_FLOAT:
			converted_value.x = value[0]
	match typeof(value[1]):
		TYPE_INT, \
		TYPE_FLOAT:
			converted_value.y = value[1]
	return converted_value
=======
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
>>>>>>> Stashed changes

#endregion

func _init(array_size: int) -> void:
<<<<<<< Updated upstream
	assert(0 <= array_size)
=======
>>>>>>> Stashed changes
	_array.resize(array_size)
