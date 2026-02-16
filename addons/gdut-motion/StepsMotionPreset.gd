<<<<<<< Updated upstream
class_name StepsMotionPreset extends MotionPreset
=======
## Steps motion configuration preset.
@tool
class_name StepsMotionPreset extends PerceivedMotionPreset
>>>>>>> Stashed changes

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
const MIN_SEGMENTS := GDUT_StepsMotionTransition.MIN_SEGMENTS
const MAX_SEGMENTS := 100
const DEFAULT_SEGMENTS := GDUT_StepsMotionTransition.DEFAULT_SEGMENTS

const DEFAULT_ROUND := GDUT_StepsMotionTransition.DEFAULT_ROUND

const MIN_DURATION := GDUT_StepsMotionTransition.MIN_DURATION
const MAX_DURATION := 10.0
const DEFAULT_DURATION := GDUT_StepsMotionTransition.DEFAULT_DURATION

=======
## Minimum value for [member segments].
const MIN_SEGMENTS := GDUT_StepsMotionTransition.MIN_SEGMENTS
## Maximum value for [member segments].
const MAX_SEGMENTS := 100
## Default value for [member segments].
const DEFAULT_SEGMENTS := GDUT_StepsMotionTransition.DEFAULT_SEGMENTS

## Default value for [member round].
const DEFAULT_ROUND := GDUT_StepsMotionTransition.DEFAULT_ROUND

>>>>>>> Stashed changes
#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
@export_range(MIN_SEGMENTS, MAX_SEGMENTS, 1.0, "or_greater")
var segments := DEFAULT_SEGMENTS

@export_enum("Ceil", "Floor")
var round := DEFAULT_ROUND

@export_range(MIN_DURATION, MAX_DURATION, 0.001, "or_greater", "suffix:s")
var duration := DEFAULT_DURATION
=======
## Number of segments.
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

## Rounding function.
@export_enum(
	"Ceil",
	"Floor")
var round := DEFAULT_ROUND:
	get:
		return _round
	set(value):
		if _round != value:
			_round = value
			emit_changed()
>>>>>>> Stashed changes

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target_script_id() -> int:
	var target_script: Script = GDUT_StepsMotionTransitionFactory
	return target_script.get_instance_id()

func apply(target: Object) -> void:
	assert(target is GDUT_StepsMotionTransitionFactory)
<<<<<<< Updated upstream
	target.set_segments(segments)
	target.set_round(round)
	target.set_duration(duration)
	target.set_process(process)
	target.set_delay(delay)
=======
	target.set_segments(_segments)
	target.set_round(_round)
	target.set_duration(_duration)
	target.set_process(process)
	target.set_delay(delay)

#-------------------------------------------------------------------------------

var _segments := DEFAULT_SEGMENTS
var _round := DEFAULT_ROUND
>>>>>>> Stashed changes
