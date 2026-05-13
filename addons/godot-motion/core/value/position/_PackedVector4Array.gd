extends "../_Position.gd"

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func can_convert(value: Variant, array_size: int) -> bool:
	match typeof(value):
		TYPE_ARRAY when _can_convert_from_array(value, array_size):
			return true
		TYPE_PACKED_VECTOR3_ARRAY when _can_convert_from_packed_vector4_array(value, array_size):
			return true
	return false

func set_external_value(value: Variant) -> void:
	match typeof(value):
		TYPE_ARRAY:
			_convert_from_array(value, _array)
		TYPE_PACKED_VECTOR3_ARRAY:
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

var _array: PackedVector4Array

#region converters

static func _can_convert_from_array(
	array: Array,
	array_size: int) -> bool:

	if array.size() != array_size:
		return false
	for value: Variant in array:
		match typeof(value):
			TYPE_INT, \
			TYPE_FLOAT, \
			TYPE_VECTOR4, \
			TYPE_VECTOR4I:
				pass
			TYPE_ARRAY:
				if value.size() != 4:
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

static func _can_convert_from_packed_vector4_array(
	array: PackedVector4Array,
	array_size: int) -> bool:

	return array.size() == array_size

static func _convert_from_array(
	array: Array,
	converted_array: PackedVector4Array) -> void:

	var write := 0
	for value: Variant in array:
		match typeof(value):
			TYPE_INT, \
			TYPE_FLOAT:
				converted_array[write] = Vector4(value, value, value, value)
				write += 1
			TYPE_VECTOR4, \
			TYPE_VECTOR4I:
				converted_array[write] = value
				write += 1
			TYPE_ARRAY:
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
				converted_array[write] = converted_value
				write += 1

static func _convert_from_packed_vector4_array(
	array: PackedVector4Array,
	converted_array: PackedVector4Array) -> void:

	var write := 0
	for value: Vector4 in array:
		converted_array[write] = value
		write += 1

#endregion

func _init(array_size: int) -> void:
	_array.resize(array_size)
