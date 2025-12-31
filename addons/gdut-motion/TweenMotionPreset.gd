class_name TweenMotionPreset extends MotionPreset

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const DEFAULT_TRANS := GDUT_TweenMotionTransition.DEFAULT_TRANS

const DEFAULT_EASE := GDUT_TweenMotionTransition.DEFAULT_EASE

const MIN_DURATION := GDUT_TweenMotionTransition.MIN_DURATION
const MAX_DURATION := 10.0
const DEFAULT_DURATION := GDUT_TweenMotionTransition.DEFAULT_DURATION

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

@export_enum(
	"Linear",
	"Sinusoidal",
	"Quintic",
	"Quartic",
	"Quadratic",
	"Exponential",
	"Elastic",
	"Cubic",
	"Circular",
	"Bounce",
	"Back",
	"Spring")
var trans := DEFAULT_TRANS

@export_enum(
	"In",
	"Out",
	"In and Out",
	"Out and In")
var ease := DEFAULT_EASE

@export_range(MIN_DURATION, MAX_DURATION, 0.001, "or_greater", "suffix:s")
var duration := DEFAULT_DURATION

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target_script_id() -> int:
	var target_script: Script = GDUT_TweenMotionTransitionFactory
	return target_script.get_instance_id()

func apply(target: Object) -> void:
	assert(target is GDUT_TweenMotionTransitionFactory)
	target.set_ease(ease)
	target.set_trans(trans)
	target.set_duration(duration)
	target.set_process(process)
	target.set_delay(delay)
