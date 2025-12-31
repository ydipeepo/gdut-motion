class_name GDUT_BasisMotionPosition extends GDUT_MotionPosition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const DEFAULT_VALUE := Basis.IDENTITY

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

@warning_ignore("unused_parameter")
static func create(array_size: int) -> GDUT_MotionPosition:
	return new()

static func validate_incoming_value(value: Variant, array_size: int) -> bool:
	match typeof(value):
		TYPE_QUATERNION:
			if array_size != 1 or not _can_convert_from_quaternion(value):
				return false
		TYPE_BASIS:
			if array_size != 1 or not _can_convert_from_basis(value):
				return false
		TYPE_TRANSFORM3D:
			if array_size != 1 or not _can_convert_from_transform_3d(value):
				return false
		TYPE_ARRAY:
			if array_size != 1 or not _can_convert_from_array(value):
				return false
		_:
			return false
	return true

func set_incoming_value(value: Variant) -> void:
	match typeof(value):
		TYPE_QUATERNION:
			_value = _convert_from_quaternion(value)
		TYPE_BASIS:
			_value = _convert_from_basis(value)
		TYPE_TRANSFORM3D:
			_value = _convert_from_transform_3d(value)
		TYPE_ARRAY:
			_value = _convert_from_array(value)

func get_outgoing_value() -> Variant:
	return _value

func set_value_at(index: int, value: float) -> void:
	@warning_ignore("integer_division")
	_value[index / 3][index % 3] = value

func get_value_at(index: int) -> float:
	@warning_ignore("integer_division")
	return _value[index / 3][index % 3]

#-------------------------------------------------------------------------------

var _value: Basis

#region converters

@warning_ignore("unused_parameter")
static func _can_convert_from_quaternion(value: Quaternion) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_basis(value: Basis) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_transform_3d(value: Transform3D) -> bool:
	return true

static func _can_convert_from_array(value: Array) -> bool:
	match value.size():
		2:
			match typeof(value[0]):
				TYPE_VECTOR3, \
				TYPE_VECTOR3I:
					pass
				_:
					return false
			match typeof(value[1]):
				TYPE_INT, \
				TYPE_FLOAT:
					pass
				_:
					return false
		3:
			for index: int in 3:
				match typeof(value[index]):
					TYPE_VECTOR3, \
					TYPE_VECTOR3I:
						pass
					_:
						return false
		9:
			for index: int in 9:
				match typeof(value[index]):
					TYPE_INT, \
					TYPE_FLOAT:
						pass
					_:
						return false
		_:
			return false
	return true

static func _convert_from_quaternion(value: Quaternion) -> Basis:
	return value

static func _convert_from_basis(value: Basis) -> Basis:
	return value

static func _convert_from_transform_3d(value: Transform3D) -> Basis:
	return value.basis

static func _convert_from_array(value: Array) -> Basis:
	var converted_value: Basis
	match value.size():
		2:
			converted_value = Basis(value[0], value[1])
		3:
			converted_value = Basis(value[0], value[1], value[2])
		9:
			for index: int in 9:
				@warning_ignore("integer_division")
				converted_value[index / 3][index % 3] = value[index]
	return converted_value

#endregion
