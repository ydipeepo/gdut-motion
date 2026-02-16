class_name GDUT_Transform2DMotionVelocity extends GDUT_MotionVelocity

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
@warning_ignore("unused_parameter")
static func create(array_size: int) -> GDUT_MotionVelocity:
	return new()

static func validate_incoming_value(value: Variant, array_size: int) -> bool:
	match typeof(value):
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
		TYPE_PACKED_VECTOR2_ARRAY:
			if not _can_convert_from_packed_vector2_array(value, array_size):
				return false
		_:
			return false
	return true

func set_incoming_value(value: Variant) -> void:
	match typeof(value):
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
		TYPE_PACKED_VECTOR2_ARRAY:
			_convert_from_packed_vector2_array(value)

func get_outgoing_value() -> Variant:
=======
static func can_convert(value: Variant, array_size: int) -> bool:
	var can_convert: Callable = _transform_2d_can_convert_map.get(typeof(value))
	return can_convert.is_valid() and can_convert.call(value, array_size)

func set_value(value: Variant) -> void:
	var convert: Callable = _transform_2d_convert_map.get(typeof(value))
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

var _array: Array[float] = [
	0.0, 0.0,
	0.0, 0.0,
	0.0, 0.0,
]

#region converters

<<<<<<< Updated upstream
=======
static var _transform_2d_can_convert_map: Dictionary[int, Callable] = {
	TYPE_ARRAY: _can_convert_from_array,
	TYPE_PACKED_INT32_ARRAY: _can_convert_from_packed_int32_array,
	TYPE_PACKED_INT64_ARRAY: _can_convert_from_packed_int64_array,
	TYPE_PACKED_FLOAT32_ARRAY: _can_convert_from_packed_float32_array,
	TYPE_PACKED_FLOAT64_ARRAY: _can_convert_from_packed_float64_array,
	TYPE_PACKED_VECTOR2_ARRAY: _can_convert_from_packed_vector2_array,
}

static var _transform_2d_convert_map: Dictionary[int, Callable] = {
	TYPE_ARRAY: _convert_from_array,
	TYPE_PACKED_INT32_ARRAY: _convert_from_packed_int32_array,
	TYPE_PACKED_INT64_ARRAY: _convert_from_packed_int64_array,
	TYPE_PACKED_FLOAT32_ARRAY: _convert_from_packed_float32_array,
	TYPE_PACKED_FLOAT64_ARRAY: _convert_from_packed_float64_array,
	TYPE_PACKED_VECTOR2_ARRAY: _convert_from_packed_vector2_array,
}

>>>>>>> Stashed changes
static func _can_convert_from_array(array: Array, array_size: int) -> bool:
	match array.get_typed_builtin():
		TYPE_NIL:
			if array_size != 1 or 6 < array.size():
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
			if not valid or write != 6:
				return false
		TYPE_INT, \
		TYPE_FLOAT:
			if array_size != 1 or array.size() != 6:
				return false
		TYPE_VECTOR2, \
		TYPE_VECTOR2I:
			if array_size != 1 or array.size() != 3:
				return false
		_:
			return false
	return true

static func _can_convert_from_packed_int32_array(array: PackedInt32Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 6

static func _can_convert_from_packed_int64_array(array: PackedInt64Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 6

static func _can_convert_from_packed_float32_array(array: PackedFloat32Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 6

static func _can_convert_from_packed_float64_array(array: PackedFloat64Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 6

static func _can_convert_from_packed_vector2_array(array: PackedVector2Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 3

<<<<<<< Updated upstream
func _convert_from_array(array: Array) -> void:
=======
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
					TYPE_VECTOR2, \
					TYPE_VECTOR2I:
						_array[write + 0] = value.x
						_array[write + 1] = value.y
=======
						converted_array[write] = value
						write += 1
					TYPE_VECTOR2, \
					TYPE_VECTOR2I:
						converted_array[write + 0] = value.x
						converted_array[write + 1] = value.y
>>>>>>> Stashed changes
						write += 2
					TYPE_ARRAY:
						match value.size():
							1:
<<<<<<< Updated upstream
								_array[write + 0] = value[0]
								_array[write + 1] = value[0]
								write += 2
							2:
								_array[write + 0] = value[0]
								_array[write + 1] = value[1]
=======
								converted_array[write + 0] = value[0]
								converted_array[write + 1] = value[0]
								write += 2
							2:
								converted_array[write + 0] = value[0]
								converted_array[write + 1] = value[1]
>>>>>>> Stashed changes
								write += 2
		TYPE_INT:
			var write := 0
			for value: int in array:
<<<<<<< Updated upstream
				_array[write] = value
=======
				converted_array[write] = value
>>>>>>> Stashed changes
				write += 1
		TYPE_FLOAT:
			var write := 0
			for value: float in array:
<<<<<<< Updated upstream
				_array[write] = value
=======
				converted_array[write] = value
>>>>>>> Stashed changes
				write += 1
		TYPE_VECTOR2:
			var write := 0
			for value: Vector2 in array:
<<<<<<< Updated upstream
				_array[write + 0] = value.x
				_array[write + 1] = value.y
=======
				converted_array[write + 0] = value.x
				converted_array[write + 1] = value.y
>>>>>>> Stashed changes
				write += 2
		TYPE_VECTOR2I:
			var write := 0
			for value: Vector2i in array:
<<<<<<< Updated upstream
				_array[write + 0] = value.x
				_array[write + 1] = value.y
				write += 2

func _convert_from_packed_int32_array(array: PackedInt32Array) -> void:
	var write := 0
	for value: int in array:
		_array[write] = value
		write += 1

func _convert_from_packed_int64_array(array: PackedInt64Array) -> void:
	var write := 0
	for value: int in array:
		_array[write] = value
		write += 1

func _convert_from_packed_float32_array(array: PackedFloat32Array) -> void:
	var write := 0
	for value: float in array:
		_array[write] = value
		write += 1

func _convert_from_packed_float64_array(array: PackedFloat64Array) -> void:
	var write := 0
	for value: float in array:
		_array[write] = value
		write += 1

func _convert_from_packed_vector2_array(array: PackedVector2Array) -> void:
	var write := 0
	for value: Vector2 in array:
		_array[write + 0] = value.x
		_array[write + 1] = value.y
		write += 2

#endregion
=======
				converted_array[write + 0] = value.x
				converted_array[write + 1] = value.y
				write += 2

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

static func _convert_from_packed_vector2_array(array: PackedVector2Array, converted_array: Array[float]) -> void:
	var write := 0
	for value: Vector2 in array:
		converted_array[write + 0] = value.x
		converted_array[write + 1] = value.y
		write += 2

#endregion

@warning_ignore("unused_parameter")
func _init(array_size: int) -> void:
	pass
>>>>>>> Stashed changes
