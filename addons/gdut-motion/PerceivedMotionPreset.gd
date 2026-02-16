## Perceived motion configuration preset.
##
## This class categorizes configuration presets for perceived motion.
@abstract
class_name PerceivedMotionPreset extends MotionPreset

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

## Minimum value for [member duration].
const MIN_DURATION := GDUT_PerceivedMotionTransition.MIN_DURATION
## Maximum value for [member duration].
const MAX_DURATION := 10.0
## Default value for [member duration].
const DEFAULT_DURATION := GDUT_PerceivedMotionTransition.DEFAULT_DURATION

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

## Duration.
@export_range(
	MIN_DURATION,
	MAX_DURATION,
	0.001,
	"or_greater",
	"suffix:s")
var duration := DEFAULT_DURATION:
	get:
		return _duration
	set(value):
		if _duration != value:
			_duration = value
			emit_changed()

#-------------------------------------------------------------------------------

var _duration := DEFAULT_DURATION
