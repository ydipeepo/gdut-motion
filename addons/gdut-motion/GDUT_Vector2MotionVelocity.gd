class_name GDUT_Vector2MotionVelocity extends GDUT_MotionVelocity

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func can_convert(value: Variant, array_size: int) -> bool:
	var can_convert: Callable = _vector2_can_convert_map.get(typeof(value))
	return can_convert.is_valid() and can_convert.call(value, array_size)

func set_value(value: Variant) -> void:
	var convert: Callable = _vector2_convert_map.get(typeof(value))
	assert(convert.is_valid())
	convert.call(value, _array)

func get_value() -> Variant:
	return _array

func set_value_at(index: int, value: float) -> void:
	_array[index] = value

func get_value_at(index: int) -> float:
	return _array[index]

#-------------------------------------------------------------------------------

var _array: Array[float] = [0.0, 0.0]

#region converters

static var _vector2_can_convert_map: Dictionary[int, Callable] = {
	TYPE_INT: _can_convert_from_int,
	TYPE_FLOAT: _can_convert_from_float,
	TYPE_VECTOR2: _can_convert_from_vector2,
	TYPE_VECTOR2I: _can_convert_from_vector2i,
	TYPE_ARRAY: _can_convert_from_array,
	TYPE_PACKED_INT32_ARRAY: _can_convert_from_packed_int32_array,
	TYPE_PACKED_INT64_ARRAY: _can_convert_from_packed_int64_array,
	TYPE_PACKED_FLOAT32_ARRAY: _can_convert_from_packed_float32_array,
	TYPE_PACKED_FLOAT64_ARRAY: _can_convert_from_packed_float64_array,
	TYPE_PACKED_VECTOR2_ARRAY: _can_convert_from_packed_vector2_array,
}

static var _vector2_convert_map: Dictionary[int, Callable] = {
	TYPE_INT: _convert_from_int,
	TYPE_FLOAT: _convert_from_float,
	TYPE_VECTOR2: _convert_from_vector2,
	TYPE_VECTOR2I: _convert_from_vector2i,
	TYPE_ARRAY: _convert_from_array,
	TYPE_PACKED_INT32_ARRAY: _convert_from_packed_int32_array,
	TYPE_PACKED_INT64_ARRAY: _convert_from_packed_int64_array,
	TYPE_PACKED_FLOAT32_ARRAY: _convert_from_packed_float32_array,
	TYPE_PACKED_FLOAT64_ARRAY: _convert_from_packed_float64_array,
	TYPE_PACKED_VECTOR2_ARRAY: _convert_from_packed_vector2_array,
}

@warning_ignore("unused_parameter")
static func _can_convert_from_int(value: int, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_float(value: float, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_vector2(value: Vector2, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_vector2i(value: Vector2i, array_size: int) -> bool:
	return array_size == 1

static func _can_convert_from_array(array: Array, array_size: int) -> bool:
	match array.get_typed_builtin():
		TYPE_NIL:
			if array_size != 1 or 2 < array.size():
				return false
			var valid := true
			var write := 0
			for value: Variant in array:
				match typeof(value):
					TYPE_INT, \
					TYPE_FLOAT:
						write += 1
					TYPE_VECTOR2, \
					TYPE_VECTOR2I:
						if write % 2 != 0:
							valid = false
							break
						write += 2
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
								write += 2
							2:
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
								write += 2
							_:
								valid = false
								break
					_:
						valid = false
						break
			if not valid or write != 2:
				return false
		TYPE_INT, \
		TYPE_FLOAT:
			if array_size != 1 or array.size() != 2:
				return false
		TYPE_VECTOR2, \
		TYPE_VECTOR2I:
			if array_size != 1 or array.size() != 1:
				return false
		_:
			return false
	return true

static func _can_convert_from_packed_int32_array(array: PackedInt32Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 2

static func _can_convert_from_packed_int64_array(array: PackedInt64Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 2

static func _can_convert_from_packed_float32_array(array: PackedFloat32Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 2

static func _can_convert_from_packed_float64_array(array: PackedFloat64Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 2

static func _can_convert_from_packed_vector2_array(array: PackedVector2Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 1

static func _convert_from_int(value: int, converted_array: Array[float]) -> void:
	converted_array[0] = value
	converted_array[1] = value

static func _convert_from_float(value: float, converted_array: Array[float]) -> void:
	converted_array[0] = value
	converted_array[1] = value

static func _convert_from_vector2(value: Vector2, converted_array: Array[float]) -> void:
	converted_array[0] = value.x
	converted_array[1] = value.y

static func _convert_from_vector2i(value: Vector2i, converted_array: Array[float]) -> void:
	converted_array[0] = value.x
	converted_array[1] = value.y

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
					TYPE_VECTOR2, \
					TYPE_VECTOR2I:
						converted_array[write + 0] = value.x
						converted_array[write + 1] = value.y
						write += 2
					TYPE_ARRAY:
						match value.size():
							1:
								converted_array[write + 0] = value[0]
								converted_array[write + 1] = value[0]
								write += 2
							2:
								converted_array[write + 0] = value[0]
								converted_array[write + 1] = value[1]
								write += 2
		TYPE_INT:
			converted_array[0] = array[0]
			converted_array[1] = array[1]
		TYPE_FLOAT:
			converted_array[0] = array[0]
			converted_array[1] = array[1]
		TYPE_VECTOR2:
			var value: Vector2 = array[0]
			converted_array[0] = value.x
			converted_array[1] = value.y
		TYPE_VECTOR2I:
			var value: Vector2i = array[0]
			converted_array[0] = value.x
			converted_array[1] = value.y

static func _convert_from_packed_int32_array(array: PackedInt32Array, converted_array: Array[float]) -> void:
	converted_array[0] = array[0]
	converted_array[1] = array[1]

static func _convert_from_packed_int64_array(array: PackedInt64Array, converted_array: Array[float]) -> void:
	converted_array[0] = array[0]
	converted_array[1] = array[1]

static func _convert_from_packed_float32_array(array: PackedFloat32Array, converted_array: Array[float]) -> void:
	converted_array[0] = array[0]
	converted_array[1] = array[1]

static func _convert_from_packed_float64_array(array: PackedFloat64Array, converted_array: Array[float]) -> void:
	converted_array[0] = array[0]
	converted_array[1] = array[1]

static func _convert_from_packed_vector2_array(array: PackedVector2Array, converted_array: Array[float]) -> void:
	var value: Vector2 = array[0]
	converted_array[0] = value.x
	converted_array[1] = value.y

#endregion

@warning_ignore("unused_parameter")
func _init(array_size: int) -> void:
	pass
