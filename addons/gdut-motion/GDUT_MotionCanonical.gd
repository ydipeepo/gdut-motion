class_name GDUT_Motion extends Node

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

static var canonical: GDUT_Motion:
	get:
		return _canonical

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func get_message_v(message_name: StringName, message_args: Array) -> String:
	var message: String
	if _canonical != null:
		message = _canonical._translation_domain.translate(message_name)
	else:
		var translation: Translation = _TRANSLATIONS.front()
		message = translation.get_message(message_name)
	if not message_args.is_empty():
		message = message.format(message_args)
	return message

static func get_message(message_name: StringName, ...message_args: Array) -> String:
	return get_message_v(message_name, message_args)

static func print_warning(message_name: StringName, ...message_args: Array) -> void:
	if _canonical != null and not _canonical._suppress_warning_message:
		push_warning(get_message_v(message_name, message_args))

static func print_error(message_name: StringName, ...message_args: Array) -> void:
	if _canonical != null and not _canonical._suppress_error_message:
		push_error(get_message_v(message_name, message_args))

<<<<<<< Updated upstream
static func validate_method_name_init(init: Array) -> bool:
	match init.size():
		3 when init[0] is Object and (init[1] is StringName or init[1] is String) and init[2] is int:
			if init[0].has_method(init[1]):
				return true
		2 when init[0] is Object and (init[1] is StringName or init[1] is String):
			if init[0].has_method(init[1]):
				return true
	return false

static func validate_method_init(init: Array) -> bool:
	match init.size():
		2 when init[0] is Callable and init[1] is int:
			return true
		1 when init[0] is Callable:
			return true
	return false

static func validate_property_init(init: Array) -> bool:
	match init.size():
		3 when init[0] is Object and (init[1] is StringName or init[1] is String or init[1] is NodePath) and init[2] is int:
			return true
		2 when init[0] is Object and (init[1] is StringName or init[1] is String or init[1] is NodePath):
			return true
	return false

static func validate_proxy_init(init: Array) -> bool:
	match init.size():
		1 when init[0] is MotionProxy:
			return true
	return false

static func get_method_name_init_target(init: Array) -> Object:
	return init[0]

static func get_method_name_init_target_method_name(init: Array) -> StringName:
	return init[1]

static func get_method_name_init_target_value_type_hint(init: Array) -> int:
	return \
		init[2] \
		if init.size() == 3 and init[2] is int else \
		TYPE_NIL

static func get_method_init_target_method(init: Array) -> Callable:
	return init[0]

static func get_method_init_target_value_type_hint(init: Array) -> int:
	return \
		init[1] \
		if init.size() == 2 and init[1] is int else \
		TYPE_NIL

static func get_property_init_target(init: Array) -> Object:
	return init[0]

static func get_property_init_target_property_path(init: Array) -> NodePath:
	return str(init[1]) if init[1] is StringName else init[1]

static func get_property_init_target_value_type_hint(init: Array) -> int:
	return \
		init[2] \
		if init.size() == 3 and init[2] is int else \
		TYPE_NIL

static func get_proxy_init_proxy(init: Array) -> MotionProxy:
	return init[0]

static func validate_incoming_position(proxy: MotionProxy, value: Variant) -> bool:
	var validate := _validate_incoming_position_value_map[proxy.get_value_type()]
	return \
		not validate.is_null() and \
		validate.call(value, proxy.get_array_size())

static func validate_incoming_velocity(proxy: MotionProxy, value: Variant) -> bool:
	var validate := _validate_incoming_velocity_value_map[proxy.get_value_type()]
	return \
		not validate.is_null() and \
		validate.call(value, proxy.get_array_size())

static func create_position(proxy: MotionProxy) -> GDUT_MotionPosition:
	var position: GDUT_MotionPosition
	var create_position := _create_position_map[proxy.get_value_type()]
	if create_position.is_valid():
		position = create_position.call(proxy.get_array_size())
	return position

static func create_velocity(proxy: MotionProxy) -> GDUT_MotionVelocity:
	var velocity: GDUT_MotionVelocity
	var create_velocity := _create_velocity_map[proxy.get_value_type()]
	if create_velocity.is_valid():
		velocity = create_velocity.call(proxy.get_array_size())
	return velocity

static func create_bitset(proxy: MotionProxy) -> GDUT_MotionBitSet:
	var bitset: GDUT_MotionBitSet
	var create_bitset := _create_bitset_map[proxy.get_value_type()]
	if create_bitset.is_valid():
		bitset = create_bitset.call(proxy.get_value_size(), proxy.get_array_size())
	return bitset

