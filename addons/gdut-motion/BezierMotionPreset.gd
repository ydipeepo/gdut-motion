## Configuration preset for Bezier motion.
@tool
class_name BezierMotionPreset extends PerceivedMotionPreset

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

## Minimum value for [member x1].
const MIN_X1 := GDUT_BezierMotionTransition.MIN_X1
## Maximum value for [member x1].
const MAX_X1 := GDUT_BezierMotionTransition.MAX_X1
## Default value for [member x1].
const DEFAULT_X1 := GDUT_BezierMotionTransition.DEFAULT_X1

## Minimum value for [member y1].
const MIN_Y1 := GDUT_BezierMotionTransition.MIN_Y1
## Maximum value for [member y1].
const MAX_Y1 := GDUT_BezierMotionTransition.MAX_Y1
## Default value for [member y1].
const DEFAULT_Y1 := GDUT_BezierMotionTransition.DEFAULT_Y1

## Minimum value for [member x2].
const MIN_X2 := GDUT_BezierMotionTransition.MIN_X2
## Maximum value for [member x2].
const MAX_X2 := GDUT_BezierMotionTransition.MAX_X2
## Default value for [member x2].
const DEFAULT_X2 := GDUT_BezierMotionTransition.DEFAULT_X2

## Minimum value for [member y2].
const MIN_Y2 := GDUT_BezierMotionTransition.MIN_Y2
## Maximum value for [member y2].
const MAX_Y2 := GDUT_BezierMotionTransition.MAX_Y2
## Default value for [member y2].
const DEFAULT_Y2 := GDUT_BezierMotionTransition.DEFAULT_Y2

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

## First control point X component.
@export_range(
	MIN_X1,
	MAX_X1,
	0.001)
var x1 := DEFAULT_X1:
	get:
		return _x1
	set(value):
		if _x1 != value:
			_x1 = value
			emit_changed()

## First control point Y component.
@export_range(
	MIN_Y1,
	MAX_Y1,
	0.001)
var y1 := DEFAULT_Y1:
	get:
		return _y1
	set(value):
		if _y1 != value:
			_y1 = value
			emit_changed()

## Second control point X component.
@export_range(
	MIN_X2,
	MAX_X2,
	0.001)
var x2 := DEFAULT_X2:
	get:
		return _x2
	set(value):
		if _x2 != value:
			_x2 = value
			emit_changed()

## Second control point Y component.
@export_range(
	MIN_Y2,
	MAX_Y2,
	0.001)
var y2 := DEFAULT_Y2:
	get:
		return _y2
	set(value):
		if _y2 != value:
			_y2 = value
			emit_changed()

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target_script_id() -> int:
	var target_script: Script = GDUT_BezierMotionTransitionFactory
	return target_script.get_instance_id()

func apply(target: Object) -> void:
	assert(target is GDUT_BezierMotionTransitionFactory)
	target.set_x1(_x1)
	target.set_y1(_y1)
	target.set_x2(_x2)
	target.set_y2(_y2)
	target.set_duration(duration)
	target.set_process(process)
	target.set_delay(delay)

#-------------------------------------------------------------------------------

var _x1 := DEFAULT_X1
var _y1 := DEFAULT_Y1
var _x2 := DEFAULT_X2
var _y2 := DEFAULT_Y2
