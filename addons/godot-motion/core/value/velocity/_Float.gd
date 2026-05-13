extends "../_Velocity.gd"

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func can_convert(value: Variant, array_size: int) -> bool:
	match typeof(value):
		TYPE_INT when _can_convert_from_int(value, array_size):
			return true
		TYPE_FLOAT when _can_convert_from_float(value, array_size):
			return true
		TYPE_ARRAY when _can_convert_from_array(value, array_size):
			return true
		TYPE_PACKED_INT32_ARRAY when _can_convert_from_packed_int32_array(value, array_size):
			return true
		TYPE_PACKED_INT64_ARRAY when _can_convert_from_packed_int64_array(value, array_size):
			return true
		TYPE_PACKED_FLOAT32_ARRAY when _can_convert_from_packed_float32_array(value, array_size):
			return true
		TYPE_PACKED_FLOAT64_ARRAY when _can_convert_from_packed_float64_array(value, array_size):
			return true
	return false

func set_external_value(value: Variant) -> void:
	match typeof(value):
		TYPE_INT:
			_convert_from_int(value, _array)
		TYPE_FLOAT:
			_convert_from_float(value, _array)
		TYPE_ARRAY:
			_convert_from_array(value, _array)
		TYPE_PACKED_INT32_ARRAY:
			_convert_from_packed_int32_array(value, _array)
		TYPE_PACKED_INT64_ARRAY:
			_convert_from_packed_int64_array(value, _array)
		TYPE_PACKED_FLOAT32_ARRAY:
			_convert_from_packed_float32_array(value, _array)
		TYPE_PACKED_FLOAT64_ARRAY:
			_convert_from_packed_float64_array(value, _array)

func get_external_value() -> Variant:
	return _array

func set_at(index: int, value: float) -> void:
	_array[index] = value

func get_at(index: int) -> float:
	return _array[index]

#-------------------------------------------------------------------------------

var _array: Array[float] = [0.0]

#region converters

@warning_ignore("unused_parameter")
static func _can_convert_from_int(
	value: int,
	array_size: int) -> bool:

	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_float(
	value: float,
	array_size: int) -> bool:

	return array_size == 1

static func _can_convert_from_array(
	array: Array,
	array_size: int) -> bool:

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

static func _can_convert_from_packed_int32_array(
	array: PackedInt32Array,
	array_size: int) -> bool:

	return array_size == 1 and array.size() == 1

static func _can_convert_from_packed_int64_array(
	array: PackedInt64Array,
	array_size: int) -> bool:

	return array_size == 1 and array.size() == 1

static func _can_convert_from_packed_float32_array(
	array: PackedFloat32Array,
	array_size: int) -> bool:

	return array_size == 1 and array.size() == 1

static func _can_convert_from_packed_float64_array(
	array: PackedFloat64Array,
	array_size: int) -> bool:

	return array_size == 1 and array.size() == 1

static func _convert_from_int(
	value: int,
	converted_array: Array[float]) -> void:

	converted_array[0] = value

static func _convert_from_float(
	value: float,
	converted_array: Array[float]) -> void:

	converted_array[0] = value

static func _convert_from_array(
	array: Array,
	converted_array: Array[float]) -> void:

	converted_array[0] = array[0]

static func _convert_from_packed_int32_array(
	array: PackedInt32Array,
	converted_array: Array[float]) -> void:

	converted_array[0] = array[0]

static func _convert_from_packed_int64_array(
	array: PackedInt64Array,
	converted_array: Array[float]) -> void:

	converted_array[0] = array[0]

static func _convert_from_packed_float32_array(
	array: PackedFloat32Array,
	converted_array: Array[float]) -> void:

	converted_array[0] = array[0]

static func _convert_from_packed_float64_array(
	array: PackedFloat64Array,
	converted_array: Array[float]) -> void:

	converted_array[0] = array[0]

#endregion

@warning_ignore("unused_parameter")
func _init(array_size: int) -> void:
	pass