=======
>>>>>>> Stashed changes
static func get_composite_time_scale() -> float:
	var time_scale := Engine.time_scale
	if _canonical != null:
		time_scale *= _canonical._user_time_scale
	return time_scale

static func get_ticks() -> int:
	return Time.get_ticks_msec()

<<<<<<< Updated upstream
func merge_proxy(proxy: MotionProxy) -> MotionProxy:
	var processor: GDUT_MotionProcessor
	for processor_candidate: GDUT_MotionProcessor in get_children():
		if not processor_candidate.is_queued_for_deletion():
			var proxy_candidate := processor_candidate.get_proxy()
			if proxy_candidate.equals(proxy):
				proxy = proxy_candidate
				break
	return proxy
=======
func merge_target(target: GDUT_MotionTarget) -> GDUT_MotionTarget:
	var processor: GDUT_MotionProcessor
	for processor_candidate: GDUT_MotionProcessor in get_children():
		if not processor_candidate.is_queued_for_deletion():
			var target_candidate := processor_candidate.get_target()
			if target_candidate.equals(target):
				target = target_candidate
				break
	return target
>>>>>>> Stashed changes

func schedule_transition(
	transition_factory: GDUT_MotionTransitionFactory,
	continuation: bool) -> Task:

	assert(transition_factory != null)

<<<<<<< Updated upstream
	var proxy := transition_factory.get_proxy()
	assert(proxy.is_valid())
=======
	var target := transition_factory.get_target()
	assert(target.is_valid())
>>>>>>> Stashed changes

	var processor: GDUT_MotionProcessor
	for processor_candidate: GDUT_MotionProcessor in get_children():
		if \
			not processor_candidate.is_queued_for_deletion() and \
<<<<<<< Updated upstream
			processor_candidate.equals(proxy):
=======
			processor_candidate.equals(target):
>>>>>>> Stashed changes

			move_child(processor_candidate, get_child_count())
			processor = processor_candidate
			break

	if processor == null:
		processor = GDUT_MotionProcessor.new(
<<<<<<< Updated upstream
			proxy,
=======
			target,
>>>>>>> Stashed changes
			_retention_duration)
		add_child(processor)

	return processor.schedule_transition(
		transition_factory,
		continuation)

#-------------------------------------------------------------------------------

const _TRANSLATIONS: Array[Translation] = [
	preload("plugin.en.translation"),
	preload("plugin.ja.translation"),
]
const _VALID_USER_TIME_SCALE_ARRAY: Array[float] = [
	0.0625,
	0.125,
	0.25,
	0.5,
	0.75,
	1.0,
	1.25,
	1.5,
	1.75,
	2.0,
	4.0,
	8.0,
	16.0,
]

<<<<<<< Updated upstream
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

