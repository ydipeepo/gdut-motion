class_name GDUT_PackedColorArrayMotionPosition extends GDUT_MotionPosition

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
			for index: int in array_size:
				match typeof(array[index]):
					TYPE_INT:
						if not _can_convert_from_int(array[index]):
							return false
					TYPE_STRING:
						if not _can_convert_from_string(array[index]):
							return false
					TYPE_VECTOR3:
						if not _can_convert_from_vector3(array[index]):
							return false
					TYPE_VECTOR3I:
						if not _can_convert_from_vector3i(array[index]):
							return false
					TYPE_VECTOR4:
						if not _can_convert_from_vector4(array[index]):
							return false
					TYPE_VECTOR4I:
						if not _can_convert_from_vector4i(array[index]):
							return false
					TYPE_COLOR:
						if not _can_convert_from_color(array[index]):
							return false
					TYPE_ARRAY:
						if not _can_convert_from_array(array[index]):
							return false
					TYPE_STRING_NAME:
						if not _can_convert_from_string_name(array[index]):
							return false
					_:
						return false
		TYPE_PACKED_VECTOR3_ARRAY, \
		TYPE_PACKED_COLOR_ARRAY, \
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
					TYPE_STRING:
						_array[index] = _convert_from_string(array[index])
					TYPE_VECTOR3:
						_array[index] = _convert_from_vector3(array[index])
					TYPE_VECTOR3I:
						_array[index] = _convert_from_vector3i(array[index])
					TYPE_VECTOR4:
						_array[index] = _convert_from_vector4(array[index])
					TYPE_VECTOR4I:
						_array[index] = _convert_from_vector4i(array[index])
					TYPE_COLOR:
						_array[index] = _convert_from_color(array[index])
					TYPE_ARRAY:
						_array[index] = _convert_from_array(array[index])
					TYPE_STRING_NAME:
						_array[index] = _convert_from_string_name(array[index])
		TYPE_PACKED_VECTOR3_ARRAY:
			for index: int in _array.size():
				_array[index] = _convert_from_vector3(array[index])
		TYPE_PACKED_COLOR_ARRAY:
			for index: int in _array.size():
				_array[index] = _convert_from_color(array[index])
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

var _array: PackedColorArray

#region converters

static func _can_convert_from_int(value: int) -> bool:
	return value & 0xFFFFFF == value

static func _can_convert_from_string(value: String) -> bool:
	return not value.is_empty()

@warning_ignore("unused_parameter")
static func _can_convert_from_vector3(value: Vector3) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_vector3i(value: Vector3i) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_vector4(value: Vector4) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_vector4i(value: Vector4i) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_color(value: Color) -> bool:
	return true

static func _can_convert_from_array(value: Array) -> bool:
	if value.size() != 3 or value.size() != 4:
		return false
	for index: int in value.size():
		match typeof(value[index]):
			TYPE_INT, \
			TYPE_FLOAT:
				pass
			_:
				return false
	return true

static func _can_convert_from_string_name(value: StringName) -> bool:
	return not value.is_empty()

static func _convert_from_int(value: int) -> Color:
	return Color.hex((value << 8) | 0x000000FF)

static func _convert_from_string(value: String) -> Color:
	return value

static func _convert_from_vector3(value: Vector3) -> Color:
	return Color(value.x, value.y, value.z)

static func _convert_from_vector3i(value: Vector3i) -> Color:
	var converted_value: Color
	converted_value.r8 = value.x
	converted_value.g8 = value.y
	converted_value.b8 = value.z
	return converted_value

static func _convert_from_vector4(value: Vector4) -> Color:
	return Color(value.x, value.y, value.z, value.w)

static func _convert_from_vector4i(value: Vector4i) -> Color:
	var converted_value: Color
	converted_value.r8 = value.x
	converted_value.g8 = value.y
	converted_value.b8 = value.z
	converted_value.a8 = value.w
	return converted_value

static func _convert_from_color(value: Color) -> Color:
	return value

static func _convert_from_array(value: Array) -> Color:
	var converted_value: Color
	match typeof(value[0]):
		TYPE_INT:
			converted_value.r8 = value[0]
		TYPE_FLOAT:
			converted_value.r = value[0]
	match typeof(value[1]):
		TYPE_INT:
			converted_value.g8 = value[1]
		TYPE_FLOAT:
			converted_value.g = value[1]
	match typeof(value[2]):
		TYPE_INT:
			converted_value.b8 = value[2]
		TYPE_FLOAT:
			converted_value.b = value[2]
	if value.size() == 4:
		match typeof(value[3]):
			TYPE_INT:
				converted_value.a8 = value[3]
			TYPE_FLOAT:
				converted_value.a = value[3]
	return converted_value

static func _convert_from_string_name(value: StringName) -> Color:
	return Color(value)

#endregion

func _init(array_size: int) -> void:
	assert(0 <= array_size)
	_array.resize(array_size)
