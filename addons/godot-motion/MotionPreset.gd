## Abstract base class representing a [MotionPreset].
##
## A [MotionPreset] defines reusable configuration rules that can be
## applied to a [MotionTransitionFactory] through a [MotionExpression].
@abstract
class_name MotionPreset extends Resource

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const DEFAULT_NAME := &""

const MIN_PROBABILITY := 0.0
const MAX_PROBABILITY := 100.0
const PROBABILITY_STEP := 1e-1
const DEFAULT_PROBABILITY := 1.0

const DEFAULT_PROCESS := MotionTransitionFactory.DEFAULT_PROCESS

#-------------------------------------------------------------------------------
#	SIGNALS
#-------------------------------------------------------------------------------

signal criteria_invalidating
signal criteria_invalidated

signal probability_changed

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

@export
var preset_name := DEFAULT_NAME:
	set = set_preset_name,
	get = get_preset_name

@export_range(
	MIN_PROBABILITY,
	MAX_PROBABILITY,
	PROBABILITY_STEP,
	"or_greater")
var probability := DEFAULT_PROBABILITY:
	set = set_probability,
	get = get_probability

@export_enum(
	"Idle",
	"Physics")
var process := DEFAULT_PROCESS:
	set = set_process,
	get = get_process

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

@abstract
func get_target_class_ids() -> Array[int]

func set_preset_name(value: StringName) -> void:
	if _name != value:
		criteria_invalidating.emit()
		_name = value
		criteria_invalidated.emit()

func get_preset_name() -> StringName:
	return _name

func set_probability(value: float) -> void:
	if _probability != value:
		_probability = value
		probability_changed.emit()

func get_probability() -> float:
	return _probability

func set_process(value: int) -> void:
	_process = value

func get_process() -> int:
	return _process

func is_valid() -> bool:
	return true

@abstract
func apply(target: MotionTransitionFactory) -> bool

#-------------------------------------------------------------------------------

var _name := DEFAULT_NAME
var _probability := DEFAULT_PROBABILITY
var _process := DEFAULT_PROCESS
