<<<<<<< Updated upstream
class_name TweenMotionPreset extends MotionPreset
=======
## Tween motion configuration preset.
@tool
class_name TweenMotionPreset extends PerceivedMotionPreset
>>>>>>> Stashed changes

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
const DEFAULT_TRANS := GDUT_TweenMotionTransition.DEFAULT_TRANS

const DEFAULT_EASE := GDUT_TweenMotionTransition.DEFAULT_EASE

const MIN_DURATION := GDUT_TweenMotionTransition.MIN_DURATION
const MAX_DURATION := 10.0
const DEFAULT_DURATION := GDUT_TweenMotionTransition.DEFAULT_DURATION

=======
## Default value for [member trans].
const DEFAULT_TRANS := GDUT_TweenMotionTransition.DEFAULT_TRANS

## Default value for [member ease].
const DEFAULT_EASE := GDUT_TweenMotionTransition.DEFAULT_EASE

>>>>>>> Stashed changes
#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
=======
## Interpolation method.
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
var trans := DEFAULT_TRANS

=======
var trans := DEFAULT_TRANS:
	get:
		return _trans
	set(value):
		if _trans != value:
			_trans = value
			emit_changed()

## Easing direction.
>>>>>>> Stashed changes
@export_enum(
	"In",
	"Out",
	"In and Out",
	"Out and In")
<<<<<<< Updated upstream
var ease := DEFAULT_EASE

@export_range(MIN_DURATION, MAX_DURATION, 0.001, "or_greater", "suffix:s")
var duration := DEFAULT_DURATION
=======
var ease := DEFAULT_EASE:
	get:
		return _ease
	set(value):
		if _ease != value:
			_ease = value
			emit_changed()
>>>>>>> Stashed changes

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target_script_id() -> int:
	var target_script: Script = GDUT_TweenMotionTransitionFactory
	return target_script.get_instance_id()

func apply(target: Object) -> void:
	assert(target is GDUT_TweenMotionTransitionFactory)
<<<<<<< Updated upstream
	target.set_ease(ease)
	target.set_trans(trans)
	target.set_duration(duration)
	target.set_process(process)
	target.set_delay(delay)
=======
	target.set_ease(_ease)
	target.set_trans(_trans)
	target.set_duration(duration)
	target.set_process(process)
	target.set_delay(delay)

#-------------------------------------------------------------------------------

var _trans := DEFAULT_TRANS
var _ease := DEFAULT_EASE
>>>>>>> Stashed changes
