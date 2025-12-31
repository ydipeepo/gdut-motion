class_name BezierMotionPreset extends MotionPreset

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_X1 := GDUT_BezierMotionTransition.MIN_X1
const MAX_X1 := GDUT_BezierMotionTransition.MAX_X1
const DEFAULT_X1 := GDUT_BezierMotionTransition.DEFAULT_X1

const MIN_Y1 := GDUT_BezierMotionTransition.MIN_Y1
const MAX_Y1 := GDUT_BezierMotionTransition.MAX_Y1
const DEFAULT_Y1 := GDUT_BezierMotionTransition.DEFAULT_Y1

const MIN_X2 := GDUT_BezierMotionTransition.MIN_X2
const MAX_X2 := GDUT_BezierMotionTransition.MAX_X2
const DEFAULT_X2 := GDUT_BezierMotionTransition.DEFAULT_X2

const MIN_Y2 := GDUT_BezierMotionTransition.MIN_Y2
const MAX_Y2 := GDUT_BezierMotionTransition.MAX_Y2
const DEFAULT_Y2 := GDUT_BezierMotionTransition.DEFAULT_Y2

const MIN_DURATION := GDUT_BezierMotionTransition.MIN_DURATION
const MAX_DURATION := 10.0
const DEFAULT_DURATION := GDUT_TweenMotionTransition.DEFAULT_DURATION

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

@export_range(MIN_X1, MAX_X1, 0.001)
var x1 := DEFAULT_X1

@export_range(MIN_Y1, MAX_Y1, 0.001)
var y1 := DEFAULT_Y1

@export_range(MIN_X2, MAX_X2, 0.001)
var x2 := DEFAULT_X2

@export_range(MIN_Y2, MAX_Y2, 0.001)
var y2 := DEFAULT_Y2

@export_range(MIN_DURATION, MAX_DURATION, 0.001, "or_greater", "suffix:s")
var duration := DEFAULT_DURATION

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target_script_id() -> int:
	var target_script: Script = GDUT_BezierMotionTransitionFactory
	return target_script.get_instance_id()

func apply(target: Object) -> void:
	assert(target is GDUT_BezierMotionTransitionFactory)
	target.set_x1(x1)
	target.set_y1(y1)
	target.set_x2(x2)
	target.set_y2(y2)
	target.set_duration(duration)
	target.set_process(process)
	target.set_delay(delay)
