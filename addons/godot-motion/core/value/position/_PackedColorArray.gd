extends "../_Position.gd"

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func can_convert(value: Variant, array_size: int) -> bool:
	match typeof(value):
		TYPE_ARRAY when _can_convert_from_array(value, array_size):
			return true
		TYPE_PACKED_VECTOR3_ARRAY when _can_convert_from_packed_vector3_array(value, array_size):
			return true
		TYPE_PACKED_COLOR_ARRAY when _can_convert_from_packed_color_array(value, array_size):
			return true
		TYPE_PACKED_VECTOR4_ARRAY when _can_convert_from_packed_vector4_array(value, array_size):
			return true
	return false

func set_external_value(value: Variant) -> void:
	match typeof(value):
		TYPE_ARRAY:
			_convert_from_array(value, _array)
		TYPE_PACKED_VECTOR3_ARRAY:
			_convert_from_packed_vector3_array(value, _array)
		TYPE_PACKED_COLOR_ARRAY:
			_convert_from_packed_color_array(value, _array)
		TYPE_PACKED_VECTOR4_ARRAY:
			_convert_from_packed_vector4_array(value, _array)

func get_external_value() -> Variant:
	return _array

func set_at(index: int, value: float) -> void:
	@warning_ignore("integer_division")
	_array[index / 4][index % 4] = value

func get_at(index: int) -> float:
	@warning_ignore("integer_division")
	return _array[index / 4][index % 4]

#-------------------------------------------------------------------------------

var _array: PackedColorArray

#region converters

static func _can_convert_from_array(
	array: Variant,
	array_size: int) -> bool:

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
			if array.size() != 3 and array.size() != 4:
				return false
			for value: Variant in array:
				match typeof(value):
					TYPE_INT, \
					TYPE_FLOAT:
						pass
					_:
						return false
	return true

static func _can_convert_from_packed_vector3_array(
	array: Variant,
	array_size: int) -> bool:

	return array.size() == array_size

static func _can_convert_from_packed_color_array(
	array: Variant,
	array_size: int) -> bool:

	return array.size() == array_size

static func _can_convert_from_packed_vector4_array(
	array: Variant,
	array_size: int) -> bool:

	return array.size() == array_size

static func _convert_from_array(
	array: Array,
	converted_array: PackedColorArray) -> void:

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

static func _convert_from_packed_vector3_array(
	array: PackedVector3Array,
	converted_array: PackedColorArray) -> void:

	var write := 0
	for value: Vector3 in array:
		converted_array[write] = Color(value.x, value.y, value.z)
		write += 1

static func _convert_from_packed_color_array(
	array: PackedColorArray,
	converted_array: PackedColorArray) -> void:

	var write := 0
	for value: Color in array:
		converted_array[write] = value
		write += 1

static func _convert_from_packed_vector4_array(
	array: PackedVector4Array,
	converted_array: PackedColorArray) -> void:

	var write := 0
	for value: Vector4 in array:
		converted_array[write] = Color(value.x, value.y, value.z, value.w)
		write += 1

#endregion

func _init(array_size: int) -> void:
	_array.resize(array_size)
