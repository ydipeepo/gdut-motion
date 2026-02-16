<<<<<<< Updated upstream
class_name SpringMotionPreset extends MotionPreset
=======
## Spring motion configuration preset.
@tool
class_name SpringMotionPreset extends PhysicsMotionPreset
>>>>>>> Stashed changes

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
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

=======
## Minimum value for [member stiffness].
const MIN_STIFFNESS := GDUT_SpringMotionTransition.MIN_STIFFNESS
## Maximum value for [member stiffness].
const MAX_STIFFNESS := 1000.0
## Default value for [member stiffness].
const DEFAULT_STIFFNESS := GDUT_SpringMotionTransition.DEFAULT_STIFFNESS

## Minimum value for [member damping].
const MIN_DAMPING := GDUT_SpringMotionTransition.MIN_DAMPING
## Maximum value for [member damping].
const MAX_DAMPING := 1000.0
## Default value for [member damping].
const DEFAULT_DAMPING := GDUT_SpringMotionTransition.DEFAULT_DAMPING

## Minimum value for [member mass].
const MIN_MASS := GDUT_SpringMotionTransition.MIN_MASS
## Maximum value for [member mass].
const MAX_MASS := 1000.0
## Default value for [member mass].
const DEFAULT_MASS := GDUT_SpringMotionTransition.DEFAULT_MASS

## Minimum value for [member rest_delta].
const MIN_REST_DELTA := GDUT_SpringMotionTransition.MIN_REST_DELTA
## Maximum value for [member rest_delta].
const MAX_REST_DELTA := 10.0
## Default value for [member rest_delta].
const DEFAULT_REST_DELTA := GDUT_SpringMotionTransition.DEFAULT_REST_DELTA

## Minimum value for [member rest_speed].
const MIN_REST_SPEED := GDUT_SpringMotionTransition.MIN_REST_SPEED
## Maximum value for [member rest_speed].
const MAX_REST_SPEED := 10.0
## Default value for [member rest_speed].
const DEFAULT_REST_SPEED := GDUT_SpringMotionTransition.DEFAULT_REST_SPEED

## Default value for [member limit_overdamping].
const DEFAULT_LIMIT_OVERDAMPING := GDUT_SpringMotionTransition.DEFAULT_LIMIT_OVERDAMPING

## Default value for [member limit_overshooting].
>>>>>>> Stashed changes
const DEFAULT_LIMIT_OVERSHOOTING := GDUT_SpringMotionTransition.DEFAULT_LIMIT_OVERSHOOTING

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
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
=======
## Stiffness (spring constant).[br]
## [br]
## Higher values result in stronger restoring force and faster oscillation.
@export_range(
	MIN_STIFFNESS,
	MAX_STIFFNESS,
	0.1,
	"or_greater")
var stiffness := DEFAULT_STIFFNESS:
	get:
		return _stiffness
	set(value):
		if _stiffness != value:
			_stiffness = value
			emit_changed()

## Damping coefficient.[br]
## [br]
## Higher values cause oscillations to settle more quickly.
@export_range(
	MIN_DAMPING,
	MAX_DAMPING,
	0.1,
	"or_greater")
var damping := DEFAULT_DAMPING:
	get:
		return _damping
	set(value):
		if _damping != value:
			_damping = value
			emit_changed()

## Mass.[br]
## [br]
## Higher values result in greater inertia and slower response.
@export_range(
	MIN_MASS,
	MAX_MASS,
	0.1,
	"or_greater")
var mass := DEFAULT_MASS:
	get:
		return _mass
	set(value):
		if _mass != value:
			_mass = value
			emit_changed()

## Maximum displacement to be considered at rest.
@export_range(
	MIN_REST_DELTA,
	MAX_REST_DELTA,
	0.001,
	"or_greater",
	"exp")
var rest_delta := DEFAULT_REST_DELTA:
	get:
		return _rest_delta
	set(value):
		if _rest_delta != value:
			_rest_delta = value
			emit_changed()

## Maximum speed to be considered at rest.
@export_range(
	MIN_REST_SPEED,
	MAX_REST_SPEED,
	0.001,
	"or_greater",
	"exp",
	"units/s")
var rest_speed := DEFAULT_REST_SPEED:
	get:
		return _rest_speed
	set(value):
		if _rest_speed != value:
			_rest_speed = value
			emit_changed()

## Whether to limit overdamping to critical damping.
@export
var limit_overdamping := DEFAULT_LIMIT_OVERDAMPING:
	get:
		return _limit_overdamping
	set(value):
		if _limit_overdamping != value:
			_limit_overdamping = value
			emit_changed()

## Whether to limit (prohibit) overshoot.
@export
var limit_overshooting := DEFAULT_LIMIT_OVERSHOOTING:
	get:
		return _limit_overshooting
	set(value):
		if _limit_overshooting != value:
			_limit_overshooting = value
			emit_changed()
>>>>>>> Stashed changes

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target_script_id() -> int:
	var target_script: Script = GDUT_SpringMotionTransitionFactory
	return target_script.get_instance_id()

func apply(target: Object) -> void:
	assert(target is GDUT_SpringMotionTransitionFactory)
<<<<<<< Updated upstream
	target.set_stiffness(stiffness)
	target.set_damping(damping)
	target.set_mass(mass)
	target.set_rest_delta(rest_delta)
	target.set_rest_speed(rest_speed)
	target.set_limit_overdamping(limit_overdamping)
	target.set_limit_overshooting(limit_overshooting)
	target.set_process(process)
	target.set_delay(delay)
=======
	target.set_stiffness(_stiffness)
	target.set_damping(_damping)
	target.set_mass(_mass)
	target.set_rest_delta(_rest_delta)
	target.set_rest_speed(_rest_speed)
	target.set_limit_overdamping(_limit_overdamping)
	target.set_limit_overshooting(_limit_overshooting)
	target.set_process(process)
	target.set_delay(delay)

#-------------------------------------------------------------------------------

var _stiffness := DEFAULT_STIFFNESS
var _damping := DEFAULT_DAMPING
var _mass := DEFAULT_MASS
var _rest_delta := DEFAULT_REST_DELTA
var _rest_speed := DEFAULT_REST_SPEED
var _limit_overdamping := DEFAULT_LIMIT_OVERDAMPING
var _limit_overshooting := DEFAULT_LIMIT_OVERSHOOTING
>>>>>>> Stashed changes
