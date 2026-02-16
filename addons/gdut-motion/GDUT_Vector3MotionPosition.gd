class_name GDUT_Vector3MotionPosition extends GDUT_MotionPosition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const DEFAULT_VALUE := Vector3.ZERO

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
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
		TYPE_VECTOR3:
			if array_size != 1 or not _can_convert_from_vector3(value):
				return false
		TYPE_VECTOR3I:
			if array_size != 1 or not _can_convert_from_vector3i(value):
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
		TYPE_VECTOR3:
			_value = _convert_from_vector3(value)
		TYPE_VECTOR3I:
			_value = _convert_from_vector3i(value)
		TYPE_ARRAY:
			_value = _convert_from_array(value)

func get_outgoing_value() -> Variant:
=======
static func can_convert(value: Variant, array_size: int) -> bool:
	var can_convert: Callable = _vector3_can_convert_map.get(typeof(value))
	return can_convert.is_valid() and can_convert.call(value, array_size)

func set_value(value: Variant) -> void:
	var convert: Callable = _vector3_convert_map.get(typeof(value))
	assert(convert.is_valid())
	_value = convert.call(value)

func get_value() -> Variant:
>>>>>>> Stashed changes
	return _value

func set_value_at(index: int, value: float) -> void:
	_value[index] = value

func get_value_at(index: int) -> float:
	return _value[index]

#-------------------------------------------------------------------------------

var _value: Vector3

#region converters

<<<<<<< Updated upstream
@warning_ignore("unused_parameter")
static func _can_convert_from_int(value: int) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_float(value: float) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_vector3(value: Vector3) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_vector3i(value: Vector3i) -> bool:
	return true

static func _can_convert_from_array(value: Array) -> bool:
	if value.size() != 3:
=======
static var _vector3_can_convert_map: Dictionary[int, Callable] = {
	TYPE_INT: _can_convert_from_int,
	TYPE_FLOAT: _can_convert_from_float,
	TYPE_VECTOR3: _can_convert_from_vector3,
	TYPE_VECTOR3I: _can_convert_from_vector3i,
	TYPE_ARRAY: _can_convert_from_array,
}

static var _vector3_convert_map: Dictionary[int, Callable] = {
	TYPE_INT: _convert_from_int,
	TYPE_FLOAT: _convert_from_float,
	TYPE_VECTOR3: _convert_from_vector3,
	TYPE_VECTOR3I: _convert_from_vector3i,
	TYPE_ARRAY: _convert_from_array,
}

@warning_ignore("unused_parameter")
static func _can_convert_from_int(value: int, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_float(value: float, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_vector3(value: Vector3, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_vector3i(value: Vector3i, array_size: int) -> bool:
	return array_size == 1

static func _can_convert_from_array(value: Array, array_size: int) -> bool:
	if array_size != 1 or value.size() != 3:
>>>>>>> Stashed changes
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
	return true

static func _convert_from_int(value: int) -> Vector3:
	return Vector3(value, value, value)

static func _convert_from_float(value: float) -> Vector3:
	return Vector3(value, value, value)

static func _convert_from_vector3(value: Vector3) -> Vector3:
	return value

static func _convert_from_vector3i(value: Vector3i) -> Vector3:
	return value

static func _convert_from_array(value: Array) -> Vector3:
	var converted_value: Vector3
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
	return converted_value

#endregion
<<<<<<< Updated upstream
=======

@warning_ignore("unused_parameter")
func _init(array_size: int) -> void:
	pass
>>>>>>> Stashed changes
