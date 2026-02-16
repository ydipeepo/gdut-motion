class_name GDUT_Vector4iMotionPosition extends GDUT_MotionPosition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const DEFAULT_VALUE := Vector4i.ZERO

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func can_convert(value: Variant, array_size: int) -> bool:
	var can_convert: Callable = _vector4i_can_convert_map.get(typeof(value))
	return can_convert.is_valid() and can_convert.call(value, array_size)

func set_value(value: Variant) -> void:
	var convert: Callable = _vector4i_convert_map.get(typeof(value))
	assert(convert.is_valid())
	_value = convert.call(value)

func get_value() -> Variant:
	return Vector4i(_value.round())

func set_value_at(index: int, value: float) -> void:
	_value[index] = value

func get_value_at(index: int) -> float:
	return _value[index]

#-------------------------------------------------------------------------------

var _value: Vector4

#region converters

static var _vector4i_can_convert_map: Dictionary[int, Callable] = {
	TYPE_INT: _can_convert_from_int,
	TYPE_FLOAT: _can_convert_from_float,
	TYPE_VECTOR4: _can_convert_from_vector4,
	TYPE_VECTOR4I: _can_convert_from_vector4i,
	TYPE_ARRAY: _can_convert_from_array,
}

static var _vector4i_convert_map: Dictionary[int, Callable] = {
	TYPE_INT: _convert_from_int,
	TYPE_FLOAT: _convert_from_float,
	TYPE_VECTOR4: _convert_from_vector4,
	TYPE_VECTOR4I: _convert_from_vector4i,
	TYPE_ARRAY: _convert_from_array,
}

@warning_ignore("unused_parameter")
static func _can_convert_from_int(value: int, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_float(value: float, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_vector4(value: Vector3, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_vector4i(value: Vector3i, array_size: int) -> bool:
	return array_size == 1

static func _can_convert_from_array(value: Array, array_size: int) -> bool:
	if array_size != 1 or value.size() != 4:
		return false
	match typeof(value[0]):
		TYPE_INT, \
		TYPE_FLOAT:
			pass
		_:
			return false
	match typeof(value[1]):
		TYPE_INT, \
		TYPE_FLOAT:
			pass
		_:
			return false
	match typeof(value[2]):
		TYPE_INT, \
		TYPE_FLOAT:
			pass
		_:
			return false
	match typeof(value[3]):
		TYPE_INT, \
		TYPE_FLOAT:
			pass
		_:
			return false
	return true

static func _convert_from_int(value: int) -> Vector4:
	return Vector4(value, value, value, value)

static func _convert_from_float(value: float) -> Vector4:
	return Vector4(value, value, value, value).round()

static func _convert_from_vector4(value: Vector4) -> Vector4:
	return value.round()

static func _convert_from_vector4i(value: Vector4i) -> Vector4:
	return value

static func _convert_from_array(value: Array) -> Vector4:
	var converted_value: Vector4
	match typeof(value[0]):
		TYPE_INT, \
		TYPE_FLOAT:
			converted_value.x = value[0]
	match typeof(value[1]):
		TYPE_INT, \
		TYPE_FLOAT:
			converted_value.y = value[1]
	match typeof(value[2]):
		TYPE_INT, \
		TYPE_FLOAT:
			converted_value.z = value[2]
	match typeof(value[3]):
		TYPE_INT, \
		TYPE_FLOAT:
			converted_value.w = value[3]
	return converted_value.round()

#endregion

@warning_ignore("unused_parameter")
func _init(array_size: int) -> void:
	pass
