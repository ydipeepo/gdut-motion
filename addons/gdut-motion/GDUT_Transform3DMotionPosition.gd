class_name GDUT_Transform3DMotionPosition extends GDUT_MotionPosition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const DEFAULT_VALUE := Transform3D.IDENTITY

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

@warning_ignore("unused_parameter")
static func create(array_size: int) -> GDUT_MotionPosition:
	return new()

static func validate_incoming_value(value: Variant, array_size: int) -> bool:
	match typeof(value):
		TYPE_TRANSFORM3D:
			if array_size != 1 or not _can_convert_from_transform_3d(value):
				return false
		TYPE_PROJECTION:
			if array_size != 1 or not _can_convert_from_projection(value):
				return false
		TYPE_ARRAY:
			if array_size != 1 or not _can_convert_from_array(value):
				return false
		_:
			return false
	return true

func set_incoming_value(value: Variant) -> void:
	match typeof(value):
		TYPE_TRANSFORM3D:
			_value = _convert_from_transform_3d(value)
		TYPE_PROJECTION:
			_value = _convert_from_projection(value)
		TYPE_ARRAY:
			_value = _convert_from_array(value)

func get_outgoing_value() -> Variant:
	return _value

func set_value_at(index: int, value: float) -> void:
	match index:
		0:  _value.basis.x.x = value
		1:  _value.basis.x.y = value
		2:  _value.basis.x.z = value
		3:  _value.basis.y.x = value
		4:  _value.basis.y.y = value
		5:  _value.basis.y.z = value
		6:  _value.basis.z.x = value
		7:  _value.basis.z.y = value
		8:  _value.basis.z.z = value
		9:  _value.origin.x = value
		10: _value.origin.y = value
		11: _value.origin.z = value

func get_value_at(index: int) -> float:
	var value: float
	match index:
		0:  value = _value.basis.x.x
		1:  value = _value.basis.x.y
		2:  value = _value.basis.x.z
		3:  value = _value.basis.y.x
		4:  value = _value.basis.y.y
		5:  value = _value.basis.y.z
		6:  value = _value.basis.z.x
		7:  value = _value.basis.z.y
		8:  value = _value.basis.z.z
		9:  value = _value.origin.x
		10: value = _value.origin.y
		11: value = _value.origin.z
	return value

#-------------------------------------------------------------------------------

var _value: Transform3D

#region converters

@warning_ignore("unused_parameter")
static func _can_convert_from_transform_3d(value: Transform3D) -> bool:
	return true

@warning_ignore("unused_parameter")
static func _can_convert_from_projection(value: Projection) -> bool:
	return true

static func _can_convert_from_array(value: Array) -> bool:
	match value.size():
		2:
			match typeof(value[0]):
				TYPE_BASIS:
					pass
				_:
					return false
			match typeof(value[1]):
				TYPE_VECTOR3, \
				TYPE_VECTOR3I:
					pass
				_:
					return false
		4:
			for index: int in 4:
				match typeof(value[index]):
					TYPE_VECTOR3, \
					TYPE_VECTOR3I:
						pass
					_:
						return false
		12:
			for index: int in 12:
				match typeof(value[index]):
					TYPE_INT, \
					TYPE_FLOAT:
						pass
					_:
						return false
		_:
			return false
	return true

static func _convert_from_transform_3d(value: Transform3D) -> Transform3D:
	return value

static func _convert_from_projection(value: Projection) -> Transform3D:
	return value

static func _convert_from_array(value: Array) -> Transform3D:
	var converted_value: Transform3D
	match value.size():
		2:
			converted_value = Transform3D(value[0], value[1])
		4:
			converted_value = Transform3D(value[0], value[1], value[2], value[3])
		12:
			converted_value.basis.x.x = value[0]
			converted_value.basis.x.y = value[1]
			converted_value.basis.x.z = value[2]
			converted_value.basis.y.x = value[3]
			converted_value.basis.y.y = value[4]
			converted_value.basis.y.z = value[5]
			converted_value.basis.z.x = value[6]
			converted_value.basis.z.y = value[7]
			converted_value.basis.z.z = value[8]
			converted_value.origin.x = value[9]
			converted_value.origin.y = value[10]
			converted_value.origin.z = value[11]
	return converted_value

#endregion
