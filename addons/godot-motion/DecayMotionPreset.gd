@tool
class_name DecayMotionPreset extends MotionPreset

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_POWER := _DECAY_CLASS.MIN_POWER
const MAX_POWER := 10.0
const POWER_STEP := 1e-2
const DEFAULT_POWER := _DECAY_CLASS.DEFAULT_POWER

const MIN_TIME_CONSTANT := _DECAY_CLASS.MIN_TIME_CONSTANT
const MAX_TIME_CONSTANT := 10.0
const TIME_CONSTANT_STEP := 1e-2
const DEFAULT_TIME_CONSTANT := _DECAY_CLASS.DEFAULT_TIME_CONSTANT

const MIN_REST_DELTA := _DECAY_CLASS.MIN_REST_DELTA
const MAX_REST_DELTA := 1.0
const REST_DELTA_STEP := 1e-4
const DEFAULT_REST_DELTA := _DECAY_CLASS.DEFAULT_REST_DELTA

const PREFER_VELOCITY := _DECAY_CLASS.PREFER_VELOCITY
const PREFER_POSITION := _DECAY_CLASS.PREFER_POSITION
const VALID_PREFER := _DECAY_CLASS.VALID_PREFER
const DEFAULT_PREFER := _DECAY_CLASS.DEFAULT_PREFER

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

@export_range(
	MIN_POWER,
	MAX_POWER,
	POWER_STEP,
	"or_greater",
	"suffix:s")
var power := DEFAULT_POWER:
	set = set_power,
	get = get_power

@export_range(
	MIN_TIME_CONSTANT,
	MAX_TIME_CONSTANT,
	TIME_CONSTANT_STEP,
	"or_greater",
	"suffix:s")
var time_constant := DEFAULT_TIME_CONSTANT:
	set = set_time_constant,
	get = get_time_constant

@export_range(
	MIN_REST_DELTA,
	MAX_REST_DELTA,
	REST_DELTA_STEP,
	"or_greater",
	"exp",
	"suffix:units")
var rest_delta := DEFAULT_REST_DELTA:
	set = set_rest_delta,
	get = get_rest_delta

@export_enum(
	"Velocity",
	"Position")
var prefer := DEFAULT_PREFER:
	set = set_prefer,
	get = get_prefer

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target_class_ids() -> Array[int]:
	var target_class: Script = _DECAY_CLASS
	return [target_class.get_instance_id()]

func set_prefer(value: int) -> void:
	if _prefer != value:
		_prefer = value
		emit_changed()

func get_prefer() -> int:
	return _prefer

func set_power(value: float) -> void:
	if _power != value:
		_power = value
		emit_changed()

func get_power() -> float:
	return _power

func set_time_constant(value: float) -> void:
	if _time_constant != value:
		_time_constant = value
		emit_changed()

func get_time_constant() -> float:
	return _time_constant

func set_rest_delta(value: float) -> void:
	if _rest_delta != value:
		_rest_delta = value
		emit_changed()

func get_rest_delta() -> float:
	return _rest_delta

func apply(transition_factory: MotionTransitionFactory) -> bool:
	var target := transition_factory as _DECAY_CLASS
	if target != null:
		target.set_process(get_process())
		target.set_power(_power)
		target.set_time_constant(_time_constant)
		target.set_rest_delta(_rest_delta)
		target.set_prefer(_prefer)
		return true
	return false

#-------------------------------------------------------------------------------

const _DECAY_CLASS := preload("uid://4jaswbuq2e7w")

var _power := DEFAULT_POWER
var _time_constant := DEFAULT_TIME_CONSTANT
var _rest_delta := DEFAULT_REST_DELTA
var _prefer := DEFAULT_PREFER
