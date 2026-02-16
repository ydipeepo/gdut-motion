## Tween motion configuration preset.
@tool
class_name TweenMotionPreset extends PerceivedMotionPreset

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

## Default value for [member trans].
const DEFAULT_TRANS := GDUT_TweenMotionTransition.DEFAULT_TRANS

## Default value for [member ease].
const DEFAULT_EASE := GDUT_TweenMotionTransition.DEFAULT_EASE

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

## Interpolation method.
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
var trans := DEFAULT_TRANS:
	get:
		return _trans
	set(value):
		if _trans != value:
			_trans = value
			emit_changed()

## Easing direction.
@export_enum(
	"In",
	"Out",
	"In and Out",
	"Out and In")
var ease := DEFAULT_EASE:
	get:
		return _ease
	set(value):
		if _ease != value:
			_ease = value
			emit_changed()

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target_script_id() -> int:
	var target_script: Script = GDUT_TweenMotionTransitionFactory
	return target_script.get_instance_id()

func apply(target: Object) -> void:
	assert(target is GDUT_TweenMotionTransitionFactory)
	target.set_ease(_ease)
	target.set_trans(_trans)
	target.set_duration(duration)
	target.set_process(process)
	target.set_delay(delay)

#-------------------------------------------------------------------------------

var _trans := DEFAULT_TRANS
var _ease := DEFAULT_EASE
