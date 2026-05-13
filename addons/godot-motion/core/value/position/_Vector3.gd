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
		TYPE_VECTOR3 when _can_convert_from_vector3(value, array_size):
			return true
		TYPE_VECTOR3I when _can_convert_from_vector3i(value, array_size):
			return true
		TYPE_ARRAY when _can_convert_from_array(value, array_size):
			return true
	return false

func set_external_value(value: Variant) -> void:
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

func get_external_value() -> Variant:
	return _value

func set_at(index: int, value: float) -> void:
	_value[index] = value

func get_at(index: int) -> float:
	return _value[index]

#-------------------------------------------------------------------------------

var _value: Vector3

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

@warning_ignore("unused_parameter")
static func _can_convert_from_vector3(
	value: Vector3,
	array_size: int) -> bool:

	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_vector3i(
	value: Vector3i,
	array_size: int) -> bool:

	return array_size == 1

static func _can_convert_from_array(
	value: Array,
	array_size: int) -> bool:

	if array_size != 1 or value.size() != 3:
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

@warning_ignore("unused_parameter")
func _init(array_size: int) -> void:
	pass