static var _validate_incoming_position_value_map: Dictionary[int, Callable] = {
	TYPE_INT: GDUT_IntMotionPosition.validate_incoming_value,
	TYPE_FLOAT: GDUT_FloatMotionPosition.validate_incoming_value,
	TYPE_VECTOR2: GDUT_Vector2MotionPosition.validate_incoming_value,
	TYPE_VECTOR2I: GDUT_Vector2iMotionPosition.validate_incoming_value,
	TYPE_VECTOR3: GDUT_Vector3MotionPosition.validate_incoming_value,
	TYPE_VECTOR3I: GDUT_Vector3iMotionPosition.validate_incoming_value,
	TYPE_TRANSFORM2D: GDUT_Transform2DMotionPosition.validate_incoming_value,
	TYPE_VECTOR4: GDUT_Vector4MotionPosition.validate_incoming_value,
	TYPE_VECTOR4I: GDUT_Vector4iMotionPosition.validate_incoming_value,
	TYPE_BASIS: GDUT_BasisMotionPosition.validate_incoming_value,
	TYPE_TRANSFORM3D: GDUT_Transform3DMotionPosition.validate_incoming_value,
	TYPE_COLOR: GDUT_ColorMotionPosition.validate_incoming_value,
	TYPE_PACKED_INT32_ARRAY: GDUT_PackedInt32ArrayMotionPosition.validate_incoming_value,
	TYPE_PACKED_INT64_ARRAY: GDUT_PackedInt64ArrayMotionPosition.validate_incoming_value,
	TYPE_PACKED_FLOAT32_ARRAY: GDUT_PackedFloat32ArrayMotionPosition.validate_incoming_value,
	TYPE_PACKED_FLOAT64_ARRAY: GDUT_PackedFloat64ArrayMotionPosition.validate_incoming_value,
	TYPE_PACKED_VECTOR2_ARRAY: GDUT_PackedVector2ArrayMotionPosition.validate_incoming_value,
	TYPE_PACKED_VECTOR3_ARRAY: GDUT_PackedVector3ArrayMotionPosition.validate_incoming_value,
	TYPE_PACKED_COLOR_ARRAY: GDUT_PackedColorArrayMotionPosition.validate_incoming_value,
	TYPE_PACKED_VECTOR4_ARRAY: GDUT_PackedVector4ArrayMotionPosition.validate_incoming_value,
}
static var _validate_incoming_velocity_value_map: Dictionary[int, Callable] = {
	TYPE_INT: GDUT_FloatMotionVelocity.validate_incoming_value,
	TYPE_FLOAT: GDUT_FloatMotionVelocity.validate_incoming_value,
	TYPE_VECTOR2: GDUT_Vector2MotionVelocity.validate_incoming_value,
	TYPE_VECTOR2I: GDUT_Vector2MotionVelocity.validate_incoming_value,
	TYPE_VECTOR3: GDUT_Vector3MotionVelocity.validate_incoming_value,
	TYPE_VECTOR3I: GDUT_Vector3MotionVelocity.validate_incoming_value,
	TYPE_TRANSFORM2D: GDUT_Transform2DMotionVelocity.validate_incoming_value,
	TYPE_VECTOR4: GDUT_Vector4MotionVelocity.validate_incoming_value,
	TYPE_VECTOR4I: GDUT_Vector4MotionVelocity.validate_incoming_value,
	TYPE_BASIS: GDUT_BasisMotionVelocity.validate_incoming_value,
	TYPE_TRANSFORM3D: GDUT_Transform3DMotionVelocity.validate_incoming_value,
	TYPE_COLOR: GDUT_Vector4MotionVelocity.validate_incoming_value,
	TYPE_PACKED_INT32_ARRAY: GDUT_PackedFloat32ArrayMotionVelocity.validate_incoming_value,
	TYPE_PACKED_INT64_ARRAY: GDUT_PackedFloat64ArrayMotionVelocity.validate_incoming_value,
	TYPE_PACKED_FLOAT32_ARRAY: GDUT_PackedFloat32ArrayMotionVelocity.validate_incoming_value,
	TYPE_PACKED_FLOAT64_ARRAY: GDUT_PackedFloat64ArrayMotionVelocity.validate_incoming_value,
	TYPE_PACKED_VECTOR2_ARRAY: GDUT_PackedVector2ArrayMotionVelocity.validate_incoming_value,
	TYPE_PACKED_VECTOR3_ARRAY: GDUT_PackedVector3ArrayMotionVelocity.validate_incoming_value,
	TYPE_PACKED_COLOR_ARRAY: GDUT_PackedVector4ArrayMotionVelocity.validate_incoming_value,
	TYPE_PACKED_VECTOR4_ARRAY: GDUT_PackedVector4ArrayMotionVelocity.validate_incoming_value,
}
static var _create_position_map: Dictionary[int, Callable] = {
	TYPE_INT: GDUT_IntMotionPosition.create,
	TYPE_FLOAT: GDUT_FloatMotionPosition.create,
	TYPE_VECTOR2: GDUT_Vector2MotionPosition.create,
	TYPE_VECTOR2I: GDUT_Vector2iMotionPosition.create,
	TYPE_VECTOR3: GDUT_Vector3MotionPosition.create,
	TYPE_VECTOR3I: GDUT_Vector3iMotionPosition.create,
	TYPE_TRANSFORM2D: GDUT_Transform2DMotionPosition.create,
	TYPE_VECTOR4: GDUT_Vector4MotionPosition.create,
	TYPE_VECTOR4I: GDUT_Vector4iMotionPosition.create,
	TYPE_BASIS: GDUT_BasisMotionPosition.create,
	TYPE_TRANSFORM3D: GDUT_Transform3DMotionPosition.create,
	TYPE_COLOR: GDUT_ColorMotionPosition.create,
	TYPE_PACKED_INT32_ARRAY: GDUT_PackedInt32ArrayMotionPosition.create,
	TYPE_PACKED_INT64_ARRAY: GDUT_PackedInt64ArrayMotionPosition.create,
	TYPE_PACKED_FLOAT32_ARRAY: GDUT_PackedFloat32ArrayMotionPosition.create,
	TYPE_PACKED_FLOAT64_ARRAY: GDUT_PackedFloat64ArrayMotionPosition.create,
	TYPE_PACKED_VECTOR2_ARRAY: GDUT_PackedVector2ArrayMotionPosition.create,
	TYPE_PACKED_VECTOR3_ARRAY: GDUT_PackedVector3ArrayMotionPosition.create,
	TYPE_PACKED_COLOR_ARRAY: GDUT_PackedColorArrayMotionPosition.create,
	TYPE_PACKED_VECTOR4_ARRAY: GDUT_PackedVector4ArrayMotionPosition.create,
}
static var _create_velocity_map: Dictionary[int, Callable] = {
	TYPE_INT: GDUT_FloatMotionVelocity.create,
	TYPE_FLOAT: GDUT_FloatMotionVelocity.create,
	TYPE_VECTOR2: GDUT_Vector2MotionVelocity.create,
	TYPE_VECTOR2I: GDUT_Vector2MotionVelocity.create,
	TYPE_VECTOR3: GDUT_Vector3MotionVelocity.create,
	TYPE_VECTOR3I: GDUT_Vector3MotionVelocity.create,
	TYPE_TRANSFORM2D: GDUT_Transform2DMotionVelocity.create,
	TYPE_VECTOR4: GDUT_Vector4MotionVelocity.create,
	TYPE_VECTOR4I: GDUT_Vector4MotionVelocity.create,
	TYPE_BASIS: GDUT_BasisMotionVelocity.create,
	TYPE_TRANSFORM3D: GDUT_Transform3DMotionVelocity.create,
	TYPE_COLOR: GDUT_Vector4MotionVelocity.create,
	TYPE_PACKED_INT32_ARRAY: GDUT_PackedFloat32ArrayMotionVelocity.create,
	TYPE_PACKED_INT64_ARRAY: GDUT_PackedFloat64ArrayMotionVelocity.create,
	TYPE_PACKED_FLOAT32_ARRAY: GDUT_PackedFloat32ArrayMotionVelocity.create,
	TYPE_PACKED_FLOAT64_ARRAY: GDUT_PackedFloat64ArrayMotionVelocity.create,
	TYPE_PACKED_VECTOR2_ARRAY: GDUT_PackedVector2ArrayMotionVelocity.create,
	TYPE_PACKED_VECTOR3_ARRAY: GDUT_PackedVector3ArrayMotionVelocity.create,
	TYPE_PACKED_COLOR_ARRAY: GDUT_PackedVector4ArrayMotionVelocity.create,
	TYPE_PACKED_VECTOR4_ARRAY: GDUT_PackedVector4ArrayMotionVelocity.create,
}
static var _create_bitset_map: Dictionary[int, Callable] = {
	TYPE_INT: GDUT_SmallMotionBitSet.create,
	TYPE_FLOAT: GDUT_SmallMotionBitSet.create,
	TYPE_VECTOR2: GDUT_SmallMotionBitSet.create,
	TYPE_VECTOR2I: GDUT_SmallMotionBitSet.create,
	TYPE_VECTOR3: GDUT_SmallMotionBitSet.create,
	TYPE_VECTOR3I: GDUT_SmallMotionBitSet.create,
	TYPE_TRANSFORM2D: GDUT_SmallMotionBitSet.create,
	TYPE_VECTOR4: GDUT_SmallMotionBitSet.create,
	TYPE_VECTOR4I: GDUT_SmallMotionBitSet.create,
	TYPE_BASIS: GDUT_SmallMotionBitSet.create,
	TYPE_TRANSFORM3D: GDUT_SmallMotionBitSet.create,
	TYPE_COLOR: GDUT_SmallMotionBitSet.create,
	TYPE_PACKED_INT32_ARRAY: GDUT_LargeMotionBitSet.create,
	TYPE_PACKED_INT64_ARRAY: GDUT_LargeMotionBitSet.create,
	TYPE_PACKED_FLOAT32_ARRAY: GDUT_LargeMotionBitSet.create,
	TYPE_PACKED_FLOAT64_ARRAY: GDUT_LargeMotionBitSet.create,
	TYPE_PACKED_VECTOR2_ARRAY: GDUT_LargeMotionBitSet.create,
	TYPE_PACKED_VECTOR3_ARRAY: GDUT_LargeMotionBitSet.create,
	TYPE_PACKED_COLOR_ARRAY: GDUT_LargeMotionBitSet.create,
	TYPE_PACKED_VECTOR4_ARRAY: GDUT_LargeMotionBitSet.create,
}
=======
>>>>>>> Stashed changes
static var _canonical: GDUT_Motion
var _translation_domain: TranslationDomain
var _retention_duration: float
var _suppress_warning_message: bool
var _suppress_error_message: bool
var _user_time_scale_detection_enabled: bool
var _user_time_scale_detection_sample_count: int
var _user_time_scale_detection_initial_skip_count: int

