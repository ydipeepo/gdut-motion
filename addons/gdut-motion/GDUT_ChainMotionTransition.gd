class_name GDUT_ChainMotionTransition extends GDUT_MotionTransition

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_completion() -> Task:
	return \
		_transition_before.get_completion() \
		if _transition_before != null else \
		_transition.get_completion()

func get_process() -> int:
	return \
		_transition_before.get_process() \
		if _transition_before != null else \
		_transition.get_process()

func next(
	state: GDUT_MotionState,
	timer: GDUT_MotionTimer) -> GDUT_MotionTransition:

	if _transition_before != null:
		_transition_before = _transition_before.next(state, timer)
		return self
	return _transition

func finish(state: GDUT_MotionState) -> void:
	if _transition_before != null:
		_transition_before.finish(state)
	_transition.finish(state)

func cancel() -> void:
	if _transition_before != null:
		_transition_before.cancel()
	_transition.cancel()

#-------------------------------------------------------------------------------

var _transition_before: GDUT_MotionTransition
var _transition: GDUT_MotionTransition

func _init(
	transition_before: GDUT_MotionTransition,
	transition: GDUT_MotionTransition) -> void:

	assert(transition_before != null)
	assert(transition != null)

	_transition_before = transition_before
	_transition = transition
