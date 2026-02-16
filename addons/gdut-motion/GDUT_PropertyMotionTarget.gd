class_name GDUT_PropertyMotionTarget extends GDUT_MotionTarget

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func is_valid() -> bool:
	return is_instance_valid(_target_object) and not _target_object.is_queued_for_deletion()

func get_name() -> String:
	return _name

func get_value_type() -> int:
	return _target_value_type

func get_value_size() -> int:
	return _target_value_size

func get_array_size() -> int:
	return _target_array_size

func set_value(value: Variant) -> void:
	_target_value = value

	if is_valid:
		_target_object.set_indexed(_target_property_path, _target_value)

func get_value() -> Variant:
	return _target_value

func get_target_object() -> Object:
	return _target_object

func get_target_property_path() -> NodePath:
	return _target_property_path

func equals(target: GDUT_MotionTarget) -> bool:
	return \
		target is GDUT_PropertyMotionTarget and \
		target.is_valid() and \
		target.get_target_object() == _target_object and \
		target.get_target_property_path() == _target_property_path

#-------------------------------------------------------------------------------

var _target_object: Object
var _target_property_path: NodePath
var _target_value: Variant
var _target_value_type: int
var _target_value_size: int
var _target_array_size: int
var _name: String

func _init(
	target_object: Object,
	target_property_path: NodePath,
	target_value: Variant,
	target_value_type: int) -> void:

	match target_value_type:
		TYPE_INT, \
		TYPE_FLOAT:
			_target_value_size = 1
			_target_array_size = 1
		TYPE_VECTOR2, \
		TYPE_VECTOR2I:
			_target_value_size = 2
			_target_array_size = 1
		TYPE_VECTOR3, \
		TYPE_VECTOR3I:
			_target_value_size = 3
			_target_array_size = 1
		TYPE_TRANSFORM2D:
			_target_value_size = 2
			_target_array_size = 3
		TYPE_VECTOR4, \
		TYPE_VECTOR4I:
			_target_value_size = 4
			_target_array_size = 1
		TYPE_BASIS:
			_target_value_size = 3
			_target_array_size = 3
		TYPE_TRANSFORM3D:
			_target_value_size = 3
			_target_array_size = 4
		TYPE_COLOR:
			_target_value_size = 4
			_target_array_size = 1
		TYPE_PACKED_INT32_ARRAY, \
		TYPE_PACKED_INT64_ARRAY, \
		TYPE_PACKED_FLOAT32_ARRAY, \
		TYPE_PACKED_FLOAT64_ARRAY:
			_target_value_size = 1
			_target_array_size = target_value.size()
		TYPE_PACKED_VECTOR2_ARRAY:
			_target_value_size = 2
			_target_array_size = target_value.size()
		TYPE_PACKED_VECTOR3_ARRAY:
			_target_value_size = 3
			_target_array_size = target_value.size()
		TYPE_PACKED_COLOR_ARRAY, \
		TYPE_PACKED_VECTOR4_ARRAY:
			_target_value_size = 4
			_target_array_size = target_value.size()

	_target_object = target_object
	_target_property_path = target_property_path
	_target_value = target_value
	_target_value_type = target_value_type
	_name = &"%s-%s" % [
		String.num_uint64(target_object.get_instance_id(), 16, true),
		str(target_property_path).replace_chars(".:@/\"%", ord("_"))]
