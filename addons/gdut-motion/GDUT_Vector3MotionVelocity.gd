class_name GDUT_Vector3MotionVelocity extends GDUT_MotionVelocity

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func can_convert(value: Variant, array_size: int) -> bool:
	var can_convert: Callable = _vector3_can_convert_map.get(typeof(value))
	return can_convert.is_valid() and can_convert.call(value, array_size)

func set_value(value: Variant) -> void:
	var convert: Callable = _vector3_convert_map.get(typeof(value))
	assert(convert.is_valid())
	convert.call(value, _array)

func get_value() -> Variant:
	return _array

func set_value_at(index: int, value: float) -> void:
	_array[index] = value

func get_value_at(index: int) -> float:
	return _array[index]

#-------------------------------------------------------------------------------

var _array: Array[float] = [0.0, 0.0, 0.0]

#region converters

static var _vector3_can_convert_map: Dictionary[int, Callable] = {
	TYPE_INT: _can_convert_from_int,
	TYPE_FLOAT: _can_convert_from_float,
	TYPE_VECTOR3: _can_convert_from_vector3,
	TYPE_VECTOR3I: _can_convert_from_vector3i,
	TYPE_ARRAY: _can_convert_from_array,
	TYPE_PACKED_INT32_ARRAY: _can_convert_from_packed_int32_array,
	TYPE_PACKED_INT64_ARRAY: _can_convert_from_packed_int64_array,
	TYPE_PACKED_FLOAT32_ARRAY: _can_convert_from_packed_float32_array,
	TYPE_PACKED_FLOAT64_ARRAY: _can_convert_from_packed_float64_array,
	TYPE_PACKED_VECTOR3_ARRAY: _can_convert_from_packed_vector3_array,
}

static var _vector3_convert_map: Dictionary[int, Callable] = {
	TYPE_INT: _convert_from_int,
	TYPE_FLOAT: _convert_from_float,
	TYPE_VECTOR3: _convert_from_vector3,
	TYPE_VECTOR3I: _convert_from_vector3i,
	TYPE_ARRAY: _convert_from_array,
	TYPE_PACKED_INT32_ARRAY: _convert_from_packed_int32_array,
	TYPE_PACKED_INT64_ARRAY: _convert_from_packed_int64_array,
	TYPE_PACKED_FLOAT32_ARRAY: _convert_from_packed_float32_array,
	TYPE_PACKED_FLOAT64_ARRAY: _convert_from_packed_float64_array,
	TYPE_PACKED_VECTOR3_ARRAY: _convert_from_packed_vector3_array,
}

