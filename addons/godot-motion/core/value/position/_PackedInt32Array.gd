extends "../_Position.gd"

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func can_convert(value: Variant, array_size: int) -> bool:
	match typeof(value):
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
	_exotic_array_dirty = true

func get_external_value() -> Variant:
	if _exotic_array_dirty:
		for index: int in _array.size():
			_exotic_array[index] = roundi(_array[index])
		_exotic_array_dirty = false
	return _exotic_array

func set_at(index: int, value: float) -> void:
	_array[index] = value
	_exotic_array_dirty = true

func get_at(index: int) -> float:
	return _array[index]

#-------------------------------------------------------------------------------

var _array: PackedFloat32Array
var _exotic_array: PackedInt32Array
var _exotic_array_dirty: bool

#region converters

static func _can_convert_from_array(
	array: Array,
	array_size: int) -> bool:

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

static func _can_convert_from_packed_int32_array(
	array: PackedInt32Array,
	array_size: int) -> bool:

	return array.size() == array_size

static func _can_convert_from_packed_int64_array(
	array: PackedInt64Array,
	array_size: int) -> bool:

	return array.size() == array_size

static func _can_convert_from_packed_float32_array(
	array: PackedFloat32Array,
	array_size: int) -> bool:

	return array.size() == array_size

static func _can_convert_from_packed_float64_array(
	array: PackedFloat64Array,
	array_size: int) -> bool:

	return array.size() == array_size

static func _convert_from_array(
	array: Array,
	converted_array: PackedFloat32Array) -> void:

	var write := 0
	for value: Variant in array:
		match typeof(value):
			TYPE_INT:
				converted_array[write] = value
				write += 1
			TYPE_FLOAT:
				converted_array[write] = roundf(value)
				write += 1

static func _convert_from_packed_int32_array(
	array: PackedInt32Array,
	converted_array: PackedFloat32Array) -> void:

	var write := 0
	for value: int in array:
		converted_array[write] = value
		write += 1

static func _convert_from_packed_int64_array(
	array: PackedInt64Array,
	converted_array: PackedFloat32Array) -> void:

	var write := 0
	for value: int in array:
		converted_array[write] = value
		write += 1

static func _convert_from_packed_float32_array(
	array: PackedFloat32Array,
	converted_array: PackedFloat32Array) -> void:

	var write := 0
	for value: float in array:
		converted_array[write] = roundf(value)
		write += 1

static func _convert_from_packed_float64_array(
	array: PackedFloat64Array,
	converted_array: PackedFloat32Array) -> void:

	var write := 0
	for value: float in array:
		converted_array[write] = roundf(value)
		write += 1

#endregion

func _init(array_size: int) -> void:
	_array.resize(array_size)
	_exotic_array.resize(array_size)
	_exotic_array_dirty = true
