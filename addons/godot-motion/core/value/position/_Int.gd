extends "../_Position.gd"

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func can_convert(value: Variant, array_size: int) -> bool:
	match typeof(value):
		TYPE_INT when _can_convert_from_int(value, array_size):
			return true
		TYPE_FLOAT when _can_convert_from_float(value, array_size):
			return true
	return false

func set_external_value(value: Variant) -> void:
	match typeof(value):
		TYPE_INT:
			_value = _convert_from_int(value)
		TYPE_FLOAT:
			_value = _convert_from_float(value)

func get_external_value() -> Variant:
	return roundf(_value)

@warning_ignore("unused_parameter")
func set_at(index: int, value: float) -> void:
	_value = value

@warning_ignore("unused_parameter")
func get_at(index: int) -> float:
	return _value

#-------------------------------------------------------------------------------

var _value: float

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

static func _convert_from_int(value: int) -> float:
	return value

static func _convert_from_float(value: float) -> float:
	return roundf(value)

#endregion

@warning_ignore("unused_parameter")
func _init(array_size: int) -> void:
	pass
