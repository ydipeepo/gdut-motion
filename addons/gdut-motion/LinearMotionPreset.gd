<<<<<<< Updated upstream
class_name LinearMotionPreset extends MotionPreset

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_DURATION := GDUT_BezierMotionTransition.MIN_DURATION
const MAX_DURATION := 10.0
const DEFAULT_DURATION := GDUT_TweenMotionTransition.DEFAULT_DURATION
=======
## Configuration preset for Linear motion.
@tool
class_name LinearMotionPreset extends PerceivedMotionPreset
>>>>>>> Stashed changes

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
@export
var y_array: Array[float]

@export_range(MIN_DURATION, MAX_DURATION, 0.001, "or_greater", "suffix:s")
var duration := DEFAULT_DURATION
=======
## Array of segment vertices.[br]
## [br]
## [code]0.0[/code] and [code]1.0[/code] will be added to the beginning and end of this array.
@export
var y_array: Array[float]:
	get:
		return _y_array
	set(value):
		_y_array = value
		emit_changed()
>>>>>>> Stashed changes

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target_script_id() -> int:
	var target_script: Script = GDUT_LinearMotionTransitionFactory
	return target_script.get_instance_id()

func apply(target: Object) -> void:
	assert(target is GDUT_LinearMotionTransitionFactory)
<<<<<<< Updated upstream
	target.set_y_array(y_array)
	target.set_duration(duration)
	target.set_process(process)
	target.set_delay(delay)
=======
	target.set_y_array(_y_array)
	target.set_duration(_duration)
	target.set_process(process)
	target.set_delay(delay)

#-------------------------------------------------------------------------------

var _y_array: Array[float]
>>>>>>> Stashed changes
