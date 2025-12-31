class_name StepsMotionPreset extends MotionPreset

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_SEGMENTS := GDUT_StepsMotionTransition.MIN_SEGMENTS
const MAX_SEGMENTS := 100
const DEFAULT_SEGMENTS := GDUT_StepsMotionTransition.DEFAULT_SEGMENTS

const DEFAULT_ROUND := GDUT_StepsMotionTransition.DEFAULT_ROUND

const MIN_DURATION := GDUT_StepsMotionTransition.MIN_DURATION
const MAX_DURATION := 10.0
const DEFAULT_DURATION := GDUT_StepsMotionTransition.DEFAULT_DURATION

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

@export_range(MIN_SEGMENTS, MAX_SEGMENTS, 1.0, "or_greater")
var segments := DEFAULT_SEGMENTS

@export_enum("Ceil", "Floor")
var round := DEFAULT_ROUND

@export_range(MIN_DURATION, MAX_DURATION, 0.001, "or_greater", "suffix:s")
var duration := DEFAULT_DURATION

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target_script_id() -> int:
	var target_script: Script = GDUT_StepsMotionTransitionFactory
	return target_script.get_instance_id()

func apply(target: Object) -> void:
	assert(target is GDUT_StepsMotionTransitionFactory)
	target.set_segments(segments)
	target.set_round(round)
	target.set_duration(duration)
	target.set_process(process)
	target.set_delay(delay)
