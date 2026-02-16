<<<<<<< Updated upstream
=======
## Motion configuration preset.
##
## These configuration presets are used through [MotionPresetBank].
>>>>>>> Stashed changes
@abstract
class_name MotionPreset extends Resource

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
const DEFAULT_PROCESS: int = GDUT_MotionTransition.DEFAULT_PROCESS

const MIN_DELAY := 0.0
const MAX_DELAY := 30.0
=======
## Default value for [member name].
const DEFAULT_NAME := &""

## Minimum value for [member probability].
const MIN_PROBABILITY := 0.0
## Maximum value for [member probability].
const MAX_PROBABILITY := 100.0
## Default value for [member probability].
const DEFAULT_PROBABILITY := 1.0

## Default value for [member process].
const DEFAULT_PROCESS: int = GDUT_MotionTransition.DEFAULT_PROCESS

## Minimum value for [member delay].
const MIN_DELAY := 0.0
## Maximum value for [member delay].
const MAX_DELAY := 30.0
## Default value for [member delay].
>>>>>>> Stashed changes
const DEFAULT_DELAY := 0.0

#-------------------------------------------------------------------------------
#	SIGNALS
#-------------------------------------------------------------------------------

signal name_changing
signal name_changed
<<<<<<< Updated upstream
=======
signal probability_changed
>>>>>>> Stashed changes

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
@export
var name: StringName:
=======
## Preset name.[br]
## [br]
## Loaded by specifying this name in [member MotionExpression.preset].
@export
var name := DEFAULT_NAME:
>>>>>>> Stashed changes
	get:
		return _name
	set(value):
		if _name != value:
			name_changing.emit()
			_name = value
			name_changed.emit()

<<<<<<< Updated upstream
@export_enum("Idle", "Physics")
var process := DEFAULT_PROCESS

@export_range(MIN_DELAY, MAX_DELAY, 0.001, "or_greater", "suffix:s")
=======
## The likelihood of being selected from multiple preset configurations.[br]
## [br]
## If there are preset configurations with the same name and target,
## the selection probability is determined by dividing [member probability]
## by the sum of [member probability] for all preset configurations with that same name and target.
@export_range(
	MIN_PROBABILITY,
	MAX_PROBABILITY,
	0.1,
	"or_greater")
var probability := DEFAULT_PROBABILITY:
	get:
		return _probability
	set(value):
		if _probability != value:
			_probability = value
			probability_changed.emit()

## Update timing.
@export_enum(
	"Idle",
	"Physics")
var process := DEFAULT_PROCESS

## Delay time before the motion starts.
@export_range(
	MIN_DELAY,
	MAX_DELAY,
	0.001,
	"or_greater",
	"suffix:s")
>>>>>>> Stashed changes
var delay := DEFAULT_DELAY

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

@abstract
func get_target_script_id() -> int

@abstract
func apply(target: Object) -> void

#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
var _name: StringName
=======
var _name := DEFAULT_NAME
var _probability := DEFAULT_PROBABILITY
>>>>>>> Stashed changes
