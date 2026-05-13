class_name BezierMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target() -> MotionTarget:
	return _transition_factory.get_target()

func preset(preset_name: StringName) -> BezierMotionExpression:
	_transition_factory.load_preset(preset_name)
	return self

func process(value: int) -> BezierMotionExpression:
	_transition_factory.set_process(value)
	return self

func process_idle() -> BezierMotionExpression:
	return super()

func process_physics() -> BezierMotionExpression:
	return super()

func duration(value: float) -> BezierMotionExpression:
	_transition_factory.set_duration(value)
	return self

func delay(value: float) -> BezierMotionExpression:
	_transition_factory.set_delay(value)
	return self

func loop(value: int) -> BezierMotionExpression:
	_transition_factory.set_loop(value)
	return self

func loop_delay(value: float) -> BezierMotionExpression:
	_transition_factory.set_loop_delay(value)
	return self

func alternate(value: bool) -> BezierMotionExpression:
	_transition_factory.set_alternate(value)
	return self

func reversed(value: bool) -> BezierMotionExpression:
	_transition_factory.set_reversed(value)
	return self

func from(value: Variant) -> BezierMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

func to(value: Variant) -> BezierMotionExpression:
	_transition_factory.set_final_position(value)
	return self

func x1(value: float) -> BezierMotionExpression:
	_transition_factory.set_x1(value)
	return self

func y1(value: float) -> BezierMotionExpression:
	_transition_factory.set_y1(value)
	return self

func x2(value: float) -> BezierMotionExpression:
	_transition_factory.set_x2(value)
	return self

func y2(value: float) -> BezierMotionExpression:
	_transition_factory.set_y2(value)
	return self

func cp1(value: Vector2) -> BezierMotionExpression:
	_transition_factory.set_x1(value.x)
	_transition_factory.set_y1(value.y)
	return self

func cp2(value: Vector2) -> BezierMotionExpression:
	_transition_factory.set_x2(value.x)
	_transition_factory.set_y2(value.y)
	return self

func wait(cancel: Cancel = null) -> Variant:
	return await _completion.wait(cancel)

#-------------------------------------------------------------------------------

const _BEZIER_CLASS := preload("uid://g6bi36a3g1s3")

var _completion: Task
var _transition_factory: _BEZIER_CLASS

func _init(
	completion: Task,
	transition_factory: _BEZIER_CLASS) -> void:

	assert(is_instance_valid(completion))
	assert(is_instance_valid(transition_factory))

	_completion = completion
	_transition_factory = transition_factory
