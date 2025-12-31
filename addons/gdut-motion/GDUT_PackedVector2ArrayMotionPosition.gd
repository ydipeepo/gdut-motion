class_name GDUT_PackedVector2ArrayMotionPosition extends GDUT_MotionPosition

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

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
			_:
				return false
	return true

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

#endregion

func _init(array_size: int) -> void:
	assert(0 <= array_size)
	_array.resize(array_size)
