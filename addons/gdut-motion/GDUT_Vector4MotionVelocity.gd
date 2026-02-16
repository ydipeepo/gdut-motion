class_name GDUT_Vector4MotionVelocity extends GDUT_MotionVelocity

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
@warning_ignore("unused_parameter")
static func create(array_size: int) -> GDUT_MotionVelocity:
	return new()

static func validate_incoming_value(value: Variant, array_size: int) -> bool:
	match typeof(value):
		TYPE_INT:
			if not _can_convert_from_int(value, array_size):
				return false
		TYPE_FLOAT:
			if not _can_convert_from_float(value, array_size):
				return false
		TYPE_VECTOR4:
			if not _can_convert_from_vector4(value, array_size):
				return false
		TYPE_VECTOR4I:
			if not _can_convert_from_vector4i(value, array_size):
				return false
		TYPE_ARRAY:
			if not _can_convert_from_array(value, array_size):
				return false
		TYPE_PACKED_INT32_ARRAY:
			if not _can_convert_from_packed_int32_array(value, array_size):
				return false
		TYPE_PACKED_INT64_ARRAY:
			if not _can_convert_from_packed_int64_array(value, array_size):
				return false
		TYPE_PACKED_FLOAT32_ARRAY:
			if not _can_convert_from_packed_float32_array(value, array_size):
				return false
		TYPE_PACKED_FLOAT64_ARRAY:
			if not _can_convert_from_packed_float64_array(value, array_size):
				return false
		TYPE_PACKED_VECTOR4_ARRAY:
			if not _can_convert_from_packed_vector4_array(value, array_size):
				return false
		_:
			return false
	return true

func set_incoming_value(value: Variant) -> void:
	match typeof(value):
		TYPE_INT:
			_convert_from_int(value)
		TYPE_FLOAT:
			_convert_from_float(value)
		TYPE_VECTOR4:
			_convert_from_vector4(value)
		TYPE_VECTOR4I:
			_convert_from_vector4i(value)
		TYPE_ARRAY:
			_convert_from_array(value)
		TYPE_PACKED_INT32_ARRAY:
			_convert_from_packed_int32_array(value)
		TYPE_PACKED_INT64_ARRAY:
			_convert_from_packed_int64_array(value)
		TYPE_PACKED_FLOAT32_ARRAY:
			_convert_from_packed_float32_array(value)
		TYPE_PACKED_FLOAT64_ARRAY:
			_convert_from_packed_float64_array(value)
		TYPE_PACKED_VECTOR4_ARRAY:
			_convert_from_packed_vector4_array(value)

func get_outgoing_value() -> Variant:
=======
static func can_convert(value: Variant, array_size: int) -> bool:
	var can_convert: Callable = _vector4_can_convert_map.get(typeof(value))
	return can_convert.is_valid() and can_convert.call(value, array_size)

func set_value(value: Variant) -> void:
	var convert: Callable = _vector4_convert_map.get(typeof(value))
	assert(convert.is_valid())
	convert.call(value, _array)

func get_value() -> Variant:
>>>>>>> Stashed changes
	return _array

func set_value_at(index: int, value: float) -> void:
	_array[index] = value

func get_value_at(index: int) -> float:
	return _array[index]

#-------------------------------------------------------------------------------

var _array: Array[float] = [0.0, 0.0, 0.0, 0.0]

#region converters

<<<<<<< Updated upstream
=======
static var _vector4_can_convert_map: Dictionary[int, Callable] = {
	TYPE_INT: _can_convert_from_int,
	TYPE_FLOAT: _can_convert_from_float,
	TYPE_VECTOR4: _can_convert_from_vector4,
	TYPE_VECTOR4I: _can_convert_from_vector4i,
	TYPE_ARRAY: _can_convert_from_array,
	TYPE_PACKED_INT32_ARRAY: _can_convert_from_packed_int32_array,
	TYPE_PACKED_INT64_ARRAY: _can_convert_from_packed_int64_array,
	TYPE_PACKED_FLOAT32_ARRAY: _can_convert_from_packed_float32_array,
	TYPE_PACKED_FLOAT64_ARRAY: _can_convert_from_packed_float64_array,
	TYPE_PACKED_VECTOR4_ARRAY: _can_convert_from_packed_vector4_array,
}