@warning_ignore("unused_parameter")
static func _can_convert_from_int(value: int, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_float(value: float, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_vector3(value: Vector3, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_vector3i(value: Vector3i, array_size: int) -> bool:
	return array_size == 1

static func _can_convert_from_array(array: Array, array_size: int) -> bool:
	match array.get_typed_builtin():
		TYPE_NIL:
			if array_size != 1 or 3 < array.size():
				return false
			var valid := true
			var write := 0
			for value: Variant in array:
				match typeof(value):
					TYPE_INT, \
					TYPE_FLOAT:
						write += 1
					TYPE_VECTOR3, \
					TYPE_VECTOR3I:
						if write % 3 != 0:
							valid = false
							break
						write += 3
					TYPE_ARRAY:
						match value.size():
							1:
								match typeof(value[0]):
									TYPE_INT, \
									TYPE_FLOAT:
										pass
									_:
										valid = false
										break
								write += 3
							3:
								match typeof(value[0]):
									TYPE_INT, \
									TYPE_FLOAT:
										pass
									_:
										valid = false
										break
								match typeof(value[1]):
									TYPE_INT, \
									TYPE_FLOAT:
										pass
									_:
										valid = false
										break
								match typeof(value[2]):
									TYPE_INT, \
									TYPE_FLOAT:
										pass
									_:
										valid = false
										break
								write += 3
							_:
								valid = false
								break
					_:
						valid = false
						break
			if not valid or write != 3:
				return false
		TYPE_INT, \
		TYPE_FLOAT:
			if array_size != 1 or array.size() != 3:
				return false
		TYPE_VECTOR3, \
		TYPE_VECTOR3I:
			if array_size != 1 or array.size() != 1:
				return false
		_:
			return false
	return true

static func _can_convert_from_packed_int32_array(array: PackedInt32Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 3

static func _can_convert_from_packed_int64_array(array: PackedInt64Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 3

static func _can_convert_from_packed_float32_array(array: PackedFloat32Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 3

static func _can_convert_from_packed_float64_array(array: PackedFloat64Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 3

static func _can_convert_from_packed_vector3_array(array: PackedVector3Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 1

static func _convert_from_int(value: int, converted_array: Array[float]) -> void:
	converted_array[0] = value
	converted_array[1] = value
	converted_array[2] = value

static func _convert_from_float(value: float, converted_array: Array[float]) -> void:
	converted_array[0] = value
	converted_array[1] = value
	converted_array[2] = value

static func _convert_from_vector3(value: Vector3, converted_array: Array[float]) -> void:
	converted_array[0] = value.x
	converted_array[1] = value.y
	converted_array[2] = value.z

static func _convert_from_vector3i(value: Vector3i, converted_array: Array[float]) -> void:
	converted_array[0] = value.x
	converted_array[1] = value.y
	converted_array[2] = value.z

static func _convert_from_array(array: Array, converted_array: Array[float]) -> void:
	match array.get_typed_builtin():
		TYPE_NIL:
			var write := 0
			for value: Variant in array:
				match typeof(value):
					TYPE_INT, \
					TYPE_FLOAT:
						converted_array[write] = value
						write += 1
					TYPE_VECTOR3, \
					TYPE_VECTOR3I:
						converted_array[write + 0] = value.x
						converted_array[write + 1] = value.y
						converted_array[write + 2] = value.z
						write += 3
					TYPE_ARRAY:
						match value.size():
							1:
								converted_array[write + 0] = value[0]
								converted_array[write + 1] = value[0]
								converted_array[write + 2] = value[0]
								write += 3
							3:
								converted_array[write + 0] = value[0]
								converted_array[write + 1] = value[1]
								converted_array[write + 2] = value[2]
								write += 3
		TYPE_INT:
			converted_array[0] = array[0]
			converted_array[1] = array[1]
			converted_array[2] = array[2]
		TYPE_FLOAT:
			converted_array[0] = array[0]
			converted_array[1] = array[1]
			converted_array[2] = array[2]
		TYPE_VECTOR3:
			var value: Vector3 = array[0]
			converted_array[0] = value.x
			converted_array[1] = value.y
			converted_array[2] = value.z
		TYPE_VECTOR3I:
			var value: Vector3i = array[0]
			converted_array[0] = value.x
			converted_array[1] = value.y
			converted_array[2] = value.z

static func _convert_from_packed_int32_array(array: PackedInt32Array, converted_array: Array[float]) -> void:
	converted_array[0] = array[0]
	converted_array[1] = array[1]
	converted_array[2] = array[2]

static func _convert_from_packed_int64_array(array: PackedInt64Array, converted_array: Array[float]) -> void:
	converted_array[0] = array[0]
	converted_array[1] = array[1]
	converted_array[2] = array[2]

static func _convert_from_packed_float32_array(array: PackedFloat32Array, converted_array: Array[float]) -> void:
	converted_array[0] = array[0]
	converted_array[1] = array[1]
	converted_array[2] = array[2]

static func _convert_from_packed_float64_array(array: PackedFloat64Array, converted_array: Array[float]) -> void:
	converted_array[0] = array[0]
	converted_array[1] = array[1]
	converted_array[2] = array[2]

static func _convert_from_packed_vector3_array(array: PackedVector3Array, converted_array: Array[float]) -> void:
	var value: Vector3 = array[0]
	converted_array[0] = value.x
	converted_array[1] = value.y
	converted_array[2] = value.z

#endregion

@warning_ignore("unused_parameter")
func _init(array_size: int) -> void:
	pass
