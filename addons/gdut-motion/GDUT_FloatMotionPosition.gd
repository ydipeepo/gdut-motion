class_name GDUT_FloatMotionPosition extends GDUT_MotionPosition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const DEFAULT_VALUE := 0.0

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func can_convert(value: Variant, array_size: int) -> bool:
	var can_convert: Callable = _float_can_convert_map.get(typeof(value))
	return can_convert.is_valid() and can_convert.call(value, array_size)

func set_value(value: Variant) -> void:
	var convert: Callable = _float_convert_map.get(typeof(value))
	assert(convert.is_valid())
	_value = convert.call(value)

func get_value() -> Variant:
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

static func _convert_from_int(value: int) -> float:
	return value

static func _convert_from_float(value: float) -> float:
	return value

#endregion

@warning_ignore("unused_parameter")
func _init(array_size: int) -> void:
	pass
