<<<<<<< Updated upstream
class_name GlideMotionPreset extends MotionPreset
=======
## Configuration preset for Glide motion.
@tool
class_name GlideMotionPreset extends PhysicsMotionPreset
>>>>>>> Stashed changes

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
const MIN_POWER := GDUT_GlideMotionTransition.MIN_POWER
const MAX_POWER := 10.0
const DEFAULT_POWER := GDUT_GlideMotionTransition.DEFAULT_POWER

const MIN_TIME_CONSTANT := GDUT_GlideMotionTransition.MIN_TIME_CONSTANT
const MAX_TIME_CONSTANT := 10.0
const DEFAULT_TIME_CONSTANT := GDUT_GlideMotionTransition.DEFAULT_TIME_CONSTANT

const MIN_REST_DELTA := GDUT_MotionTransition.EPSILON
const MAX_REST_DELTA := 10.0
=======
## Minimum value for [member power].
const MIN_POWER := GDUT_GlideMotionTransition.MIN_POWER
## Maximum value for [member power].
const MAX_POWER := 10.0
## Default value for [member power].
const DEFAULT_POWER := GDUT_GlideMotionTransition.DEFAULT_POWER

## Minimum value for [member time_constant].
const MIN_TIME_CONSTANT := GDUT_GlideMotionTransition.MIN_TIME_CONSTANT
## Maximum value for [member time_constant].
const MAX_TIME_CONSTANT := 10.0
## Default value for [member time_constant].
const DEFAULT_TIME_CONSTANT := GDUT_GlideMotionTransition.DEFAULT_TIME_CONSTANT

## Minimum value for [member rest_delta].
const MIN_REST_DELTA := GDUT_MotionTransition.EPSILON
## Maximum value for [member rest_delta].
const MAX_REST_DELTA := 10.0
## Default value for [member rest_delta].
>>>>>>> Stashed changes
const DEFAULT_REST_DELTA := GDUT_GlideMotionTransition.DEFAULT_REST_DELTA

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
@export_range(MIN_POWER, MAX_POWER, 0.1, "or_greater")
var power := DEFAULT_POWER

@export_range(MIN_TIME_CONSTANT, MAX_TIME_CONSTANT, 0.1, "or_greater")
var time_constant := DEFAULT_TIME_CONSTANT

@export_range(MIN_REST_DELTA, MAX_REST_DELTA, 0.001, "or_greater", "exp")
var rest_delta := DEFAULT_REST_DELTA
=======
## Scale factor for estimating the final position from the initial velocity.[br]
## [br]
## [code]V0 * [/code][member power] determines the final displacement.
@export_range(
	MIN_POWER,
	MAX_POWER,
	0.1,
	"or_greater")
var power := DEFAULT_POWER:
	get:
		return _power
	set(value):
		if _power != value:
			_power = value
			emit_changed()

## Time constant.[br]
## [br]
## Smaller values result in faster convergence.
@export_range(
	MIN_TIME_CONSTANT,
	MAX_TIME_CONSTANT,
	0.1,
	"or_greater")
var time_constant := DEFAULT_TIME_CONSTANT:
	get:
		return _time_constant
	set(value):
		if _time_constant != value:
			_time_constant = value
			emit_changed()

## Rest displacement.
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
>>>>>>> Stashed changes

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target_script_id() -> int:
	var target_script: Script = GDUT_GlideMotionTransitionFactory
	return target_script.get_instance_id()

func apply(target: Object) -> void:
	assert(target is GDUT_GlideMotionTransitionFactory)
<<<<<<< Updated upstream
	target.set_power(power)
	target.set_time_constant(time_constant)
	target.set_rest_delta(rest_delta)
	target.set_process(process)
	target.set_delay(delay)
=======
	target.set_power(_power)
	target.set_time_constant(_time_constant)
	target.set_rest_delta(_rest_delta)
	target.set_process(process)
	target.set_delay(delay)

#-------------------------------------------------------------------------------

var _power := DEFAULT_POWER
var _time_constant := DEFAULT_TIME_CONSTANT
var _rest_delta := DEFAULT_REST_DELTA
>>>>>>> Stashed changes
