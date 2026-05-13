@tool
class_name EasingMotionPreset extends MotionPreset

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_DURATION := _EASING_CLASS.MIN_DURATION
const MAX_DURATION := 10.0
const DURATION_STEP := 1e-3
const DEFAULT_DURATION := _EASING_CLASS.DEFAULT_DURATION

const MIN_DELAY := _EASING_CLASS.MIN_DELAY
const MAX_DELAY := 10.0
const DELAY_STEP := 1e-2
const DEFAULT_DELAY := _EASING_CLASS.DEFAULT_DELAY

const MIN_LOOP := _EASING_CLASS.MIN_LOOP
const MAX_LOOP := 10
const LOOP_STEP := 1
const DEFAULT_LOOP := _EASING_CLASS.DEFAULT_LOOP

const MIN_LOOP_DELAY := _EASING_CLASS.MIN_LOOP_DELAY
const MAX_LOOP_DELAY := 1.0
const LOOP_DELAY_STEP := 1e-2
const DEFAULT_LOOP_DELAY := _EASING_CLASS.DEFAULT_LOOP_DELAY

const DEFAULT_ALTERNATE := _EASING_CLASS.DEFAULT_ALTERNATE

const DEFAULT_REVERSED := _EASING_CLASS.DEFAULT_REVERSED

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

@export_range(
	MIN_DURATION,
	MAX_DURATION,
	DURATION_STEP,
	"or_greater",
	"suffix:s")
var duration := DEFAULT_DURATION:
	set = set_duration,
	get = get_duration

@export_range(
	MIN_DELAY,
	MAX_DELAY,
	DELAY_STEP,
	"or_greater",
	"suffix:s")
var delay := DEFAULT_DELAY:
	set = set_delay,
	get = get_delay

@export_range(
	MIN_LOOP,
	MAX_LOOP,
	LOOP_STEP,
	"or_greater")
var loop := DEFAULT_LOOP:
	set = set_loop,
	get = get_loop

@export_range(
	MIN_LOOP_DELAY,
	MAX_LOOP_DELAY,
	LOOP_DELAY_STEP,
	"or_greater",
	"suffix:s")
var loop_delay := DEFAULT_LOOP_DELAY:
	set = set_loop_delay,
	get = get_loop_delay

@export
var alternate := DEFAULT_ALTERNATE:
	set = set_alternate,
	get = get_alternate

@export
var reversed := DEFAULT_REVERSED:
	set = set_reversed,
	get = get_reversed

@export
var easing: Easing:
	set = set_easing,
	get = get_easing

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target_class_ids() -> Array[int]:
	var target_class_ids: Array[int]
	if is_instance_valid(_easing):
		var target_class: Script = _EASING_CLASS
		target_class_ids.append(target_class.get_instance_id())
		var easing_class: Script = _easing.get_script()
		match easing_class:
			BackEasing:
				target_class = _BACK_CLASS
				target_class_ids.append(target_class.get_instance_id())
			BezierEasing:
				target_class = _BEZIER_CLASS
				target_class_ids.append(target_class.get_instance_id())
			#BlendEasing:
			#	pass
			#CrossfadeEasing:
			#	pass
			ElasticEasing:
				target_class = _ELASTIC_CLASS
				target_class_ids.append(target_class.get_instance_id())
			LinearEasing:
				target_class = _LINEAR_CLASS
				target_class_ids.append(target_class.get_instance_id())
			PowerEasing:
				target_class = _POWER_CLASS
				target_class_ids.append(target_class.get_instance_id())
			RandomEasing:
				target_class = _RANDOM_CLASS
				target_class_ids.append(target_class.get_instance_id())
			StepsEasing:
				target_class = _STEPS_CLASS
				target_class_ids.append(target_class.get_instance_id())
			TweenEasing:
				target_class = _TWEEN_CLASS
				target_class_ids.append(target_class.get_instance_id())
	return target_class_ids

func set_duration(value: float) -> void:
	if _duration != value:
		_duration = value
		emit_changed()

func get_duration() -> float:
	return _duration

func set_delay(value: float) -> void:
	if _delay != value:
		_delay = value
		emit_changed()

func get_delay() -> float:
	return _delay

func set_loop(value: int) -> void:
	if _loop != value:
		_loop = value
		emit_changed()

func get_loop() -> int:
	return _loop

func set_loop_delay(value: float) -> void:
	if _loop_delay != value:
		_loop_delay = value
		emit_changed()

func get_loop_delay() -> float:
	return _loop_delay

func set_alternate(value: bool) -> void:
	if _alternate != value:
		_alternate = value
		emit_changed()

func get_alternate() -> bool:
	return _alternate

func set_reversed(value: bool) -> void:
	if _reversed != value:
		_reversed = value
		emit_changed()

func get_reversed() -> bool:
	return _reversed

func set_easing(value: Easing) -> void:
	if _easing != value:
		if is_instance_valid(_easing):
			_easing.changed.disconnect(_on_easing_changed)
		criteria_invalidating.emit()
		_easing = value
		if is_instance_valid(_easing):
			_easing.changed.connect(_on_easing_changed)
		criteria_invalidated.emit()
		emit_changed()

func get_easing() -> Easing:
	return _easing

