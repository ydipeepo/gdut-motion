class_name GDUT_ColorMotionPosition extends GDUT_MotionPosition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const DEFAULT_VALUE := Color()

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func can_convert(value: Variant, array_size: int) -> bool:
	var can_convert: Callable = _color_can_convert_map.get(typeof(value))
	return can_convert.is_valid() and can_convert.call(value, array_size)

func set_value(value: Variant) -> void:
	var convert: Callable = _color_convert_map.get(typeof(value))
	assert(convert.is_valid())
	_value = convert.call(value)

func get_value() -> Variant:
	return _value

func set_value_at(index: int, value: float) -> void:
	_value[index] = value

func get_value_at(index: int) -> float:
	return _value[index]

#-------------------------------------------------------------------------------

var _value: Color

#region converters

static var _color_can_convert_map: Dictionary[int, Callable] = {
	TYPE_INT: _can_convert_from_int,
	TYPE_STRING: _can_convert_from_string,
	TYPE_VECTOR3: _can_convert_from_vector3,
	TYPE_VECTOR3I: _can_convert_from_vector3i,
	TYPE_VECTOR4: _can_convert_from_vector4,
	TYPE_VECTOR4I: _can_convert_from_vector4i,
	TYPE_COLOR: _can_convert_from_color,
	TYPE_STRING_NAME: _can_convert_from_string_name,
	TYPE_ARRAY: _can_convert_from_array,
}

static var _color_convert_map: Dictionary[int, Callable] = {
	TYPE_INT: _convert_from_int,
	TYPE_STRING: _convert_from_string,
	TYPE_VECTOR3: _convert_from_vector3,
	TYPE_VECTOR3I: _convert_from_vector3i,
	TYPE_VECTOR4: _convert_from_vector4,
	TYPE_VECTOR4I: _convert_from_vector4i,
	TYPE_COLOR: _convert_from_color,
	TYPE_STRING_NAME: _convert_from_string_name,
	TYPE_ARRAY: _convert_from_array,
}

static func _can_convert_from_int(value: int, array_size: int) -> bool:
	return array_size == 1 and (value & 0xFFFFFF) == value

static func _can_convert_from_string(value: String, array_size: int) -> bool:
	return array_size == 1 and not value.is_empty()

@warning_ignore("unused_parameter")
static func _can_convert_from_vector3(value: Vector3, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_vector3i(value: Vector3i, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_vector4(value: Vector4, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_vector4i(value: Vector4i, array_size: int) -> bool:
	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_color(value: Color, array_size: int) -> bool:
	return array_size == 1

static func _can_convert_from_string_name(value: StringName, array_size: int) -> bool:
	return array_size == 1 and not value.is_empty()

static func _can_convert_from_array(value: Array, array_size: int) -> bool:
	if array_size != 1 or value.size() != 3 or value.size() != 4:
		return false
	for index: int in value.size():
		match typeof(value[index]):
			TYPE_INT, \
			TYPE_FLOAT:
				pass
			_:
				return false
	return true

static func _convert_from_int(value: int) -> Color:
	return Color.hex((value << 8) | 0x000000FF)

static func _convert_from_string(value: String) -> Color:
	return value

static func _convert_from_vector3(value: Vector3) -> Color:
	var converted_value: Color
	converted_value.r = value.x
	converted_value.g = value.y
	converted_value.b = value.z
	return converted_value

static func _convert_from_vector3i(value: Vector3i) -> Color:
	var converted_value: Color
	converted_value.r8 = value.x
	converted_value.g8 = value.y
	converted_value.b8 = value.z
	return converted_value

static func _convert_from_vector4(value: Vector4) -> Color:
	var converted_value: Color
	converted_value.r = value.x
	converted_value.g = value.y
	converted_value.b = value.z
	converted_value.a = value.w
	return converted_value

static func _convert_from_vector4i(value: Vector4i) -> Color:
	var converted_value: Color
	converted_value.r8 = value.x
	converted_value.g8 = value.y
	converted_value.b8 = value.z
	converted_value.a8 = value.w
	return converted_value

static func _convert_from_color(value: Color) -> Color:
	return value

static func _convert_from_string_name(value: StringName) -> Color:
	return Color(value)

static func _convert_from_array(value: Array) -> Color:
	var converted_value: Color
	match typeof(value[0]):
		TYPE_INT:
			converted_value.r8 = value[0]
		TYPE_FLOAT:
			converted_value.r = value[0]
	match typeof(value[1]):
		TYPE_INT:
			converted_value.g8 = value[1]
		TYPE_FLOAT:
			converted_value.g = value[1]
	match typeof(value[2]):
		TYPE_INT:
			converted_value.b8 = value[2]
		TYPE_FLOAT:
			converted_value.b = value[2]
	if value.size() == 4:
		match typeof(value[3]):
			TYPE_INT:
				converted_value.a8 = value[3]
			TYPE_FLOAT:
				converted_value.a = value[3]
	return converted_value

#endregion

@warning_ignore("unused_parameter")
func _init(array_size: int) -> void:
	pass
