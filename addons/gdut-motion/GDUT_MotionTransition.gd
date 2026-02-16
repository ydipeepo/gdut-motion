@abstract
class_name GDUT_MotionTransition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const EPSILON := 0.00001

const PROCESS_IDLE := 0
const PROCESS_PHYSICS := 1

const VALID_PROCESS: Array[int] = [
	PROCESS_IDLE,
	PROCESS_PHYSICS,
]

const DEFAULT_PROCESS := PROCESS_IDLE

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

@abstract
func get_completion() -> Task

@abstract
func get_process() -> int

@abstract
func finish(state: GDUT_MotionState) -> void

@abstract
func cancel() -> void

@abstract
func next(
	state: GDUT_MotionState,
	timer: GDUT_MotionTimer) -> GDUT_MotionTransition
