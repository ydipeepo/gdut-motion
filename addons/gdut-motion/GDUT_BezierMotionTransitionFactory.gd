class_name GDUT_BezierMotionTransitionFactory extends GDUT_PerceivedMotionTransitionFactory

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_name() -> StringName:
	return &"Bezier"

func set_x1(value: float) -> void:
	if value < GDUT_BezierMotionTransition.MIN_X1:
<<<<<<< Updated upstream
		GDUT_Motion.print_warning(
			&"BAD_X1",
			get_name(),
			value)
		value = GDUT_BezierMotionTransition.MIN_X1
	elif GDUT_BezierMotionTransition.MAX_X1 < value:
		GDUT_Motion.print_warning(
			&"BAD_X1",
			get_name(),
			value)
=======
		GDUT_Motion.print_warning(&"BAD_X1", get_name(), value)
		value = GDUT_BezierMotionTransition.MIN_X1
	elif GDUT_BezierMotionTransition.MAX_X1 < value:
		GDUT_Motion.print_warning(&"BAD_X1", get_name(), value)
>>>>>>> Stashed changes
		value = GDUT_BezierMotionTransition.MAX_X1
	_x1 = value

func set_y1(value: float) -> void:
	if value < GDUT_BezierMotionTransition.MIN_Y1:
<<<<<<< Updated upstream
		GDUT_Motion.print_warning(
			&"BAD_Y1",
			get_name(),
			value)
		value = GDUT_BezierMotionTransition.MIN_Y1
	elif GDUT_BezierMotionTransition.MAX_Y1 < value:
		GDUT_Motion.print_warning(
			&"BAD_Y1",
			get_name(),
			value)
=======
		GDUT_Motion.print_warning(&"BAD_Y1", get_name(), value)
		value = GDUT_BezierMotionTransition.MIN_Y1
	elif GDUT_BezierMotionTransition.MAX_Y1 < value:
		GDUT_Motion.print_warning(&"BAD_Y1", get_name(), value)
>>>>>>> Stashed changes
		value = GDUT_BezierMotionTransition.MAX_Y1
	_y1 = value

func set_x2(value: float) -> void:
	if value < GDUT_BezierMotionTransition.MIN_X2:
<<<<<<< Updated upstream
		GDUT_Motion.print_warning(
			&"BAD_X2",
			get_name(),
			value)
		value = GDUT_BezierMotionTransition.MIN_X2
	elif GDUT_BezierMotionTransition.MAX_X2 < value:
		GDUT_Motion.print_warning(
			&"BAD_X2",
			get_name(),
			value)
=======
		GDUT_Motion.print_warning(&"BAD_X2", get_name(), value)
		value = GDUT_BezierMotionTransition.MIN_X2
	elif GDUT_BezierMotionTransition.MAX_X2 < value:
		GDUT_Motion.print_warning(&"BAD_X2", get_name(), value)
>>>>>>> Stashed changes
		value = GDUT_BezierMotionTransition.MAX_X2
	_x2 = value

func set_y2(value: float) -> void:
	if value < GDUT_BezierMotionTransition.MIN_Y2:
<<<<<<< Updated upstream
		GDUT_Motion.print_warning(
			&"BAD_Y2",
			get_name(),
			value)
		value = GDUT_BezierMotionTransition.MIN_Y2
	elif GDUT_BezierMotionTransition.MAX_Y2 < value:
		GDUT_Motion.print_warning(
			&"BAD_Y2",
			get_name(),
			value)
=======
		GDUT_Motion.print_warning(&"BAD_Y2", get_name(), value)
		value = GDUT_BezierMotionTransition.MIN_Y2
	elif GDUT_BezierMotionTransition.MAX_Y2 < value:
		GDUT_Motion.print_warning(&"BAD_Y2", get_name(), value)
>>>>>>> Stashed changes
		value = GDUT_BezierMotionTransition.MAX_Y2
	_y2 = value

func create_transition(completion: Array) -> GDUT_MotionTransition:
	return GDUT_BezierMotionTransition.new(
		_x1,
		_y1,
		_x2,
		_y2,
		get_duration(),
		get_initial_position(),
		get_final_position(),
		get_process(),
		completion)

#-------------------------------------------------------------------------------

var _x1 := GDUT_BezierMotionTransition.DEFAULT_X1
var _y1 := GDUT_BezierMotionTransition.DEFAULT_Y1
var _x2 := GDUT_BezierMotionTransition.DEFAULT_X2
var _y2 := GDUT_BezierMotionTransition.DEFAULT_Y2
