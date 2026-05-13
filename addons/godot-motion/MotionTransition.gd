@abstract
class_name MotionTransition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const PROCESS_IDLE := 0
const PROCESS_PHYSICS := 1
const VALID_PROCESS: Array[int] = [PROCESS_IDLE, PROCESS_PHYSICS]

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

@abstract
func get_completion() -> Task

@abstract
func get_process() -> int

@abstract
func get_duration() -> float

@abstract
func start(state: MotionState) -> void

@abstract
func apply(state: MotionState, timer: MotionTimer) -> bool

@abstract
func abort() -> void
