class_name GDUT_Transform2DMotionPosition extends GDUT_MotionPosition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const DEFAULT_VALUE := Transform2D.IDENTITY

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

@warning_ignore("unused_parameter")
static func create(array_size: int) -> GDUT_MotionPosition:
	return new()

static func validate_incoming_value(value: Variant, array_size: int) -> bool:
	match typeof(value):
		TYPE_TRANSFORM2D:
			if array_size != 1 or not _can_convert_from_transform_2d(value):
				return false
		TYPE_ARRAY:
			if array_size != 1 or not _can_convert_from_array(value):
				return false
		_:
			return false
	return true

func set_incoming_value(value: Variant) -> void:
	match typeof(value):
		TYPE_TRANSFORM2D:
			_value = _convert_from_transform_2d(value)
		TYPE_ARRAY:
			_value = _convert_from_array(value)

func get_outgoing_value() -> Variant:
	return _value

func set_value_at(index: int, value: float) -> void:
	@warning_ignore("integer_division")
	_value[index / 2][index % 2] = value

func get_value_at(index: int) -> float:
	@warning_ignore("integer_division")
	return _value[index / 2][index % 2]

#-------------------------------------------------------------------------------

var _value: Transform2D

#region converters

@warning_ignore("unused_parameter")
static func _can_convert_from_transform_2d(value: Transform2D) -> bool:
	return true

static func _can_convert_from_array(value: Array) -> bool:
	match value.size():
		2:
			match typeof(value[0]):
				TYPE_INT, \
				TYPE_FLOAT:
					pass
				_:
					return false
			match typeof(value[1]):
				TYPE_VECTOR2, \
				TYPE_VECTOR2I:
					pass
				_:
					return false
		3:
			for index: int in 3:
				match typeof(value[index]):
					TYPE_VECTOR2, \
					TYPE_VECTOR2I:
						pass
					_:
						return false
		4:
			match typeof(value[0]):
				TYPE_INT, \
				TYPE_FLOAT:
					pass
				_:
					return false
			match typeof(value[1]):
				TYPE_VECTOR2, \
				TYPE_VECTOR2I:
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
				TYPE_VECTOR2, \
				TYPE_VECTOR2I:
					pass
				_:
					return false
		6:
			for index: int in 6:
				match typeof(value[index]):
					TYPE_INT, \
					TYPE_FLOAT:
						pass
					_:
						return false
		_:
			return false
	return true

static func _convert_from_transform_2d(value: Transform2D) -> Transform2D:
	return value

static func _convert_from_array(value: Array) -> Transform2D:
	var converted_value: Transform2D
	match value.size():
		2:
			converted_value = Transform2D(value[0], value[1])
		3:
			converted_value = Transform2D(value[0], value[1], value[2])
		4:
			converted_value = Transform2D(value[0], value[1], value[2], value[3])
		6:
			for index: int in 6:
				@warning_ignore("integer_division")
				converted_value[index / 2][index % 2] = value[index]
	return converted_value

#endregion
