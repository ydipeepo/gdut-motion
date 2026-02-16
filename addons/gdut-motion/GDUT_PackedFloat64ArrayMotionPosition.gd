class_name GDUT_PackedFloat64ArrayMotionPosition extends GDUT_MotionPosition

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
					TYPE_FLOAT:
						if not _can_convert_from_float(array[index]):
							return false
					_:
						return false
		TYPE_PACKED_INT32_ARRAY, \
		TYPE_PACKED_INT64_ARRAY, \
		TYPE_PACKED_FLOAT32_ARRAY, \
		TYPE_PACKED_FLOAT64_ARRAY:
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
					TYPE_FLOAT:
						_array[index] = _convert_from_float(array[index])
		TYPE_PACKED_INT32_ARRAY, \
		TYPE_PACKED_INT64_ARRAY:
			for index: int in _array.size():
				_array[index] = _convert_from_int(array[index])
		TYPE_PACKED_FLOAT32_ARRAY, \
		TYPE_PACKED_FLOAT64_ARRAY:
			for index: int in _array.size():
				_array[index] = _convert_from_float(array[index])

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

<<<<<<< Updated upstream
var _array: PackedFloat64Array

#region converters

@warning_ignore("unused_parameter")
static func _can_convert_from_int(value: int) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_float(value: float) -> bool:
	return true

static func _convert_from_int(value: int) -> float:
	return value

static func _convert_from_float(value: float) -> float:
	return value
=======
var _array: PackedFloat32Array

#region converters

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

static func _can_convert_from_array(array: Array, array_size: int) -> bool:
	if array.size() != array_size:
		return false
	for value: Variant in array:
		match typeof(value):
			TYPE_INT, \
			TYPE_FLOAT:
				pass
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

static func _convert_from_array(array: Variant, converted_array: PackedFloat64Array) -> void:
	var write := 0
	for value: Variant in array:
		match typeof(value):
			TYPE_INT:
				converted_array[write] = value
				write += 1
			TYPE_FLOAT:
				converted_array[write] = value
				write += 1

static func _convert_from_packed_int32_array(array: PackedInt32Array, converted_array: PackedFloat64Array) -> void:
	var write := 0
	for value: int in array:
		converted_array[write] = value
		write += 1

static func _convert_from_packed_int64_array(array: PackedInt64Array, converted_array: PackedFloat64Array) -> void:
	var write := 0
	for value: int in array:
		converted_array[write] = value
		write += 1

static func _convert_from_packed_float32_array(array: PackedFloat32Array, converted_array: PackedFloat64Array) -> void:
	var write := 0
	for value: float in array:
		converted_array[write] = value
		write += 1

static func _convert_from_packed_float64_array(array: PackedFloat64Array, converted_array: PackedFloat64Array) -> void:
	var write := 0
	for value: float in array:
		converted_array[write] = value
		write += 1
>>>>>>> Stashed changes

#endregion

func _init(array_size: int) -> void:
<<<<<<< Updated upstream
	assert(0 <= array_size)
=======
>>>>>>> Stashed changes
	_array.resize(array_size)
