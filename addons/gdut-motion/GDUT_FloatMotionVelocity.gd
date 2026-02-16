class_name GDUT_FloatMotionVelocity extends GDUT_MotionVelocity

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
		TYPE_ARRAY:
			if not _can_convert_from_array(value, array_size):
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
	var can_convert: Callable = _float_can_convert_map.get(typeof(value))
	return can_convert.is_valid() and can_convert.call(value, array_size)

func set_value(value: Variant) -> void:
	var convert: Callable = _float_convert_map.get(typeof(value))
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

var _array: Array[float] = [0.0]

#region converters

<<<<<<< Updated upstream
=======
static var _float_can_convert_map: Dictionary[int, Callable] = {
	TYPE_INT: _can_convert_from_int,
	TYPE_FLOAT: _can_convert_from_float,
	TYPE_ARRAY: _can_convert_from_array,
	TYPE_PACKED_INT32_ARRAY: _can_convert_from_packed_int32_array,
	TYPE_PACKED_INT64_ARRAY: _can_convert_from_packed_int64_array,
	TYPE_PACKED_FLOAT32_ARRAY: _can_convert_from_packed_float32_array,
	TYPE_PACKED_FLOAT64_ARRAY: _can_convert_from_packed_float64_array,
}

static var _float_convert_map: Dictionary[int, Callable] = {
	TYPE_INT: _convert_from_int,
	TYPE_FLOAT: _convert_from_float,
	TYPE_ARRAY: _convert_from_array,
	TYPE_PACKED_INT32_ARRAY: _convert_from_packed_int32_array,
	TYPE_PACKED_INT64_ARRAY: _convert_from_packed_int64_array,
	TYPE_PACKED_FLOAT32_ARRAY: _convert_from_packed_float32_array,
	TYPE_PACKED_FLOAT64_ARRAY: _convert_from_packed_float64_array,
}

>>>>>>> Stashed changes
@warning_ignore("unused_parameter")
static func _can_convert_from_int(value: int, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_float(value: float, array_size: int) -> bool:
	return array_size == 1

static func _can_convert_from_array(array: Array, array_size: int) -> bool:
	if array_size != 1:
		return false
	match array.size():
		1:
			match typeof(array[0]):
				TYPE_INT, \
				TYPE_FLOAT:
					pass
				_:
					return false
		_:
			return false
	return true

static func _can_convert_from_packed_int32_array(array: PackedInt32Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 1

static func _can_convert_from_packed_int64_array(array: PackedInt64Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 1

static func _can_convert_from_packed_float32_array(array: PackedFloat32Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 1

static func _can_convert_from_packed_float64_array(array: PackedFloat64Array, array_size: int) -> bool:
	return array_size == 1 and array.size() == 1

<<<<<<< Updated upstream
func _convert_from_int(value: int) -> void:
	_array[0] = value

func _convert_from_float(value: float) -> void:
	_array[0] = value

func _convert_from_array(array: Array) -> void:
	_array[0] = array[0]

func _convert_from_packed_int32_array(array: PackedInt32Array) -> void:
	_array[0] = array[0]

func _convert_from_packed_int64_array(array: PackedInt64Array) -> void:
	_array[0] = array[0]

func _convert_from_packed_float32_array(array: PackedFloat32Array) -> void:
	_array[0] = array[0]

func _convert_from_packed_float64_array(array: PackedFloat64Array) -> void:
	_array[0] = array[0]

#endregion
=======
static func _convert_from_int(value: int, converted_array: Array[float]) -> void:
	converted_array[0] = value

static func _convert_from_float(value: float, converted_array: Array[float]) -> void:
	converted_array[0] = value

static func _convert_from_array(array: Array, converted_array: Array[float]) -> void:
	converted_array[0] = array[0]

static func _convert_from_packed_int32_array(array: PackedInt32Array, converted_array: Array[float]) -> void:
	converted_array[0] = array[0]

static func _convert_from_packed_int64_array(array: PackedInt64Array, converted_array: Array[float]) -> void:
	converted_array[0] = array[0]

static func _convert_from_packed_float32_array(array: PackedFloat32Array, converted_array: Array[float]) -> void:
	converted_array[0] = array[0]

static func _convert_from_packed_float64_array(array: PackedFloat64Array, converted_array: Array[float]) -> void:
	converted_array[0] = array[0]

#endregion

@warning_ignore("unused_parameter")
func _init(array_size: int) -> void:
	pass
>>>>>>> Stashed changes
