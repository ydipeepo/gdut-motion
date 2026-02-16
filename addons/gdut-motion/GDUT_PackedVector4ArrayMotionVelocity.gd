class_name GDUT_PackedVector4ArrayMotionVelocity extends GDUT_MotionVelocity

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func can_convert(value: Variant, array_size: int) -> bool:
	var can_convert: Callable = _packed_vector4_array_can_convert_map.get(typeof(value))
	return can_convert.is_valid() and can_convert.call(value, array_size)

func set_value(value: Variant) -> void:
	var convert: Callable = _packed_vector4_array_convert_map.get(typeof(value))
	assert(convert.is_valid())
	convert.call(value, _array)

func get_value() -> Variant:
	return _array

func set_value_at(index: int, value: float) -> void:
	_array[index] = value

func get_value_at(index: int) -> float:
	return _array[index]

#-------------------------------------------------------------------------------

var _array: Array[float]

#region converters

static var _packed_vector4_array_can_convert_map: Dictionary[int, Callable] = {
	TYPE_ARRAY: _can_convert_from_array,
	TYPE_PACKED_INT32_ARRAY: _can_convert_from_packed_int32_array,
	TYPE_PACKED_INT64_ARRAY: _can_convert_from_packed_int64_array,
	TYPE_PACKED_FLOAT32_ARRAY: _can_convert_from_packed_float32_array,
	TYPE_PACKED_FLOAT64_ARRAY: _can_convert_from_packed_float64_array,
	TYPE_PACKED_VECTOR4_ARRAY: _can_convert_from_packed_vector4_array,
}

static var _packed_vector4_array_convert_map: Dictionary[int, Callable] = {
	TYPE_ARRAY: _convert_from_array,
	TYPE_PACKED_INT32_ARRAY: _convert_from_packed_int32_array,
	TYPE_PACKED_INT64_ARRAY: _convert_from_packed_int64_array,
	TYPE_PACKED_FLOAT32_ARRAY: _convert_from_packed_float32_array,
	TYPE_PACKED_FLOAT64_ARRAY: _convert_from_packed_float64_array,
	TYPE_PACKED_VECTOR4_ARRAY: _convert_from_packed_vector4_array,
}

static func _can_convert_from_array(array: Array, array_size: int) -> bool:
	match array.get_typed_builtin():
		TYPE_NIL:
			if array_size * 4 < array.size():
				return false
			var valid := true
			var write := 0
			for value: Variant in array:
				match typeof(value):
					TYPE_INT, \
					TYPE_FLOAT:
						write += 1
					TYPE_VECTOR4, \
					TYPE_VECTOR4I:
						if write % 4 != 0:
							valid = false
							break
						write += 4
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
								write += 4
							4:
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
								match typeof(value[3]):
									TYPE_INT, \
									TYPE_FLOAT:
										pass
									_:
										valid = false
										break
								write += 4
							_:
								valid = false
								break
					_:
						valid = false
						break
			if not valid or write != array_size * 4:
				return false
		TYPE_INT, \
		TYPE_FLOAT:
			if array.size() != array_size * 4:
				return false
		TYPE_VECTOR4, \
		TYPE_VECTOR4I:
			if array.size() != array_size:
				return false
		_:
			return false
	return true

static func _can_convert_from_packed_int32_array(array: PackedInt32Array, array_size: int) -> bool:
	return array.size() == array_size * 4

static func _can_convert_from_packed_int64_array(array: PackedInt64Array, array_size: int) -> bool:
	return array.size() == array_size * 4

static func _can_convert_from_packed_float32_array(array: PackedFloat32Array, array_size: int) -> bool:
	return array.size() == array_size * 4

static func _can_convert_from_packed_float64_array(array: PackedFloat64Array, array_size: int) -> bool:
	return array.size() == array_size * 4

static func _can_convert_from_packed_vector4_array(array: PackedVector4Array, array_size: int) -> bool:
	return array.size() == array_size

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
					TYPE_VECTOR4, \
					TYPE_VECTOR4I:
						converted_array[write + 0] = value.x
						converted_array[write + 1] = value.y
						converted_array[write + 2] = value.z
						converted_array[write + 3] = value.w
						write += 4
					TYPE_ARRAY:
						match value.size():
							1:
								converted_array[write + 0] = value[0]
								converted_array[write + 1] = value[0]
								converted_array[write + 2] = value[0]
								converted_array[write + 3] = value[0]
								write += 4
							4:
								converted_array[write + 0] = value[0]
								converted_array[write + 1] = value[1]
								converted_array[write + 2] = value[2]
								converted_array[write + 3] = value[3]
								write += 4
		TYPE_INT:
			var write := 0
			for value: int in array:
				converted_array[write] = value
				write += 1
		TYPE_FLOAT:
			var write := 0
			for value: float in array:
				converted_array[write] = value
				write += 1
		TYPE_VECTOR4:
			var write := 0
			for value: Vector4 in array:
				converted_array[write + 0] = value.x
				converted_array[write + 1] = value.y
				converted_array[write + 2] = value.z
				converted_array[write + 3] = value.w
				write += 4
		TYPE_VECTOR4I:
			var write := 0
			for value: Vector4i in array:
				converted_array[write + 0] = value.x
				converted_array[write + 1] = value.y
				converted_array[write + 2] = value.z
				converted_array[write + 3] = value.w
				write += 4

static func _convert_from_packed_int32_array(array: PackedInt32Array, converted_array: Array[float]) -> void:
	var write := 0
	for value: int in array:
		converted_array[write] = value
		write += 1

static func _convert_from_packed_int64_array(array: PackedInt64Array, converted_array: Array[float]) -> void:
	var write := 0
	for value: int in array:
		converted_array[write] = value
		write += 1

static func _convert_from_packed_float32_array(array: PackedFloat32Array, converted_array: Array[float]) -> void:
	var write := 0
	for value: float in array:
		converted_array[write] = value
		write += 1

static func _convert_from_packed_float64_array(array: PackedFloat64Array, converted_array: Array[float]) -> void:
	var write := 0
	for value: float in array:
		converted_array[write] = value
		write += 1

static func _convert_from_packed_vector4_array(array: PackedVector4Array, converted_array: Array[float]) -> void:
	var write := 0
	for value: Vector4 in array:
		converted_array[write + 0] = value.x
		converted_array[write + 1] = value.y
		converted_array[write + 2] = value.z
		converted_array[write + 3] = value.w
		write += 4

#endregion

func _init(array_size: int) -> void:
	_array.resize(array_size * 4)
