extends Node

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target() -> MotionTarget:
	return _target

func schedule_transition_factory(
	transition_factory: MotionTransitionFactory,
	transition_skip_time := 0.0) -> Task:

	assert(transition_factory != null)

	if _transition_request == null:
		_create_transition.call_deferred()
		_retention = false
		_retention_start_ticks = 0
		_transition_request = _PROCESSOR_TRANSITION_REQUEST_CLASS.new(
			transition_factory,
			transition_skip_time)
	else:
		_transition_request.renew(
			transition_factory,
			transition_skip_time)

	return _transition_request.get_completion()

#-------------------------------------------------------------------------------

const _PROCESSOR_TRANSITION_REQUEST_CLASS := preload("uid://djj3u7xerbqph")
const _PROCESSOR_STATE_CLASS := preload("uid://pb6l2tgirjkf")
const _PROCESSOR_TIMER_CLASS := preload("uid://bubsxnm1frfbl")

var _target: MotionTarget
var _retention: bool
var _retention_start_ticks: int
var _retention_duration: float
var _transition_request: _PROCESSOR_TRANSITION_REQUEST_CLASS
var _state: _PROCESSOR_STATE_CLASS
var _timer: _PROCESSOR_TIMER_CLASS
var _transition: MotionTransition

func _create_transition() -> void:
	assert(_transition_request != null)

	if _transition != null:
		_transition.abort()
		_transition = null

	if not _target.is_valid():
		_transition_request.abort()
		_transition_request = null
		_stop_then_free(true)
		return

	if _transition_request.is_aborted():
		_transition_request = null
		_stop()
		return

	_transition = _transition_request.create_transition()
	assert(_transition != null)

	if _state == null:
		_state = _PROCESSOR_STATE_CLASS.new(
			_target.get_value_type(),
			_target.get_value_size(),
			_target.get_array_size())
	_state.set_position(_target.get_value())

	if _timer == null:
		_timer = _PROCESSOR_TIMER_CLASS.new()
	_timer.reset_and_forward(_transition_request.get_transition_skip_time())

	_transition_request = null
	_transition.start(_state)

func _stop_then_free(immediate := false) -> void:
	if is_inside_tree():
		get_parent().remove_child(self)
	if immediate:
		free()
	else:
		queue_free()

func _stop() -> void:
	if _state != null:
		for k: int in _state.get_array_size() * _state.get_value_size():
			_state.set_velocity_at(k, 0.0)
	_retention = true
	_retention_start_ticks = Time.get_ticks_msec()

func _init(target: MotionTarget, retention_duration: float) -> void:
	assert(is_instance_valid(target))
	assert(0.0 <= retention_duration)

	_target = target
	_retention_duration = retention_duration

	name = "Processor_%s" % _target.get_name()

func _process_core(process: int) -> void:
	if _retention:
		assert(_transition == null)
		var retention_delta := (Time.get_ticks_msec() - _retention_start_ticks) / 1000.0
		if _retention_duration <= retention_delta:
			_stop_then_free()
		return

	if _transition == null or _transition.get_process() != process:
		return

	var completion := _transition.get_completion()
	if completion.is_canceled():
		_transition.abort()
		_transition = null
		_stop()
		return

	if not _timer.tick():
		return

	var running := _transition.apply(_state, _timer)

	if not _target.is_valid():
		_transition.abort()
		_transition = null
		_stop_then_free()
		return

	_target.set_value(_state.get_position())

	if not running:
		_transition = null
		if _transition_request == null:
			_stop()
		return

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	_process_core(MotionTransition.PROCESS_IDLE)

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	_process_core(MotionTransition.PROCESS_PHYSICS)
