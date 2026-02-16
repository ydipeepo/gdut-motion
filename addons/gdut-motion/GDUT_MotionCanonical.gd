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

static func get_composite_time_scale() -> float:
	var time_scale := Engine.time_scale
	if _canonical != null:
		time_scale *= _canonical._user_time_scale
	return time_scale

static func get_ticks() -> int:
	return Time.get_ticks_msec()

func merge_target(target: GDUT_MotionTarget) -> GDUT_MotionTarget:
	var processor: GDUT_MotionProcessor
	for processor_candidate: GDUT_MotionProcessor in get_children():
		if not processor_candidate.is_queued_for_deletion():
			var target_candidate := processor_candidate.get_target()
			if target_candidate.equals(target):
				target = target_candidate
				break
	return target

func schedule_transition(
	transition_factory: GDUT_MotionTransitionFactory,
	continuation: bool) -> Task:

	assert(transition_factory != null)

	var target := transition_factory.get_target()
	assert(target.is_valid())

	var processor: GDUT_MotionProcessor
	for processor_candidate: GDUT_MotionProcessor in get_children():
		if \
			not processor_candidate.is_queued_for_deletion() and \
			processor_candidate.equals(target):

			move_child(processor_candidate, get_child_count())
			processor = processor_candidate
			break

	if processor == null:
		processor = GDUT_MotionProcessor.new(
			target,
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
