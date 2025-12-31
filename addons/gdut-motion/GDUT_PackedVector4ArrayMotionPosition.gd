class_name GDUT_PackedVector4ArrayMotionPosition extends GDUT_MotionPosition

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
					TYPE_VECTOR4:
						if not _can_convert_from_vector4(array[index]):
							return false
					TYPE_VECTOR4I:
						if not _can_convert_from_vector4i(array[index]):
							return false
					TYPE_ARRAY:
						if not _can_convert_from_array(array[index]):
							return false
					_:
						return false
		TYPE_PACKED_VECTOR4_ARRAY:
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
					TYPE_VECTOR4:
						_array[index] = _convert_from_vector4(array[index])
					TYPE_VECTOR4I:
						_array[index] = _convert_from_vector4i(array[index])
					TYPE_ARRAY:
						_array[index] = _convert_from_array(array[index])
		TYPE_PACKED_VECTOR4_ARRAY:
			for index: int in _array.size():
				_array[index] = _convert_from_vector4(array[index])

func get_outgoing_value() -> Variant:
	return _array

func set_value_at(index: int, value: float) -> void:
	@warning_ignore("integer_division")
	_array[index / 4][index % 4] = value

func get_value_at(index: int) -> float:
	@warning_ignore("integer_division")
	return _array[index / 4][index % 4]

#-------------------------------------------------------------------------------

var _array: PackedVector4Array

#region converters

@warning_ignore("unused_parameter")
static func _can_convert_from_int(value: int) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_float(value: float) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_vector4(value: Vector4) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_vector4i(value: Vector4i) -> bool:
	return true

static func _can_convert_from_array(value: Array) -> bool:
	if value.size() != 4:
		return false
	for index: int in value.size():
		match typeof(value[index]):
			TYPE_INT, \
			TYPE_FLOAT:
				pass
			_:
				return false
	return true

static func _convert_from_int(value: int) -> Vector4:
	return Vector4(value, value, value, value)

static func _convert_from_float(value: float) -> Vector4:
	return Vector4(value, value, value, value)

static func _convert_from_vector4(value: Vector4) -> Vector4:
	return value

static func _convert_from_vector4i(value: Vector4i) -> Vector4:
	return value

static func _convert_from_array(value: Array) -> Vector4:
	var converted_value: Vector4
	match typeof(value[0]):
		TYPE_INT, \
		TYPE_FLOAT:
			converted_value.x = value[0]
	match typeof(value[1]):
		TYPE_INT, \
		TYPE_FLOAT:
			converted_value.y = value[1]
	match typeof(value[2]):
		TYPE_INT, \
		TYPE_FLOAT:
			converted_value.z = value[2]
	match typeof(value[3]):
		TYPE_INT, \
		TYPE_FLOAT:
			converted_value.w = value[3]
	return converted_value

#endregion

func _init(array_size: int) -> void:
	assert(0 <= array_size)
	_array.resize(array_size)
