class_name IrregularMotionPreset extends MotionPreset

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_SEGMENTS := GDUT_IrregularMotionTransition.MIN_SEGMENTS
const MAX_SEGMENTS := 100
const DEFAULT_SEGMENTS := GDUT_IrregularMotionTransition.DEFAULT_SEGMENTS

const MIN_INTENSITY := GDUT_IrregularMotionTransition.MIN_INTENSITY
const MAX_INTENSITY := GDUT_IrregularMotionTransition.MAX_INTENSITY
const DEFAULT_INTENSITY := GDUT_IrregularMotionTransition.DEFAULT_INTENSITY

const MIN_DURATION := GDUT_IrregularMotionTransition.MIN_DURATION
const MAX_DURATION := 10.0
const DEFAULT_DURATION := GDUT_IrregularMotionTransition.DEFAULT_DURATION

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

@export_range(MIN_SEGMENTS, MAX_SEGMENTS, 1.0, "or_greater")
var segments := DEFAULT_SEGMENTS

@export_range(MIN_INTENSITY, MAX_INTENSITY, 1.0)
var intensity := DEFAULT_INTENSITY

@export_range(MIN_DURATION, MAX_DURATION, 0.001, "or_greater", "suffix:s")
var duration := DEFAULT_DURATION

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target_script_id() -> int:
	var target_script: Script = GDUT_IrregularMotionTransitionFactory
	return target_script.get_instance_id()

func apply(target: Object) -> void:
	assert(target is GDUT_IrregularMotionTransitionFactory)
	target.set_segments(segments)
	target.set_intensity(intensity)
	target.set_duration(duration)
	target.set_process(process)
	target.set_delay(delay)