var _user_time_scale := 1.0
var _user_time_scale_start_ticks: int
var _user_time_scale_accumulated_delta := 0.0
var _user_time_scale_counter := 0

static func _adjust_user_time_scale(user_time_scale: float) -> float:
	var n := _VALID_USER_TIME_SCALE_ARRAY.size() - 1
	var s := 0
	var e := n
	while s <= e:
		var m := s + (e - s) / 2
		if _VALID_USER_TIME_SCALE_ARRAY[m] == user_time_scale:
			return _VALID_USER_TIME_SCALE_ARRAY[m]
		if _VALID_USER_TIME_SCALE_ARRAY[m] < user_time_scale:
			s = m + 1
		else:
			e = m - 1
	if s >= n:
		return _VALID_USER_TIME_SCALE_ARRAY.back()
	if e < 0:
		return _VALID_USER_TIME_SCALE_ARRAY.front()
	return \
		_VALID_USER_TIME_SCALE_ARRAY[s] \
		if \
			absf(_VALID_USER_TIME_SCALE_ARRAY[s] - user_time_scale) < \
			absf(_VALID_USER_TIME_SCALE_ARRAY[e] - user_time_scale) else \
		_VALID_USER_TIME_SCALE_ARRAY[e]

func _enter_tree() -> void:
	_translation_domain = TranslationDomain.new()
	for translation: Translation in _TRANSLATIONS:
		_translation_domain.add_translation(translation)

	_retention_duration = ProjectSettings.get_setting("gdut/motion/transition_processor/retention_duration", 5.0)
	_suppress_warning_message = ProjectSettings.get_setting("gdut/motion/debug/suppress_warning_message", false)
	_suppress_error_message = ProjectSettings.get_setting("gdut/motion/debug/suppress_error_message", false)
	_user_time_scale_detection_enabled = ProjectSettings.get_setting("gdut/motion/debug/user_time_scale_detection_enabled", true)
	_user_time_scale_detection_sample_count = ProjectSettings.get_setting("gdut/motion/debug/user_time_scale_detection_sample_count", 15)
	_user_time_scale_detection_initial_skip_count = ProjectSettings.get_setting("gdut/motion/debug/user_time_scale_detection_initial_skip_count", 30)

	_canonical = self

