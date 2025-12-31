class_name GDUT_PackedInt32ArrayMotionPosition extends GDUT_MotionPosition

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

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
	for index: int in _array.size():
		_exotic_array[index] = roundi(_array[index])
	return _exotic_array

func set_value_at(index: int, value: float) -> void:
	_array[index] = value

func get_value_at(index: int) -> float:
	return _array[index]

#-------------------------------------------------------------------------------

var _array: PackedFloat32Array
var _exotic_array: PackedInt32Array

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
	return roundf(value)

#endregion

func _init(array_size: int) -> void:
	assert(0 <= array_size)
	_array.resize(array_size)
	_exotic_array.resize(array_size)
