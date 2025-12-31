class_name GDUT_Vector4MotionPosition extends GDUT_MotionPosition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const DEFAULT_VALUE := Vector4.ZERO

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

@warning_ignore("unused_parameter")
static func create(array_size: int) -> GDUT_MotionPosition:
	return new()

static func validate_incoming_value(value: Variant, array_size: int) -> bool:
	match typeof(value):
		TYPE_INT:
			if array_size != 1 or not _can_convert_from_int(value):
				return false
		TYPE_FLOAT:
			if array_size != 1 or not _can_convert_from_float(value):
				return false
		TYPE_VECTOR4:
			if array_size != 1 or not _can_convert_from_vector4(value):
				return false
		TYPE_VECTOR4I:
			if array_size != 1 or not _can_convert_from_vector4i(value):
				return false
		TYPE_ARRAY:
			if array_size != 1 or not _can_convert_from_array(value):
				return false
		_:
			return false
	return true

func set_incoming_value(value: Variant) -> void:
	match typeof(value):
		TYPE_INT:
			_value = _convert_from_int(value)
		TYPE_FLOAT:
			_value = _convert_from_float(value)
		TYPE_VECTOR4:
			_value = _convert_from_vector4(value)
		TYPE_VECTOR4I:
			_value = _convert_from_vector4i(value)
		TYPE_ARRAY:
			_value = _convert_from_array(value)

func get_outgoing_value() -> Variant:
	return _value

func set_value_at(index: int, value: float) -> void:
	_value[index] = value

func get_value_at(index: int) -> float:
	return _value[index]

#-------------------------------------------------------------------------------

var _value: Vector4

#region converters

@warning_ignore("unused_parameter")
static func _can_convert_from_int(value: int) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_float(value: float) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_vector4(value: Vector3) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_vector4i(value: Vector3i) -> bool:
	return true

static func _can_convert_from_array(value: Array) -> bool:
	if value.size() != 4:
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
	return Vector4(value, value, value, value)

static func _convert_from_vector4(value: Vector4) -> Vector4:
	return value

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
	return converted_value

#endregion
