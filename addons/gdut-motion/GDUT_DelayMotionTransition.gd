class_name GDUT_DelayMotionTransition extends GDUT_MotionTransition

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_completion() -> Task:
	return _transition.get_completion()

func get_process() -> int:
	return _transition.get_process()

@warning_ignore("unused_parameter")
func next(
	state: GDUT_MotionState,
	timer: GDUT_MotionTimer) -> GDUT_MotionTransition:

	_elapsed_ticks += timer.delta_ticks
	if _elapsed_ticks < _delay_ticks:
		timer.delta_ticks = 0
		return self
	timer.delta_ticks -= _elapsed_ticks - _delay_ticks
	return _transition


func finish(state: GDUT_MotionState) -> void:
	_transition.finish(state)

func cancel() -> void:
	_transition.cancel()

#-------------------------------------------------------------------------------

var _elapsed_ticks: int

var _transition: GDUT_MotionTransition
var _delay_ticks: int

func _init(transition: GDUT_MotionTransition, delay: float) -> void:
	assert(transition != null)
	assert(0.0 < delay)

	_transition = transition
	_delay_ticks = roundi(delay * 1000.0)