func _exit_tree() -> void:
	_canonical = null

#
# Within the Engine class, there exists a user time scale separate from
# the game time scale (this is set by the SceneDebugger).
# As of version 4.6.2, there is no way to retrieve this value.
#
# Here, we attempt to estimate and adjust the user time scale so that
# behavior is somewhat consistent during debugging.
# This implementation has accuracy issues, and once it becomes possible to
# retrieve the user time scale in the future, the following code will be removed.
#

func _ready() -> void:
	if EngineDebugger.is_active() and _user_time_scale_detection_enabled:
		_user_time_scale_start_ticks = get_ticks()
	_user_time_scale = 1.0

func _process(delta: float) -> void:
	if EngineDebugger.is_active() and _user_time_scale_detection_enabled:
		if 0 < _user_time_scale_detection_initial_skip_count:
			_user_time_scale_detection_initial_skip_count -= 1
		else:
			_user_time_scale_accumulated_delta += delta
			_user_time_scale_counter += 1

			if _user_time_scale_counter == _user_time_scale_detection_sample_count:
				var ticks := get_ticks()
				var sample_delta := (ticks - _user_time_scale_start_ticks) / 1000.0
				var game_time_scale := Engine.time_scale
				var user_time_scale := _user_time_scale_accumulated_delta / (sample_delta * game_time_scale)

				_user_time_scale = _adjust_user_time_scale(user_time_scale)
				_user_time_scale_accumulated_delta = 0.0
				_user_time_scale_start_ticks = ticks
				_user_time_scale_counter = 0
