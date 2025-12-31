class_name SpringMotionPreset extends MotionPreset

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_STIFFNESS := GDUT_SpringMotionTransition.MIN_STIFFNESS
const MAX_STIFFNESS := 1000.0
const DEFAULT_STIFFNESS := GDUT_SpringMotionTransition.DEFAULT_STIFFNESS

const MIN_DAMPING := GDUT_SpringMotionTransition.MIN_DAMPING
const MAX_DAMPING := 1000.0
const DEFAULT_DAMPING := GDUT_SpringMotionTransition.DEFAULT_DAMPING

const MIN_MASS := GDUT_SpringMotionTransition.MIN_MASS
const MAX_MASS := 1000.0
const DEFAULT_MASS := GDUT_SpringMotionTransition.DEFAULT_MASS

const MIN_REST_DELTA := GDUT_SpringMotionTransition.MIN_REST_DELTA
const MAX_REST_DELTA := 10.0
const DEFAULT_REST_DELTA := GDUT_SpringMotionTransition.DEFAULT_REST_DELTA

const MIN_REST_SPEED := GDUT_SpringMotionTransition.MIN_REST_SPEED
const MAX_REST_SPEED := 10.0
const DEFAULT_REST_SPEED := GDUT_SpringMotionTransition.DEFAULT_REST_SPEED

const DEFAULT_LIMIT_OVERDAMPING := GDUT_SpringMotionTransition.DEFAULT_LIMIT_OVERDAMPING

const DEFAULT_LIMIT_OVERSHOOTING := GDUT_SpringMotionTransition.DEFAULT_LIMIT_OVERSHOOTING

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

@export_range(MIN_STIFFNESS, MAX_STIFFNESS, 0.1, "or_greater")
var stiffness := DEFAULT_STIFFNESS

@export_range(MIN_DAMPING, MAX_DAMPING, 0.1, "or_greater")
var damping := DEFAULT_DAMPING

@export_range(MIN_MASS, MAX_MASS, 0.1, "or_greater")
var mass := DEFAULT_MASS

@export_range(MIN_REST_DELTA, MAX_REST_DELTA, 0.001, "or_greater", "exp")
var rest_delta := DEFAULT_REST_DELTA

@export_range(MIN_REST_SPEED, MAX_REST_SPEED, 0.001, "or_greater", "exp", "units/s")
var rest_speed := DEFAULT_REST_SPEED

@export
var limit_overdamping := DEFAULT_LIMIT_OVERDAMPING

@export
var limit_overshooting := DEFAULT_LIMIT_OVERSHOOTING

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target_script_id() -> int:
	var target_script: Script = GDUT_SpringMotionTransitionFactory
	return target_script.get_instance_id()

func apply(target: Object) -> void:
	assert(target is GDUT_SpringMotionTransitionFactory)
	target.set_stiffness(stiffness)
	target.set_damping(damping)
	target.set_mass(mass)
	target.set_rest_delta(rest_delta)
	target.set_rest_speed(rest_speed)
	target.set_limit_overdamping(limit_overdamping)
	target.set_limit_overshooting(limit_overshooting)
	target.set_process(process)
	target.set_delay(delay)
