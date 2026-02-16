class_name GDUT_MotionProcessor extends Node

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
func get_proxy() -> MotionProxy:
	return _proxy
=======
func get_target() -> GDUT_MotionTarget:
	return _target
>>>>>>> Stashed changes

func schedule_transition(
	transition_factory: GDUT_MotionTransitionFactory,
	continuation: bool) -> Task:

	assert(transition_factory != null)

	if not _scheduled:
		_create_transition.call_deferred()
		_retention = false
		_retention_start_ticks = 0
		_scheduled = true
	elif not continuation:
		for completion: Array in _scheduled_completions:
			completion[2].call()
		_scheduled_transition_factories.clear()
		_scheduled_completions.clear()

	var completion := Task.with_operators()
	_scheduled_transition_factories.push_back(transition_factory)
	_scheduled_completions.push_back(completion)
	return completion[0]

<<<<<<< Updated upstream
func equals(proxy: MotionProxy) -> bool:
	return \
		_proxy.is_valid() and \
		_proxy.equals(proxy)
=======
func equals(target: GDUT_MotionTarget) -> bool:
	return \
		_target.is_valid() and \
		_target.equals(target)
>>>>>>> Stashed changes

#-------------------------------------------------------------------------------

var _retention: bool
var _retention_start_ticks: int
var _retention_duration: float
var _scheduled: bool
var _scheduled_transition_factories: Array[GDUT_MotionTransitionFactory]
var _scheduled_completions: Array[Array]
<<<<<<< Updated upstream
var _proxy: MotionProxy
=======
var _target: GDUT_MotionTarget
>>>>>>> Stashed changes
var _state: GDUT_MotionState
var _timer: GDUT_MotionTimer
var _timer_process_changed: bool
var _transition: GDUT_MotionTransition

func _create_transition() -> void:
	if _transition != null:
		_transition.cancel()
		_transition = null

<<<<<<< Updated upstream
	if not _proxy.is_valid():
=======
	if not _target.is_valid():
>>>>>>> Stashed changes
		for completion: Array in _scheduled_completions:
			completion[2].call()
		_scheduled_transition_factories.clear()
		_scheduled_completions.clear()

		if is_inside_tree():
			get_parent().remove_child(self)
		free()
		return

	var truncated := false
	for index: int in _scheduled_transition_factories.size():
		var completion := _scheduled_completions[index]
		if truncated:
			completion[2].call()
			continue
		if completion[0].is_canceled:
			truncated = true
			continue
		var transition_factory := _scheduled_transition_factories[index]
		_transition = transition_factory.create(completion, _transition)
	_scheduled = false
	_scheduled_transition_factories.clear()
	_scheduled_completions.clear()
	if _transition == null:
		return

	if _state == null:
<<<<<<< Updated upstream
		_state = GDUT_MotionState.create(_proxy)
		_state.set_position(_proxy.get_value())
=======
		_state = GDUT_MotionState.new(_target)
		_state.set_position(_target.get_value())
>>>>>>> Stashed changes

	_timer.reset()

func _stop_then_free() -> void:
	if is_inside_tree():
		get_parent().remove_child(self)
	queue_free()

func _stop() -> void:
	for k: int in _state.get_array_size() * _state.get_value_size():
		_state.set_velocity_at(k, 0.0)
	_retention = true
	_retention_start_ticks = GDUT_Motion.get_ticks()

<<<<<<< Updated upstream
func _init(proxy: MotionProxy, retention_duration: float) -> void:
	assert(proxy != null)
=======
func _init(target: GDUT_MotionTarget, retention_duration: float) -> void:
	assert(target != null)
>>>>>>> Stashed changes
	assert(0.0 <= retention_duration)

	_retention_duration = retention_duration
	_timer = GDUT_MotionTimer.new()
<<<<<<< Updated upstream
	_proxy = proxy

	name = "Processor_%s" % _proxy.get_name()
=======
	_target = target

	name = "Processor_%s" % _target.get_name()
>>>>>>> Stashed changes

func _process_core(process: int) -> void:
	if _retention:
		assert(_transition == null)
		var retention_delta := (GDUT_Motion.get_ticks() - _retention_start_ticks) / 1000.0
		if _retention_duration <= retention_delta:
			_stop_then_free()
		return

	if \
		_transition != null and \
		_transition.get_process() == process:

		var completion := _transition.get_completion()
		if completion.is_canceled:
			_transition.cancel()
			_transition = null
			_stop()
			return

		if not _timer_process_changed:
			_timer.tick()
		_timer_process_changed = false

		while _timer.is_delta_ticks_left():
			_transition = _transition.next(_state, _timer)

<<<<<<< Updated upstream
			if not _proxy.is_valid():
=======
			if not _target.is_valid():
>>>>>>> Stashed changes
				assert(not _scheduled)
				if _transition != null:
					_transition.cancel()
					_transition = null
				_stop_then_free()
				return

<<<<<<< Updated upstream
			_proxy.set_value(_state.get_position())
=======
			_target.set_value(_state.get_position())
>>>>>>> Stashed changes

			if _transition == null:
				if not _scheduled:
					_stop()
				return

			if _transition.get_process() != process:
				_timer_process_changed = true
				return

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	_process_core(GDUT_MotionTransition.PROCESS_IDLE)

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	_process_core(GDUT_MotionTransition.PROCESS_PHYSICS)
