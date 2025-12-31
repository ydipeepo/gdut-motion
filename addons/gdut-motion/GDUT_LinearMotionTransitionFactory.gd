class_name GDUT_LinearMotionTransitionFactory extends GDUT_PerceivedMotionTransitionFactory

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_name() -> StringName:
	return &"Linear"

func set_y_array(y_array: Array[float]) -> void:
	_y_array = y_array

func add_y(y: float) -> void:
	_y_array.append(y)

func create_transition(completion: Array) -> GDUT_MotionTransition:
	return GDUT_LinearMotionTransition.new(
		_y_array,
		get_duration(),
		get_initial_position(),
		get_final_position(),
		get_process(),
		completion)

#-------------------------------------------------------------------------------

var _y_array: Array[float]
