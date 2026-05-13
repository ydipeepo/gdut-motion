extends MotionTarget

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func create(
	target_object: Object,
	target_property_path: NodePath,
	target_value_type_hint: int) -> MotionTarget:

	if not _AUTOLOAD_CLASS.has_current():
		_AUTOLOAD_CLASS.print_error(&"ADDON_NOT_READY")
		return null

	var target_value: Variant
	var target_value_type: int
	if is_instance_valid(target_object) and not target_property_path.is_empty():
		var value: Variant = target_object.get_indexed(target_property_path)
		var value_type := typeof(value)
		if value_type == TYPE_NIL:
			if target_value_type_hint in _VALID_VALUE_TYPES_WITHOUT_DEFAULT_VALUE:
				var default_value: Variant = _DEFAULT_VALUE_MAP[target_value_type_hint]
				var default_value_type := target_value_type_hint
				target_object.set_indexed(target_property_path, default_value)
				if target_object.get_indexed(target_property_path) != null:
					target_value = default_value
					target_value_type = default_value_type
		elif value_type in _VALID_VALUE_TYPES:
			target_value = value
			target_value_type = value_type

	var target_value_size: int
	var target_array_size: int
	match target_value_type:
		TYPE_INT, \
		TYPE_FLOAT:
			target_value_size = 1
			target_array_size = 1
		TYPE_VECTOR2, \
		TYPE_VECTOR2I:
			target_value_size = 2
			target_array_size = 1
		TYPE_VECTOR3, \
		TYPE_VECTOR3I:
			target_value_size = 3
			target_array_size = 1
		TYPE_TRANSFORM2D:
			target_value_size = 2
			target_array_size = 3
		TYPE_VECTOR4, \
		TYPE_VECTOR4I:
			target_value_size = 4
			target_array_size = 1
		TYPE_BASIS:
			target_value_size = 3
			target_array_size = 3
		TYPE_TRANSFORM3D:
			target_value_size = 3
			target_array_size = 4
		TYPE_COLOR:
			target_value_size = 4
			target_array_size = 1
		TYPE_PACKED_INT32_ARRAY, \
		TYPE_PACKED_INT64_ARRAY, \
		TYPE_PACKED_FLOAT32_ARRAY, \
		TYPE_PACKED_FLOAT64_ARRAY:
			target_value_size = 1
			target_array_size = target_value.size()
		TYPE_PACKED_VECTOR2_ARRAY:
			target_value_size = 2
			target_array_size = target_value.size()
		TYPE_PACKED_VECTOR3_ARRAY:
			target_value_size = 3
			target_array_size = target_value.size()
		TYPE_PACKED_COLOR_ARRAY, \
		TYPE_PACKED_VECTOR4_ARRAY:
			target_value_size = 4
			target_array_size = target_value.size()
		_:
			_AUTOLOAD_CLASS.print_error(&"INVALID_PROPERTY_TARGET", target_property_path, target_object)
			return null

	var target := new(
		target_object,
		target_property_path,
		target_value,
		target_value_type,
		target_value_size,
		target_array_size)
	return _AUTOLOAD_CLASS \
		.get_current() \
		.merge_target(target)

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

	if is_valid():
		_target_object.set_indexed(_target_property_path, _target_value)

func get_value() -> Variant:
	return _target_value

func get_target_object() -> Object:
	return _target_object

func get_target_property_path() -> NodePath:
	return _target_property_path

func equals(target: MotionTarget) -> bool:
	return \
		target.get_script() == get_script() and \
		target.is_valid() and \
		target.get_target_object() == _target_object and \
		target.get_target_property_path() == _target_property_path

#-------------------------------------------------------------------------------

const _AUTOLOAD_CLASS := preload("uid://p04dph4xrfh3")

const _DEFAULT_VALUE_MAP: Dictionary[int, Variant] = {
	TYPE_INT: 0,
	TYPE_FLOAT: 0.0,
	TYPE_VECTOR2: Vector2.ZERO,
	TYPE_VECTOR2I: Vector2i.ZERO,
	TYPE_VECTOR3: Vector3.ZERO,
	TYPE_VECTOR3I: Vector3i.ZERO,
	TYPE_TRANSFORM2D: Transform2D.IDENTITY,
	TYPE_VECTOR4: Vector4.ZERO,
	TYPE_VECTOR4I: Vector4i.ZERO,
	TYPE_BASIS: Basis.IDENTITY,
	TYPE_TRANSFORM3D: Transform3D.IDENTITY,
	TYPE_COLOR: Color.BLACK,
}
const _VALID_VALUE_TYPES: Array[int] = [
	TYPE_INT,
	TYPE_FLOAT,
	TYPE_VECTOR2,
	TYPE_VECTOR2I,
	TYPE_VECTOR3,
	TYPE_VECTOR3I,
	TYPE_TRANSFORM2D,
	TYPE_VECTOR4,
	TYPE_VECTOR4I,
	TYPE_BASIS,
	TYPE_TRANSFORM3D,
	TYPE_COLOR,
	TYPE_PACKED_INT32_ARRAY,
	TYPE_PACKED_INT64_ARRAY,
	TYPE_PACKED_FLOAT32_ARRAY,
	TYPE_PACKED_FLOAT64_ARRAY,
	TYPE_PACKED_VECTOR2_ARRAY,
	TYPE_PACKED_VECTOR3_ARRAY,
	TYPE_PACKED_COLOR_ARRAY,
	TYPE_PACKED_VECTOR4_ARRAY,
]
const _VALID_VALUE_TYPES_WITHOUT_DEFAULT_VALUE: Array[int] = [
	TYPE_INT,
	TYPE_FLOAT,
	TYPE_VECTOR2,
	TYPE_VECTOR2I,
	TYPE_VECTOR3,
	TYPE_VECTOR3I,
	TYPE_TRANSFORM2D,
	TYPE_VECTOR4,
	TYPE_VECTOR4I,
	TYPE_BASIS,
	TYPE_TRANSFORM3D,
	TYPE_COLOR,
]

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
	target_value_type: int,
	target_value_size: int,
	target_array_size: int) -> void:

	_target_object = target_object
	_target_property_path = target_property_path
	_target_value = target_value
	_target_value_type = target_value_type
	_target_value_size = target_value_size
	_target_array_size = target_array_size
	_name = &"%s-%s" % [
		String.num_uint64(target_object.get_instance_id(), 16, true),
		str(target_property_path).replace_chars(".:@/\"%", ord("_"))]
