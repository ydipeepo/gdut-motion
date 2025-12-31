class_name GlideMotionPreset extends MotionPreset

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_POWER := GDUT_GlideMotionTransition.MIN_POWER
const MAX_POWER := 10.0
const DEFAULT_POWER := GDUT_GlideMotionTransition.DEFAULT_POWER

const MIN_TIME_CONSTANT := GDUT_GlideMotionTransition.MIN_TIME_CONSTANT
const MAX_TIME_CONSTANT := 10.0
const DEFAULT_TIME_CONSTANT := GDUT_GlideMotionTransition.DEFAULT_TIME_CONSTANT

const MIN_REST_DELTA := GDUT_MotionTransition.EPSILON
const MAX_REST_DELTA := 10.0
const DEFAULT_REST_DELTA := GDUT_GlideMotionTransition.DEFAULT_REST_DELTA

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

@export_range(MIN_POWER, MAX_POWER, 0.1, "or_greater")
var power := DEFAULT_POWER

@export_range(MIN_TIME_CONSTANT, MAX_TIME_CONSTANT, 0.1, "or_greater")
var time_constant := DEFAULT_TIME_CONSTANT

@export_range(MIN_REST_DELTA, MAX_REST_DELTA, 0.001, "or_greater", "exp")
var rest_delta := DEFAULT_REST_DELTA

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target_script_id() -> int:
	var target_script: Script = GDUT_GlideMotionTransitionFactory
	return target_script.get_instance_id()

func apply(target: Object) -> void:
	assert(target is GDUT_GlideMotionTransitionFactory)
	target.set_power(power)
	target.set_time_constant(time_constant)
	target.set_rest_delta(rest_delta)
	target.set_process(process)
	target.set_delay(delay)
