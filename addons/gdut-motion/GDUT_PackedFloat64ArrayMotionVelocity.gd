class_name GDUT_PackedFloat64ArrayMotionVelocity extends GDUT_MotionVelocity

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
static func create(array_size: int) -> GDUT_MotionVelocity:
	return new(array_size)

static func validate_incoming_value(value: Variant, array_size: int) -> bool:
	assert(0 <= array_size)
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

func get_outgoing_value() -> Variant:
=======
static func can_convert(value: Variant, array_size: int) -> bool:
	var can_convert: Callable = _packed_float64_array_can_convert_map.get(typeof(value))
	return can_convert.is_valid() and can_convert.call(value, array_size)

func set_value(value: Variant) -> void:
	var convert: Callable = _packed_float64_array_convert_map.get(typeof(value))
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

var _array: Array[float]

#region converters

<<<<<<< Updated upstream
=======
static var _packed_float64_array_can_convert_map: Dictionary[int, Callable] = {
	TYPE_ARRAY: _can_convert_from_array,
	TYPE_PACKED_INT32_ARRAY: _can_convert_from_packed_int32_array,
	TYPE_PACKED_INT64_ARRAY: _can_convert_from_packed_int64_array,
	TYPE_PACKED_FLOAT32_ARRAY: _can_convert_from_packed_float32_array,
	TYPE_PACKED_FLOAT64_ARRAY: _can_convert_from_packed_float64_array,
}

static var _packed_float64_array_convert_map: Dictionary[int, Callable] = {
	TYPE_ARRAY: _convert_from_array,
	TYPE_PACKED_INT32_ARRAY: _convert_from_packed_int32_array,
	TYPE_PACKED_INT64_ARRAY: _convert_from_packed_int64_array,
	TYPE_PACKED_FLOAT32_ARRAY: _convert_from_packed_float32_array,
	TYPE_PACKED_FLOAT64_ARRAY: _convert_from_packed_float64_array,
}

>>>>>>> Stashed changes
static func _can_convert_from_array(array: Array, array_size: int) -> bool:
	match array.get_typed_builtin():
		TYPE_NIL:
			if array_size < array.size():
				return false
			var valid := true
			var write := 0
			for value: Variant in array:
				match typeof(value):
					TYPE_INT, \
					TYPE_FLOAT:
						write += 1
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
								write += 1
							_:
								valid = false
								break
					_:
						valid = false
						break
			if not valid or write != array_size:
				return false
		TYPE_INT, \
		TYPE_FLOAT:
			if array_size != 1 or array.size() != array_size:
				return false
		_:
			return false
	return true

static func _can_convert_from_packed_int32_array(array: PackedInt32Array, array_size: int) -> bool:
	return array.size() == array_size

static func _can_convert_from_packed_int64_array(array: PackedInt64Array, array_size: int) -> bool:
	return array.size() == array_size

static func _can_convert_from_packed_float32_array(array: PackedFloat32Array, array_size: int) -> bool:
	return array.size() == array_size

static func _can_convert_from_packed_float64_array(array: PackedFloat64Array, array_size: int) -> bool:
	return array.size() == array_size

<<<<<<< Updated upstream
func _convert_from_array(array: Array) -> void:
	match array.get_typed_builtin():
		TYPE_NIL:
			var value: Variant = array[0]
			match typeof(value):
				TYPE_INT, \
				TYPE_FLOAT:
					_array[0] = value
				TYPE_ARRAY:
					_array[0] = value[0]
		TYPE_INT, \
		TYPE_FLOAT:
			_array[0] = array[0]

func _convert_from_packed_int32_array(array: PackedInt32Array) -> void:
	_array[0] = array[0]

func _convert_from_packed_int64_array(array: PackedInt64Array) -> void:
	_array[0] = array[0]

func _convert_from_packed_float32_array(array: PackedFloat32Array) -> void:
	_array[0] = array[0]

func _convert_from_packed_float64_array(array: PackedFloat64Array) -> void:
	_array[0] = array[0]
=======
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
					TYPE_ARRAY:
						converted_array[write] = value[0]
						write += 1
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
>>>>>>> Stashed changes

#endregion

func _init(array_size: int) -> void:
	_array.resize(array_size)
