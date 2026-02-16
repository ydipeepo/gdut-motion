class_name GDUT_ColorMotionPosition extends GDUT_MotionPosition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const DEFAULT_VALUE := Color()

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
		TYPE_STRING:
			if array_size != 1 or not _can_convert_from_string(value):
				return false
		TYPE_VECTOR3:
			if array_size != 1 or not _can_convert_from_vector3(value):
				return false
		TYPE_VECTOR3I:
			if array_size != 1 or not _can_convert_from_vector3i(value):
				return false
		TYPE_VECTOR4:
			if array_size != 1 or not _can_convert_from_vector4(value):
				return false
		TYPE_VECTOR4I:
			if array_size != 1 or not _can_convert_from_vector4i(value):
				return false
		TYPE_COLOR:
			if array_size != 1 or not _can_convert_from_color(value):
				return false
		TYPE_STRING_NAME:
			if array_size != 1 or not _can_convert_from_string_name(value):
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
		TYPE_STRING:
			_value = _convert_from_string(value)
		TYPE_VECTOR3:
			_value = _convert_from_vector3(value)
		TYPE_VECTOR3I:
			_value = _convert_from_vector3i(value)
		TYPE_VECTOR4:
			_value = _convert_from_vector4(value)
		TYPE_VECTOR4I:
			_value = _convert_from_vector4i(value)
		TYPE_COLOR:
			_value = _convert_from_color(value)
		TYPE_STRING_NAME:
			_value = _convert_from_string_name(value)
		TYPE_ARRAY:
			_value = _convert_from_array(value)

func get_outgoing_value() -> Variant:
=======
static func can_convert(value: Variant, array_size: int) -> bool:
	var can_convert: Callable = _color_can_convert_map.get(typeof(value))
	return can_convert.is_valid() and can_convert.call(value, array_size)

func set_value(value: Variant) -> void:
	var convert: Callable = _color_convert_map.get(typeof(value))
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

var _value: Color

#region converters

<<<<<<< Updated upstream
static func _can_convert_from_int(value: int) -> bool:
	return (value & 0xFFFFFF) == value

static func _can_convert_from_string(value: String) -> bool:
	return not value.is_empty()

@warning_ignore("unused_parameter")
static func _can_convert_from_vector3(value: Vector3) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_vector3i(value: Vector3i) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_vector4(value: Vector4) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_vector4i(value: Vector4i) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_color(value: Color) -> bool:
	return true

static func _can_convert_from_string_name(value: StringName) -> bool:
	return not value.is_empty()

static func _can_convert_from_array(value: Array) -> bool:
	if value.size() != 3 or value.size() != 4:
=======
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
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
	return Color(value.x, value.y, value.z)
=======
	var converted_value: Color
	converted_value.r = value.x
	converted_value.g = value.y
	converted_value.b = value.z
	return converted_value
>>>>>>> Stashed changes

static func _convert_from_vector3i(value: Vector3i) -> Color:
	var converted_value: Color
	converted_value.r8 = value.x
	converted_value.g8 = value.y
	converted_value.b8 = value.z
	return converted_value

static func _convert_from_vector4(value: Vector4) -> Color:
<<<<<<< Updated upstream
	return Color(value.x, value.y, value.z, value.w)
=======
	var converted_value: Color
	converted_value.r = value.x
	converted_value.g = value.y
	converted_value.b = value.z
	converted_value.a = value.w
	return converted_value
>>>>>>> Stashed changes

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
<<<<<<< Updated upstream
=======

@warning_ignore("unused_parameter")
func _init(array_size: int) -> void:
	pass
>>>>>>> Stashed changes
