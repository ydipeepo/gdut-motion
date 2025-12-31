class_name GDUT_MethodNameMotionProxy extends MotionProxy

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func create(
	target: Node,
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL) -> MotionProxy:

	var target_value_type: int
	var target_value: Variant
	if is_instance_valid(target) and not target_method_name.is_empty():
		if target.has_method(target_method_name):
			#
			# target にメソッド target_method_name が定義されている場合
			#

			for method_info: Dictionary in target.get_method_list():
				if method_info.name == target_method_name:
					var method_args: Array[Dictionary] = method_info.args
					if not method_args.is_empty():
						var method_default_args: Array = method_info.default_args
						var method_arg0_type: int = method_args.front().type
						match method_args.size() - method_default_args.size():
							0:
								#
								# デフォルト引数が指定されている場合
								#

								if method_arg0_type == TYPE_NIL:
									var method_default_arg0: Variant = method_default_args.front()
									var method_default_arg0_type := typeof(method_default_arg0)
									if method_default_arg0_type in _VALID_VALUE_TYPES:
										target_value = method_default_arg0
										target_value_type = method_default_arg0_type
								elif method_arg0_type in _VALID_VALUE_TYPES:
									target_value = method_default_args.front()
									target_value_type = method_arg0_type
							1:
								#
								# デフォルト引数の指定が無い場合
								#

								if method_arg0_type == TYPE_NIL:
									if target_value_type_hint in _VALID_VALUE_TYPES_WITHOUT_DEFAULT_VALUE:
										target_value = _DEFAULT_VALUE_MAP[target_value_type_hint]
										target_value_type = target_value_type_hint
								elif method_arg0_type in _VALID_VALUE_TYPES_WITHOUT_DEFAULT_VALUE:
									target_value = _DEFAULT_VALUE_MAP[method_arg0_type]
									target_value_type = method_arg0_type
					break
	if target_value_type == TYPE_NIL:
		return null

	return new(
		target,
		target_method_name,
		target_value,
		target_value_type)

func is_valid() -> bool:
	return is_instance_valid(_target) and not _target.is_queued_for_deletion()

func get_name() -> String:
	return _name

func set_value(value: Variant) -> void:
	_target_value = value
	if is_valid():
		_target.call(_target_method_name, _target_value)

func get_value() -> Variant:
	return _target_value

func get_value_type() -> int:
	return _target_value_type

func get_value_size() -> int:
	return _target_value_size

func get_array_size() -> int:
	return _target_array_size

func get_target() -> Object:
	return _target

func get_target_method_name() -> StringName:
	return _target_method_name

func equals(proxy: MotionProxy) -> bool:
	return \
		proxy is GDUT_MethodNameMotionProxy and \
		proxy.is_valid() and \
		proxy.get_target() == _target and \
		proxy.get_target_method_name() == _target_method_name

#-------------------------------------------------------------------------------

const _DEFAULT_VALUE_MAP: Dictionary[int, Variant] = {
	TYPE_INT: GDUT_IntMotionPosition.DEFAULT_VALUE,
	TYPE_FLOAT: GDUT_FloatMotionPosition.DEFAULT_VALUE,
	TYPE_VECTOR2: GDUT_Vector2MotionPosition.DEFAULT_VALUE,
	TYPE_VECTOR2I: GDUT_Vector2iMotionPosition.DEFAULT_VALUE,
	TYPE_VECTOR3: GDUT_Vector3MotionPosition.DEFAULT_VALUE,
	TYPE_VECTOR3I: GDUT_Vector3iMotionPosition.DEFAULT_VALUE,
	TYPE_TRANSFORM2D: GDUT_Transform2DMotionPosition.DEFAULT_VALUE,
	TYPE_VECTOR4: GDUT_Vector4MotionPosition.DEFAULT_VALUE,
	TYPE_VECTOR4I: GDUT_Vector4iMotionPosition.DEFAULT_VALUE,
	TYPE_BASIS: GDUT_BasisMotionPosition.DEFAULT_VALUE,
	TYPE_TRANSFORM3D: GDUT_Transform3DMotionPosition.DEFAULT_VALUE,
	TYPE_COLOR: GDUT_ColorMotionPosition.DEFAULT_VALUE,
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

var _target: Node
var _target_method_name: StringName
var _target_value: Variant
var _target_value_type: int
var _target_value_size: int
var _target_array_size: int
var _name: String

func _init(
	target: Node,
	target_method_name: StringName,
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

	_target = target
	_target_method_name = target_method_name
	_target_value = target_value
	_target_value_type = target_value_type

	_name = "%s-%s()" % [
		String.num_uint64(
			target.get_instance_id(),
			16,
			true),
		target_method_name]
