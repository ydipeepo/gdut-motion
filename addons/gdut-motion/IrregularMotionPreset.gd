<<<<<<< Updated upstream
class_name IrregularMotionPreset extends MotionPreset
=======
## Configuration preset for Irregular motion.
@tool
class_name IrregularMotionPreset extends PerceivedMotionPreset
>>>>>>> Stashed changes

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
const MIN_SEGMENTS := GDUT_IrregularMotionTransition.MIN_SEGMENTS
const MAX_SEGMENTS := 100
const DEFAULT_SEGMENTS := GDUT_IrregularMotionTransition.DEFAULT_SEGMENTS

const MIN_INTENSITY := GDUT_IrregularMotionTransition.MIN_INTENSITY
const MAX_INTENSITY := GDUT_IrregularMotionTransition.MAX_INTENSITY
const DEFAULT_INTENSITY := GDUT_IrregularMotionTransition.DEFAULT_INTENSITY

const MIN_DURATION := GDUT_IrregularMotionTransition.MIN_DURATION
const MAX_DURATION := 10.0
const DEFAULT_DURATION := GDUT_IrregularMotionTransition.DEFAULT_DURATION

=======
## Minimum value for [member segments].
const MIN_SEGMENTS := GDUT_IrregularMotionTransition.MIN_SEGMENTS
## Maximum value for [member segments].
const MAX_SEGMENTS := 100
## Default value for [member segments].
const DEFAULT_SEGMENTS := GDUT_IrregularMotionTransition.DEFAULT_SEGMENTS

## Minimum value for [member instensity].
const MIN_INTENSITY := GDUT_IrregularMotionTransition.MIN_INTENSITY
## Maximum value for [member instensity].
const MAX_INTENSITY := GDUT_IrregularMotionTransition.MAX_INTENSITY
## Default value for [member instensity].
const DEFAULT_INTENSITY := GDUT_IrregularMotionTransition.DEFAULT_INTENSITY

>>>>>>> Stashed changes
#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
@export_range(MIN_SEGMENTS, MAX_SEGMENTS, 1.0, "or_greater")
var segments := DEFAULT_SEGMENTS

@export_range(MIN_INTENSITY, MAX_INTENSITY, 1.0)
var intensity := DEFAULT_INTENSITY

@export_range(MIN_DURATION, MAX_DURATION, 0.001, "or_greater", "suffix:s")
var duration := DEFAULT_DURATION
=======
## Number of segments.[br]
## [br]
## Higher values result in finer irregularities.
@export_range(
	MIN_SEGMENTS,
	MAX_SEGMENTS,
	1.0,
	"or_greater")
var segments := DEFAULT_SEGMENTS:
	get:
		return _segments
	set(value):
		if _segments != value:
			_segments = value
			emit_changed()

## Intensity.[br]
## [br]
## Higher values result in greater changes.
@export_range(
	MIN_INTENSITY,
	MAX_INTENSITY,
	1.0)
var intensity := DEFAULT_INTENSITY:
	get:
		return _intensity
	set(value):
		if _intensity != value:
			_intensity = value
			emit_changed()
>>>>>>> Stashed changes

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target_script_id() -> int:
	var target_script: Script = GDUT_IrregularMotionTransitionFactory
	return target_script.get_instance_id()

func apply(target: Object) -> void:
	assert(target is GDUT_IrregularMotionTransitionFactory)
<<<<<<< Updated upstream
	target.set_segments(segments)
	target.set_intensity(intensity)
	target.set_duration(duration)
	target.set_process(process)
	target.set_delay(delay)
=======
	target.set_segments(_segments)
	target.set_intensity(_intensity)
	target.set_duration(duration)
	target.set_process(process)
	target.set_delay(delay)

#-------------------------------------------------------------------------------

var _segments := DEFAULT_SEGMENTS
var _intensity := DEFAULT_INTENSITY
>>>>>>> Stashed changes
