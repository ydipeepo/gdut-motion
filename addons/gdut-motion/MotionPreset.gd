@abstract
class_name MotionPreset extends Resource

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const DEFAULT_PROCESS: int = GDUT_MotionTransition.DEFAULT_PROCESS

const MIN_DELAY := 0.0
const MAX_DELAY := 30.0
const DEFAULT_DELAY := 0.0

#-------------------------------------------------------------------------------
#	SIGNALS
#-------------------------------------------------------------------------------

signal name_changing
signal name_changed

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

@export
var name: StringName:
	get:
		return _name
	set(value):
		if _name != value:
			name_changing.emit()
			_name = value
			name_changed.emit()

@export_enum("Idle", "Physics")
var process := DEFAULT_PROCESS

@export_range(MIN_DELAY, MAX_DELAY, 0.001, "or_greater", "suffix:s")
var delay := DEFAULT_DELAY

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

@abstract
func get_target_script_id() -> int

@abstract
func apply(target: Object) -> void

#-------------------------------------------------------------------------------

var _name: StringName
