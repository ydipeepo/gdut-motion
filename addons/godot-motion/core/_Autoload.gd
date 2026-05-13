extends Node

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func has_current() -> bool:
	return _current != null

static func get_current() -> Node:
	assert(_current != null)
	return _current

static func get_message_v(message_name: StringName, message_args: Array) -> String:
	var message: String
	if _translation_domain == null:
		message = message_name
	else:
		message = _translation_domain.translate(message_name)
		if not message_args.is_empty():
			message = message.format(message_args)
	return message

static func get_message(message_name: StringName, ...message_args: Array) -> String:
	return get_message_v(message_name, message_args)

static func print_warning(message_name: StringName, ...message_args: Array) -> void:
	if has_current() and not get_current().get_suppress_error_message():
		push_warning(get_message_v(message_name, message_args))

static func print_error(message_name: StringName, ...message_args: Array) -> void:
	if has_current() and not get_current().get_suppress_error_message():
		push_error(get_message_v(message_name, message_args))

func get_suppress_warning_message() -> bool:
	return _suppress_warning_message

func get_suppress_error_message() -> bool:
	return _suppress_error_message

static func get_composite_time_scale() -> float:
	var time_scale := Engine.time_scale
	if _current != null:
		time_scale *= _current.get_user_time_scale()
	return time_scale

static func get_ticks() -> int:
	return _ticks

func get_user_time_scale() -> float:
	return 1.0 if _debug_uts_estimator == null else _debug_uts

static func is_lambda(method: Callable) -> bool:
	const ANONYMOUS_LAMBDA_METHOD_NAME := &"<anonymous lambda>"

	if method.is_custom():
		var method_name := method.get_method()
		if method_name == ANONYMOUS_LAMBDA_METHOD_NAME:
			return true
		var object := method.get_object()
		if object is GDScript:
			if \
				not object.has_method(method_name) or \
				not _LambdaComparer.new(method).is_same_method_name(object, method_name):
				return true
	return false

static func is_same_method(method1: Callable, method2: Callable) -> bool:
	return _LambdaComparer \
		.new(method1) \
		.is_same_method(method2)

func merge_target(target: MotionTarget) -> MotionTarget:
	var processor: _RPOCESSOR_CLASS
	for processor_candidate: _RPOCESSOR_CLASS in get_children():
		if not processor_candidate.is_queued_for_deletion():
			var target_candidate := processor_candidate.get_target()
			if target_candidate.equals(target):
				target = target_candidate
				break
	return target

func schedule_transition_factory(
	transition_factory: MotionTransitionFactory,
	transition_skip_time: float) -> Task:

	assert(is_instance_valid(transition_factory))

	var target := transition_factory.get_target()
	assert(target.is_valid())

	var processor: _RPOCESSOR_CLASS
	for processor_candidate: _RPOCESSOR_CLASS in get_children():
		if not processor_candidate.is_queued_for_deletion():
			var target_candidate := processor_candidate.get_target()
			if \
				target_candidate.is_valid() and \
				target_candidate.equals(target):

				move_child(processor_candidate, get_child_count())
				processor = processor_candidate
				break

	if processor == null:
		processor = _RPOCESSOR_CLASS.new(
			target,
			_retention_duration)
		add_child(processor)

	return processor.schedule_transition_factory(
		transition_factory,
		transition_skip_time)

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

const _RPOCESSOR_CLASS := preload("uid://roc8sqhfqaxy")
const _UTS_ESTIMATOR_CLASS := preload("uid://dnwplk78ggh6x")

static var _current: Node
static var _translation_domain := _get_translation_domain()
static var _ticks: int
var _retention_duration: float
var _suppress_warning_message: bool
var _suppress_error_message: bool
var _debug_uts_estimator: _UTS_ESTIMATOR_CLASS
var _debug_uts: float

static func _get_translation_domain() -> TranslationDomain:
	const TRANSLATIONS: Array[Translation] = [
		preload("../plugin.en.translation"),
		preload("../plugin.ja.translation"),
	]

	var translation_domain := TranslationDomain.new()
	for translation: Translation in TRANSLATIONS:
		translation_domain.add_translation(translation)
	return translation_domain

func _enter_tree() -> void:
	_current = self

	_retention_duration = ProjectSettings.get_setting("godot_motion/transition_processor/retention_duration", 5.0)
	_suppress_warning_message = ProjectSettings.get_setting("godot_motion/debug/suppress_warning_message", false)
	_suppress_error_message = ProjectSettings.get_setting("godot_motion/debug/suppress_error_message", false)

	if EngineDebugger.is_active():
		_debug_uts_estimator = _UTS_ESTIMATOR_CLASS.new()
	_debug_uts = 1.0

func _exit_tree() -> void:
	_current = null

func _process(delta: float) -> void:
	if EngineDebugger.is_active():
		_debug_uts = _debug_uts_estimator.estimate(delta)

	_ticks = Time.get_ticks_msec()

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	_ticks = Time.get_ticks_msec()
