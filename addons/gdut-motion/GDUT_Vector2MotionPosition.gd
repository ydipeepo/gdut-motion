class_name GDUT_Vector2MotionPosition extends GDUT_MotionPosition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const DEFAULT_VALUE := Vector2.ZERO

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
		TYPE_VECTOR2:
			if array_size != 1 or not _can_convert_from_vector2(value):
				return false
		TYPE_VECTOR2I:
			if array_size != 1 or not _can_convert_from_vector2i(value):
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
		TYPE_VECTOR2:
			_value = _convert_from_vector2(value)
		TYPE_VECTOR2I:
			_value = _convert_from_vector2i(value)
		TYPE_ARRAY:
			_value = _convert_from_array(value)

func get_outgoing_value() -> Variant:
=======
static func can_convert(value: Variant, array_size: int) -> bool:
	var can_convert: Callable = _vector2_can_convert_map.get(typeof(value))
	return can_convert.is_valid() and can_convert.call(value, array_size)

func set_value(value: Variant) -> void:
	var convert: Callable = _vector2_convert_map.get(typeof(value))
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

var _value: Vector2

#region converters

<<<<<<< Updated upstream
@warning_ignore("unused_parameter")
static func _can_convert_from_int(value: int) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_float(value: float) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_vector2(value: Vector2) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_vector2i(value: Vector2i) -> bool:
	return true

static func _can_convert_from_array(value: Array) -> bool:
	if value.size() != 2:
=======
static var _vector2_can_convert_map: Dictionary[int, Callable] = {
	TYPE_INT: _can_convert_from_int,
	TYPE_FLOAT: _can_convert_from_float,
	TYPE_VECTOR2: _can_convert_from_vector2,
	TYPE_VECTOR2I: _can_convert_from_vector2i,
	TYPE_ARRAY: _can_convert_from_array,
}

static var _vector2_convert_map: Dictionary[int, Callable] = {
	TYPE_INT: _convert_from_int,
	TYPE_FLOAT: _convert_from_float,
	TYPE_VECTOR2: _convert_from_vector2,
	TYPE_VECTOR2I: _convert_from_vector2i,
	TYPE_ARRAY: _convert_from_array,
}

@warning_ignore("unused_parameter")
static func _can_convert_from_int(value: int, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_float(value: float, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_vector2(value: Vector2, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_vector2i(value: Vector2i, array_size: int) -> bool:
	return array_size == 1

static func _can_convert_from_array(value: Array, array_size: int) -> bool:
	if array_size != 1 or value.size() != 2:
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
	return true

static func _convert_from_int(value: int) -> Vector2:
	return Vector2(value, value)

static func _convert_from_float(value: float) -> Vector2:
	return Vector2(value, value)

static func _convert_from_vector2(value: Vector2) -> Vector2:
	return value

static func _convert_from_vector2i(value: Vector2i) -> Vector2:
	return value

static func _convert_from_array(value: Array) -> Vector2:
	var converted_value: Vector2
	match typeof(value[0]):
		TYPE_INT, \
		TYPE_FLOAT:
			converted_value.x = value[0]
	match typeof(value[1]):
		TYPE_INT, \
		TYPE_FLOAT:
			converted_value.y = value[1]
	return converted_value

#endregion
<<<<<<< Updated upstream
=======

@warning_ignore("unused_parameter")
func _init(array_size: int) -> void:
	pass
>>>>>>> Stashed changes
