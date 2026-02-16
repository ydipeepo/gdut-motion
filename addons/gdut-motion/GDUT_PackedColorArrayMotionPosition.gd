class_name GDUT_PackedColorArrayMotionPosition extends GDUT_MotionPosition

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
=======
static func can_convert(value: Variant, array_size: int) -> bool:
	var can_convert: Callable = _packed_color_array_can_convert_map.get(typeof(value))
	return can_convert.is_valid() and can_convert.call(value, array_size)

func set_value(value: Variant) -> void:
	var convert: Callable = _packed_color_array_convert_map.get(typeof(value))
	assert(convert.is_valid())
	convert.call(value, _array)

func get_value() -> Variant:
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
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
=======
static var _packed_color_array_can_convert_map: Dictionary[int, Callable] = {
	TYPE_ARRAY: _can_convert_from_array,
	TYPE_PACKED_VECTOR3_ARRAY: _can_convert_from_packed_vector3_array,
	TYPE_PACKED_COLOR_ARRAY: _can_convert_from_packed_color_array,
	TYPE_PACKED_VECTOR4_ARRAY: _can_convert_from_packed_vector4_array,
}

static var _packed_color_array_convert_map: Dictionary[int, Callable] = {
	TYPE_ARRAY: _convert_from_array,
	TYPE_PACKED_VECTOR3_ARRAY: _convert_from_packed_vector3_array,
	TYPE_PACKED_COLOR_ARRAY: _convert_from_packed_color_array,
	TYPE_PACKED_VECTOR4_ARRAY: _convert_from_packed_vector4_array,
}

static func _can_convert_from_array(array: Variant, array_size: int) -> bool:
	match array.get_typed_builtin():
		TYPE_INT:
			if array.size() != array_size:
				return false
			for value: int in array:
				if value & 0xFFFFFF != value:
					return false
		TYPE_STRING:
			if array.size() != array_size:
				return false
			for value: String in array:
				if value.is_empty():
					return false
		TYPE_VECTOR3, \
		TYPE_VECTOR3I, \
		TYPE_VECTOR4, \
		TYPE_VECTOR4I, \
		TYPE_COLOR:
			if array.size() != array_size:
				return false
		TYPE_STRING_NAME:
			if array.size() != array_size:
				return false
			for value: StringName in array:
				if value.is_empty():
					return false
		TYPE_ARRAY:
			if array.size() != 3 or array.size() != 4:
				return false
			for value: Variant in array:
				match typeof(value):
					TYPE_INT, \
					TYPE_FLOAT:
						pass
					_:
						return false
	return true

static func _can_convert_from_packed_vector3_array(array: Variant, array_size: int) -> bool:
	return array.size() == array_size

static func _can_convert_from_packed_color_array(array: Variant, array_size: int) -> bool:
	return array.size() == array_size

static func _can_convert_from_packed_vector4_array(array: Variant, array_size: int) -> bool:
	return array.size() == array_size

static func _convert_from_array(array: Array, converted_array: PackedColorArray) -> void:
	match array.get_typed_builtin():
		TYPE_INT:
			var write := 0
			for value: int in array:
				converted_array[write] = Color.hex((value << 8) | 0x000000FF)
				write += 1
		TYPE_STRING:
			var write := 0
			for value: String in array:
				converted_array[write] = value
				write += 1
		TYPE_VECTOR3:
			var write := 0
			for value: Vector3 in array:
				converted_array[write] = Color(value.x, value.y, value.z)
				write += 1
		TYPE_VECTOR3I:
			var write := 0
			for value: Vector3i in array:
				var converted_value: Color
				converted_value.r8 = value.x
				converted_value.g8 = value.y
				converted_value.b8 = value.z
				converted_array[write] = converted_value
				write += 1
		TYPE_VECTOR4:
			var write := 0
			for value: Vector4 in array:
				converted_array[write] = Color(value.x, value.y, value.z, value.w)
				write += 1
		TYPE_VECTOR4I:
			var write := 0
			for value: Vector4i in array:
				var converted_value: Color
				converted_value.r8 = value.x
				converted_value.g8 = value.y
				converted_value.b8 = value.z
				converted_value.a8 = value.w
				converted_array[write] = converted_value
				write += 1
		TYPE_COLOR:
			var write := 0
			for value: Color in array:
				converted_array[write] = value
				write += 1
		TYPE_STRING_NAME:
			var write := 0
			for value: StringName in array:
				converted_array[write] = Color(value)
				write += 1
		TYPE_ARRAY:
			var write := 0
			for value: Array in array:
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
				converted_array[write] = converted_value
				write += 1

static func _convert_from_packed_vector3_array(array: PackedVector3Array, converted_array: PackedColorArray) -> void:
	var write := 0
	for value: Vector3 in array:
		converted_array[write] = Color(value.x, value.y, value.z)
		write += 1

static func _convert_from_packed_color_array(array: PackedColorArray, converted_array: PackedColorArray) -> void:
	var write := 0
	for value: Color in array:
		converted_array[write] = value
		write += 1

static func _convert_from_packed_vector4_array(array: PackedVector4Array, converted_array: PackedColorArray) -> void:
	var write := 0
	for value: Vector4 in array:
		converted_array[write] = Color(value.x, value.y, value.z, value.w)
		write += 1
>>>>>>> Stashed changes

#endregion

func _init(array_size: int) -> void:
<<<<<<< Updated upstream
	assert(0 <= array_size)
=======
>>>>>>> Stashed changes
	_array.resize(array_size)
