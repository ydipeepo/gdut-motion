class_name GDUT_FloatMotionPosition extends GDUT_MotionPosition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const DEFAULT_VALUE := 0.0

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
		_:
			return false
	return true

func set_incoming_value(value: Variant) -> void:
	match typeof(value):
		TYPE_INT:
			_value = _convert_from_int(value)
		TYPE_FLOAT:
			_value = _convert_from_float(value)

func get_outgoing_value() -> Variant:
=======
static func can_convert(value: Variant, array_size: int) -> bool:
	var can_convert: Callable = _float_can_convert_map.get(typeof(value))
	return can_convert.is_valid() and can_convert.call(value, array_size)

func set_value(value: Variant) -> void:
	var convert: Callable = _float_convert_map.get(typeof(value))
	assert(convert.is_valid())
	_value = convert.call(value)

func get_value() -> Variant:
>>>>>>> Stashed changes
	return _value

@warning_ignore("unused_parameter")
func set_value_at(index: int, value: float) -> void:
	_value = value

@warning_ignore("unused_parameter")
func get_value_at(index: int) -> float:
	return _value

#-------------------------------------------------------------------------------

var _value: float

#region converters

<<<<<<< Updated upstream
@warning_ignore("unused_parameter")
static func _can_convert_from_int(value: int) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_float(value: float) -> bool:
	return true
=======
static var _float_can_convert_map: Dictionary[int, Callable] = {
	TYPE_INT: _can_convert_from_int,
	TYPE_FLOAT: _can_convert_from_float,
}

static var _float_convert_map: Dictionary[int, Callable] = {
	TYPE_INT: _convert_from_int,
	TYPE_FLOAT: _convert_from_float,
}

@warning_ignore("unused_parameter")
static func _can_convert_from_int(value: int, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_float(value: float, array_size: int) -> bool:
	return array_size == 1
>>>>>>> Stashed changes

static func _convert_from_int(value: int) -> float:
	return value

static func _convert_from_float(value: float) -> float:
	return value

#endregion
<<<<<<< Updated upstream
=======

@warning_ignore("unused_parameter")
func _init(array_size: int) -> void:
	pass
>>>>>>> Stashed changes
