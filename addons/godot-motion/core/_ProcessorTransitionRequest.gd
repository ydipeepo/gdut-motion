#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_completion() -> Task:
	return _completion[0]

func get_transition_skip_time() -> float:
	return _transition_skip_time

func is_aborted() -> bool:
	return _completion[0].is_canceled()

func abort() -> void:
	_completion[2].call()

func renew(
	transition_factory: MotionTransitionFactory,
	transition_skip_time: float) -> void:

	assert(is_instance_valid(transition_factory))
	assert(0.0 <= transition_skip_time)

	_completion[2].call()
	_completion = Task.with_operators()
	_transition_factory = transition_factory
	_transition_skip_time = transition_skip_time

func create_transition() -> MotionTransition:
	return _transition_factory.create_transition(_completion)

#-------------------------------------------------------------------------------

func _init(
	transition_factory: MotionTransitionFactory,
	transition_skip_time: float) -> void:

	assert(is_instance_valid(transition_factory))
	assert(0.0 <= transition_skip_time)

	_transition_factory = transition_factory
	_transition_skip_time = transition_skip_time

var _completion := Task.with_operators()
var _transition_skip_time: float
var _transition_factory: MotionTransitionFactory
