@abstract
class_name GDUT_MotionTarget

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func is_same_method(
	method1: Callable,
	method2: Callable) -> bool:

	return _LambdaComparer \
		.new(method1) \
		.is_same_method(method2)

static func from_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL) -> GDUT_MotionTarget:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var target := _create_method_target(
		target_method,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_METHOD_TARGET", target_method)
		return null

	return canonical.merge_target(target)

static func from_method_name(
	target_object: Object,
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL) -> GDUT_MotionTarget:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var target := _create_method_name_target(
		target_object,
		target_method_name,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_METHOD_NAME_TARGET", target_method_name, target_object)
		return null

	return canonical.merge_target(target)

static func from_property(
	target_object: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL) -> GDUT_MotionTarget:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var target := _create_property_target(
		target_object,
		target_property_path,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_PROPERTY_TARGET", target_property_path, target_object)
		return null

	return canonical.merge_target(target)

@abstract
func is_valid() -> bool

@abstract
func get_name() -> String

@abstract
func get_value_type() -> int

@abstract
func get_value_size() -> int

@abstract
func get_array_size() -> int

@abstract
func set_value(value: Variant) -> void

@abstract
func get_value() -> Variant

@abstract
func equals(target: GDUT_MotionTarget) -> bool

#-------------------------------------------------------------------------------

class _LambdaComparer:

	func is_same_method(method: Callable) -> bool:
		return _signal.is_connected(method)

	func is_same_method_name(object: Object, method_name: StringName) -> bool:
		return _signal.is_connected(Callable(object, method_name))

	#
	# Since the functionality provided by Callable alone cannot compare
	# named lambdas and class methods, so perform equivalence comparison of
	# the call destination by once connecting to a signal and checking if
	# it is connected.
	#

	signal _signal

	func _init(method: Callable) -> void:
		_signal.connect(method)

static func _is_lambda(method: Callable) -> bool:
	if method.is_custom():
		var method_name := method.get_method()
		if method_name == &"<anonymous lambda>":
			return true
		var object := method.get_object()
		if object is GDScript:
			if \
				not object.has_method(method_name) or \
				not _LambdaComparer.new(method).is_same_method_name(object, method_name):
				return true
	return false

static func _create_method_target(
	target_method: Callable,
	target_value_type_hint: int) -> GDUT_MotionTarget:

	const DEFAULT_VALUE_MAP: Dictionary[int, Variant] = {
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
	const VALID_VALUE_TYPES: Array[int] = [
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
	const VALID_VALUE_TYPES_WITHOUT_DEFAULT_VALUE: Array[int] = [
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

	var target_value_type: int
	var target_value: Variant
	if target_method.is_valid():
		if _is_lambda(target_method):
			#
			# target_method がラムダを指している場合
			#

			if \
				target_method.get_argument_count() == 1 and \
				target_value_type_hint in VALID_VALUE_TYPES_WITHOUT_DEFAULT_VALUE:

				target_value = DEFAULT_VALUE_MAP[target_value_type_hint]
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
										if method_default_arg0_type in VALID_VALUE_TYPES:
											target_value = method_default_arg0
											target_value_type = method_default_arg0_type
									elif method_arg0_type in VALID_VALUE_TYPES:
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
										if target_value_type_hint in VALID_VALUE_TYPES_WITHOUT_DEFAULT_VALUE:
											target_value = DEFAULT_VALUE_MAP[target_value_type_hint]
											target_value_type = target_value_type_hint
									elif method_arg0_type in VALID_VALUE_TYPES_WITHOUT_DEFAULT_VALUE:
										target_value = DEFAULT_VALUE_MAP[method_arg0_type]
										target_value_type = method_arg0_type
						break
	if target_value_type == TYPE_NIL:
		return null

	return GDUT_MethodMotionTarget.new(
		target_method,
		target_value,
		target_value_type)

static func _create_method_name_target(
	target_object: Object,
	target_method_name: StringName,
	target_value_type_hint: int) -> GDUT_MotionTarget:

	const DEFAULT_VALUE_MAP: Dictionary[int, Variant] = {
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
	const VALID_VALUE_TYPES: Array[int] = [
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
	const VALID_VALUE_TYPES_WITHOUT_DEFAULT_VALUE: Array[int] = [
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

	var target_value_type: int
	var target_value: Variant
	if is_instance_valid(target_object) and not target_method_name.is_empty():
		if target_object.has_method(target_method_name):
			#
			# target_object にメソッド target_method_name が定義されている場合
			#

			for method_info: Dictionary in target_object.get_method_list():
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
									if method_default_arg0_type in VALID_VALUE_TYPES:
										target_value = method_default_arg0
										target_value_type = method_default_arg0_type
								elif method_arg0_type in VALID_VALUE_TYPES:
									target_value = method_default_args.front()
									target_value_type = method_arg0_type
							1:
								#
								# デフォルト引数の指定が無い場合
								#

								if method_arg0_type == TYPE_NIL:
									if target_value_type_hint in VALID_VALUE_TYPES_WITHOUT_DEFAULT_VALUE:
										target_value = DEFAULT_VALUE_MAP[target_value_type_hint]
										target_value_type = target_value_type_hint
								elif method_arg0_type in VALID_VALUE_TYPES_WITHOUT_DEFAULT_VALUE:
									target_value = DEFAULT_VALUE_MAP[method_arg0_type]
									target_value_type = method_arg0_type
					break
	if target_value_type == TYPE_NIL:
		return null

	return GDUT_MethodNameMotionTarget.new(
		target_object,
		target_method_name,
		target_value,
		target_value_type)

static func _create_property_target(
	target_object: Object,
	target_property_path: NodePath,
	target_value_type_hint: int) -> GDUT_MotionTarget:

	const DEFAULT_VALUE_MAP: Dictionary[int, Variant] = {
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
	const VALID_VALUE_TYPES: Array[int] = [
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
	const VALID_VALUE_TYPES_WITHOUT_DEFAULT_VALUE: Array[int] = [
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

	var target_value: Variant
	var target_value_type: int
	if is_instance_valid(target_object) and not target_property_path.is_empty():
		var value: Variant = target_object.get_indexed(target_property_path)
		var value_type := typeof(value)
		if value_type == TYPE_NIL:
			if target_value_type_hint in VALID_VALUE_TYPES_WITHOUT_DEFAULT_VALUE:
				var default_value: Variant = DEFAULT_VALUE_MAP[target_value_type_hint]
				var default_value_type := target_value_type_hint
				target_object.set_indexed(target_property_path, default_value)
				if target_object.get_indexed(target_property_path) != null:
					target_value = default_value
					target_value_type = default_value_type
		elif value_type in VALID_VALUE_TYPES:
			target_value = value
			target_value_type = value_type
	if target_value_type == TYPE_NIL:
		return null

	return GDUT_PropertyMotionTarget.new(
		target_object,
		target_property_path,
		target_value,
		target_value_type)