func is_valid() -> bool:
	return is_instance_valid(_easing)

func apply(transition_factory: MotionTransitionFactory) -> bool:
	var target := transition_factory as MotionTransitionFactory
	if target != null and _easing != null:
		var target_class: Script = target.get_script()
		match target_class:
			_EASING_CLASS:
				target.set_process(get_process())
				target.set_duration(_duration)
				target.set_delay(_delay)
				target.set_loop(_loop)
				target.set_loop_delay(_loop_delay)
				target.set_alternate(_alternate)
				target.set_reversed(_reversed)
				target.set_function(_easing.create())
				return true
			_BACK_CLASS when _easing is BackEasing:
				target.set_process(get_process())
				target.set_duration(_duration)
				target.set_delay(_delay)
				target.set_loop(_loop)
				target.set_loop_delay(_loop_delay)
				target.set_alternate(_alternate)
				target.set_reversed(_reversed)
				target.set_overshoot(_easing.get_overshoot())
				target.set_ease(_easing.get_ease())
				return true
			_BEZIER_CLASS when _easing is BezierEasing:
				target.set_process(get_process())
				target.set_duration(_duration)
				target.set_delay(_delay)
				target.set_loop(_loop)
				target.set_loop_delay(_loop_delay)
				target.set_alternate(_alternate)
				target.set_reversed(_reversed)
				target.set_x1(_easing.get_x1())
				target.set_y1(_easing.get_y1())
				target.set_x2(_easing.get_x2())
				target.set_y2(_easing.get_y2())
				return true
			_ELASTIC_CLASS when _easing is ElasticEasing:
				target.set_process(get_process())
				target.set_duration(_duration)
				target.set_delay(_delay)
				target.set_loop(_loop)
				target.set_loop_delay(_loop_delay)
				target.set_alternate(_alternate)
				target.set_reversed(_reversed)
				target.set_amplitude(_easing.get_amplitude())
				target.set_period(_easing.get_period())
				target.set_ease(_easing.get_ease())
				return true
			_LINEAR_CLASS when _easing is LinearEasing:
				target.set_process(get_process())
				target.set_duration(_duration)
				target.set_delay(_delay)
				target.set_loop(_loop)
				target.set_loop_delay(_loop_delay)
				target.set_alternate(_alternate)
				target.set_reversed(_reversed)
				target.set_y_array(_easing.get_y_array())
				return true
			_POWER_CLASS when _easing is PowerEasing:
				target.set_process(get_process())
				target.set_duration(_duration)
				target.set_delay(_delay)
				target.set_loop(_loop)
				target.set_loop_delay(_loop_delay)
				target.set_alternate(_alternate)
				target.set_reversed(_reversed)
				target.set_exponent(_easing.get_exponent())
				target.set_ease(_easing.get_ease())
				return true
			_RANDOM_CLASS when _easing is RandomEasing:
				target.set_process(get_process())
				target.set_duration(_duration)
				target.set_delay(_delay)
				target.set_loop(_loop)
				target.set_loop_delay(_loop_delay)
				target.set_alternate(_alternate)
				target.set_reversed(_reversed)
				target.set_segments(_easing.get_segments())
				target.set_intensity(_easing.get_intensity())
				target.set_seed(_easing.get_seed())
				return true
			_STEPS_CLASS when _easing is StepsEasing:
				target.set_process(get_process())
				target.set_duration(_duration)
				target.set_delay(_delay)
				target.set_loop(_loop)
				target.set_loop_delay(_loop_delay)
				target.set_alternate(_alternate)
				target.set_reversed(_reversed)
				target.set_segments(_easing.get_segments())
				target.set_round(_easing.get_round())
				return true
			_TWEEN_CLASS when _easing is TweenEasing:
				target.set_process(get_process())
				target.set_duration(_duration)
				target.set_delay(_delay)
				target.set_loop(_loop)
				target.set_loop_delay(_loop_delay)
				target.set_alternate(_alternate)
				target.set_reversed(_reversed)
				target.set_trans(_easing.get_trans())
				target.set_ease(_easing.get_ease())
				return true
	return false

#-------------------------------------------------------------------------------

const _EASING_CLASS := preload("uid://cvoofu1h8pec1")
const _BACK_CLASS := preload("uid://bjpg1boh2yayy")
const _BEZIER_CLASS := preload("uid://g6bi36a3g1s3")
const _ELASTIC_CLASS := preload("uid://cyc32wca84jau")
const _LINEAR_CLASS := preload("uid://cbnayo3750njw")
const _POWER_CLASS := preload("uid://b418k13gylvdc")
const _RANDOM_CLASS := preload("uid://cp8mkaedusky0")
const _STEPS_CLASS := preload("uid://1qfbdejoesif")
const _TWEEN_CLASS := preload("uid://fxlxlw5pced6")

var _duration := DEFAULT_DURATION
var _delay := DEFAULT_DELAY
var _loop := DEFAULT_LOOP
var _loop_delay := DEFAULT_LOOP_DELAY
var _alternate := DEFAULT_ALTERNATE
var _reversed := DEFAULT_REVERSED
var _easing: Easing

func _on_easing_changed() -> void:
	emit_changed()
