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
	return false

func set_external_value(value: Variant) -> void:
	match typeof(value):
		TYPE_ARRAY:
			_convert_from_array(value, _array)
		TYPE_PACKED_VECTOR3_ARRAY:
			_convert_from_packed_vector3_array(value, _array)

func get_external_value() -> Variant:
	return _array

func set_at(index: int, value: float) -> void:
	@warning_ignore("integer_division")
	_array[index / 3][index % 3] = value

func get_at(index: int) -> float:
	@warning_ignore("integer_division")
	return _array[index / 3][index % 3]

#-------------------------------------------------------------------------------

var _array: PackedVector3Array

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
			TYPE_VECTOR3, \
			TYPE_VECTOR3I:
				pass
			TYPE_ARRAY:
				if value.size() != 3:
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

static func _can_convert_from_packed_vector3_array(
	array: PackedVector3Array,
	array_size: int) -> bool:

	return array.size() == array_size

static func _convert_from_array(
	array: Array,
	converted_array: PackedVector3Array) -> void:

	var write := 0
	for value: Variant in array:
		match typeof(value):
			TYPE_INT, \
			TYPE_FLOAT:
				converted_array[write] = Vector3(value, value, value)
				write += 1
			TYPE_VECTOR3, \
			TYPE_VECTOR3I:
				converted_array[write] = value
				write += 1
			TYPE_ARRAY:
				var converted_value: Vector3
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
				converted_array[write] = converted_value
				write += 1

static func _convert_from_packed_vector3_array(
	array: PackedVector3Array,
	converted_array: PackedVector3Array) -> void:

	var write := 0
	for value: Vector3 in array:
		converted_array[write] = value
		write += 1

#endregion

func _init(array_size: int) -> void:
	_array.resize(array_size)