static var _vector4_convert_map: Dictionary[int, Callable] = {
	TYPE_INT: _convert_from_int,
	TYPE_FLOAT: _convert_from_float,
	TYPE_VECTOR4: _convert_from_vector4,
	TYPE_VECTOR4I: _convert_from_vector4i,
	TYPE_ARRAY: _convert_from_array,
	TYPE_PACKED_INT32_ARRAY: _convert_from_packed_int32_array,
	TYPE_PACKED_INT64_ARRAY: _convert_from_packed_int64_array,
	TYPE_PACKED_FLOAT32_ARRAY: _convert_from_packed_float32_array,
	TYPE_PACKED_FLOAT64_ARRAY: _convert_from_packed_float64_array,
	TYPE_PACKED_VECTOR4_ARRAY: _convert_from_packed_vector4_array,
}

>>>>>>> Stashed changes
@warning_ignore("unused_parameter")
static func _can_convert_from_int(value: int, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_float(value: float, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_vector4(value: Vector4, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_vector4i(value: Vector4i, array_size: int) -> bool:
	return array_size == 1

static func _can_convert_from_array(array: Array, array_size: int) -> bool:
	match array.get_typed_builtin():
		TYPE_NIL:
			if array_size != 1 or 4 < array.size():
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
								write += 3
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
			if not valid or write != 4:
				return false
		TYPE_INT, \
		TYPE_FLOAT:
			if array_size != 1 or array.size() != 4:
				return false
		TYPE_VECTOR4, \
		TYPE_VECTOR4I:
			if array_size != 1 or array.size() != 1:
				return false
		_:
			return false
	return true

static func _can_convert_from_packed_int32_array(array: PackedInt32Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 4

static func _can_convert_from_packed_int64_array(array: PackedInt64Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 4

static func _can_convert_from_packed_float32_array(array: PackedFloat32Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 4

static func _can_convert_from_packed_float64_array(array: PackedFloat64Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 4

static func _can_convert_from_packed_vector4_array(array: PackedVector4Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 1

<<<<<<< Updated upstream
func _convert_from_int(value: int) -> void:
	_array[0] = value
	_array[1] = value
	_array[2] = value
	_array[3] = value

func _convert_from_float(value: float) -> void:
	_array[0] = value
	_array[1] = value
	_array[2] = value
	_array[3] = value

func _convert_from_vector4(value: Vector4) -> void:
	_array[0] = value.x
	_array[1] = value.y
	_array[2] = value.z
	_array[3] = value.w

func _convert_from_vector4i(value: Vector4i) -> void:
	_array[0] = value.x
	_array[1] = value.y
	_array[2] = value.z
	_array[3] = value.w

func _convert_from_array(array: Array) -> void:
=======
static func _convert_from_int(value: int, converted_array: Array[float]) -> void:
	converted_array[0] = value
	converted_array[1] = value
	converted_array[2] = value
	converted_array[3] = value

static func _convert_from_float(value: float, converted_array: Array[float]) -> void:
	converted_array[0] = value
	converted_array[1] = value
	converted_array[2] = value
	converted_array[3] = value

static func _convert_from_vector4(value: Vector4, converted_array: Array[float]) -> void:
	converted_array[0] = value.x
	converted_array[1] = value.y
	converted_array[2] = value.z
	converted_array[3] = value.w

static func _convert_from_vector4i(value: Vector4i, converted_array: Array[float]) -> void:
	converted_array[0] = value.x
	converted_array[1] = value.y
	converted_array[2] = value.z
	converted_array[3] = value.w

static func _convert_from_array(array: Array, converted_array: Array[float]) -> void:
>>>>>>> Stashed changes
	match array.get_typed_builtin():
		TYPE_NIL:
			var write := 0
			for value: Variant in array:
				match typeof(value):
					TYPE_INT, \
					TYPE_FLOAT:
<<<<<<< Updated upstream
						_array[write] = value
						write += 1
					TYPE_VECTOR4, \
					TYPE_VECTOR4I:
						_array[write + 0] = value.x
						_array[write + 1] = value.y
						_array[write + 2] = value.z
						_array[write + 3] = value.w
=======
						converted_array[write] = value
						write += 1
					TYPE_VECTOR4, \
					TYPE_VECTOR4I:
						converted_array[write + 0] = value.x
						converted_array[write + 1] = value.y
						converted_array[write + 2] = value.z
						converted_array[write + 3] = value.w
>>>>>>> Stashed changes
						write += 4
					TYPE_ARRAY:
						match value.size():
							1:
<<<<<<< Updated upstream
								_array[write + 0] = value[0]
								_array[write + 1] = value[0]
								_array[write + 2] = value[0]
								_array[write + 3] = value[0]
								write += 4
							4:
								_array[write + 0] = value[0]
								_array[write + 1] = value[1]
								_array[write + 2] = value[2]
								_array[write + 3] = value[3]
								write += 4
		TYPE_INT:
			_array[0] = array[0]
			_array[1] = array[1]
			_array[2] = array[2]
			_array[3] = array[3]
		TYPE_FLOAT:
			_array[0] = array[0]
			_array[1] = array[1]
			_array[2] = array[2]
			_array[3] = array[3]
		TYPE_VECTOR4:
			var value: Vector4 = array[0]
			_array[0] = value.x
			_array[1] = value.y
			_array[2] = value.z
			_array[3] = value.w
		TYPE_VECTOR4I:
			var value: Vector4i = array[0]
			_array[0] = value.x
			_array[1] = value.y
			_array[2] = value.z
			_array[3] = value.w

func _convert_from_packed_int32_array(array: PackedInt32Array) -> void:
	_array[0] = array[0]
	_array[1] = array[1]
	_array[2] = array[2]
	_array[3] = array[3]

func _convert_from_packed_int64_array(array: PackedInt64Array) -> void:
	_array[0] = array[0]
	_array[1] = array[1]
	_array[2] = array[2]
	_array[3] = array[3]

func _convert_from_packed_float32_array(array: PackedFloat32Array) -> void:
	_array[0] = array[0]
	_array[1] = array[1]
	_array[2] = array[2]
	_array[3] = array[3]

func _convert_from_packed_float64_array(array: PackedFloat64Array) -> void:
	_array[0] = array[0]
	_array[1] = array[1]
	_array[2] = array[2]
	_array[3] = array[3]

func _convert_from_packed_vector4_array(array: PackedVector4Array) -> void:
	var value: Vector4 = array[0]
	_array[0] = value.x
	_array[1] = value.y
	_array[2] = value.z
	_array[3] = value.w

#endregion
=======
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
			converted_array[0] = array[0]
			converted_array[1] = array[1]
			converted_array[2] = array[2]
			converted_array[3] = array[3]
		TYPE_FLOAT:
			converted_array[0] = array[0]
			converted_array[1] = array[1]
			converted_array[2] = array[2]
			converted_array[3] = array[3]
		TYPE_VECTOR4:
			var value: Vector4 = array[0]
			converted_array[0] = value.x
			converted_array[1] = value.y
			converted_array[2] = value.z
			converted_array[3] = value.w
		TYPE_VECTOR4I:
			var value: Vector4i = array[0]
			converted_array[0] = value.x
			converted_array[1] = value.y
			converted_array[2] = value.z
			converted_array[3] = value.w

static func _convert_from_packed_int32_array(array: PackedInt32Array, converted_array: Array[float]) -> void:
	converted_array[0] = array[0]
	converted_array[1] = array[1]
	converted_array[2] = array[2]
	converted_array[3] = array[3]

static func _convert_from_packed_int64_array(array: PackedInt64Array, converted_array: Array[float]) -> void:
	converted_array[0] = array[0]
	converted_array[1] = array[1]
	converted_array[2] = array[2]
	converted_array[3] = array[3]

static func _convert_from_packed_float32_array(array: PackedFloat32Array, converted_array: Array[float]) -> void:
	converted_array[0] = array[0]
	converted_array[1] = array[1]
	converted_array[2] = array[2]
	converted_array[3] = array[3]

static func _convert_from_packed_float64_array(array: PackedFloat64Array, converted_array: Array[float]) -> void:
	converted_array[0] = array[0]
	converted_array[1] = array[1]
	converted_array[2] = array[2]
	converted_array[3] = array[3]

static func _convert_from_packed_vector4_array(array: PackedVector4Array, converted_array: Array[float]) -> void:
	var value: Vector4 = array[0]
	converted_array[0] = value.x
	converted_array[1] = value.y
	converted_array[2] = value.z
	converted_array[3] = value.w

#endregion

@warning_ignore("unused_parameter")
func _init(array_size: int) -> void:
	pass
>>>>>>> Stashed changes
