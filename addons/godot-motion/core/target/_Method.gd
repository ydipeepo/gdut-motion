extends MotionTarget

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func create(
	target_method: Callable,
	target_value_type_hint: int) -> MotionTarget:

	if not _AUTOLOAD_CLASS.has_current():
		_AUTOLOAD_CLASS.print_error(&"ADDON_NOT_READY")
		return null

	var target_value_type: int
	var target_value: Variant
	if target_method.is_valid():
		if _AUTOLOAD_CLASS.is_lambda(target_method):
			#
			# target_method がラムダを指している場合
			#

			if \
				target_method.get_argument_count() == 1 and \
				target_value_type_hint in _VALID_VALUE_TYPES_WITHOUT_DEFAULT_VALUE:

				target_value = _DEFAULT_VALUE_MAP[target_value_type_hint]
				target_value_type = target_value_type_hint
		else:
			#
			# target_method がメソッドもしくはクラスメソッドを指している場合
			#

			if 1 <= target_method.get_argument_count():
				var target := target_method.get_object()
				var target_method_name := target_method.get_method()
				assert(target.has_method(target_method_name))

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

								1, _ when \
									method_args.size() + \
									target_method.get_unbound_arguments_count() - \
									target_method.get_bound_arguments_count() == 1:

									#
									# デフォルト引数の指定が無い場合、もしくは
									# Callable が 1 つ引数を要求する場合
									#

									if method_arg0_type == TYPE_NIL:
										if target_value_type_hint in _VALID_VALUE_TYPES_WITHOUT_DEFAULT_VALUE:
											target_value = _DEFAULT_VALUE_MAP[target_value_type_hint]
											target_value_type = target_value_type_hint
									elif method_arg0_type in _VALID_VALUE_TYPES_WITHOUT_DEFAULT_VALUE:
										target_value = _DEFAULT_VALUE_MAP[method_arg0_type]
										target_value_type = method_arg0_type
						break

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
			_AUTOLOAD_CLASS.print_error(&"INVALID_METHOD_TARGET", target_method)
			return null

	var target := new(
		target_method,
		target_value,
		target_value_type,
		target_value_size,
		target_array_size)
	return _AUTOLOAD_CLASS \
		.get_current() \
		.merge_target(target)

func is_valid() -> bool:
	return _target_method.is_valid()

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
		_target_method.call(_target_value)

func get_value() -> Variant:
	return _target_value

func get_target_method() -> Callable:
	return _target_method

func equals(target: MotionTarget) -> bool:
	return \
		target.get_script() == get_script() and \
		target.is_valid() and \
		_AUTOLOAD_CLASS.is_same_method(target.get_target_method(), _target_method)

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

var _target_method: Callable
var _target_value: Variant
var _target_value_type: int
var _target_value_size: int
var _target_array_size: int
var _name: String

func _init(
	target_method: Callable,
	target_value: Variant,
	target_value_type: int,
	target_value_size: int,
	target_array_size: int) -> void:

	_target_method = target_method
	_target_value = target_value
	_target_value_type = target_value_type
	_target_value_size = target_value_size
	_target_array_size = target_array_size

	var target_method_name := target_method.get_method()
	var target_instance_id := String.num_uint64(
		target_method.get_object().get_instance_id(),
		16,
		true)
	if target_method_name == &"<anonymous lambda>":
		_name = &"%s()" % target_instance_id
	else:
		_name = &"%s-%s()" % [target_instance_id, target_method_name]
