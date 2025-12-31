@abstract
class_name MotionExpression extends Awaitable

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const PROCESS_IDLE := GDUT_MotionTransition.PROCESS_IDLE
const PROCESS_PHYSICS := GDUT_MotionTransition.PROCESS_PHYSICS

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

@abstract
func get_proxy() -> MotionProxy

@abstract
func preset(value: StringName) -> MotionExpression

@abstract
func process(value: int) -> MotionExpression

func process_idle() -> MotionExpression:
	return process(PROCESS_IDLE)

func process_physics() -> MotionExpression:
	return process(PROCESS_PHYSICS)

@abstract
func delay(value: float) -> MotionExpression

func then_tween() -> TweenMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var transition_factory := GDUT_TweenMotionTransitionFactory.new(get_proxy())
	return TweenMotionExpression.new(
		canonical.schedule_transition(transition_factory, true),
		transition_factory)

func then_bezier() -> BezierMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var transition_factory := GDUT_BezierMotionTransitionFactory.new(get_proxy())
	return BezierMotionExpression.new(
		canonical.schedule_transition(transition_factory, true),
		transition_factory)

func then_linear() -> LinearMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var transition_factory := GDUT_LinearMotionTransitionFactory.new(get_proxy())
	return LinearMotionExpression.new(
		canonical.schedule_transition(transition_factory, true),
		transition_factory)

func then_steps() -> StepsMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var transition_factory := GDUT_StepsMotionTransitionFactory.new(get_proxy())
	return StepsMotionExpression.new(
		canonical.schedule_transition(transition_factory, true),
		transition_factory)

func then_irregular() -> IrregularMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var transition_factory := GDUT_IrregularMotionTransitionFactory.new(get_proxy())
	return IrregularMotionExpression.new(
		canonical.schedule_transition(transition_factory, true),
		transition_factory)

func then_spring() -> SpringMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var transition_factory := GDUT_SpringMotionTransitionFactory.new(get_proxy())
	return SpringMotionExpression.new(
		canonical.schedule_transition(transition_factory, true),
		transition_factory)

func then_glide() -> GlideMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var transition_factory := GDUT_GlideMotionTransitionFactory.new(get_proxy())
	return GlideMotionExpression.new(
		canonical.schedule_transition(transition_factory, true),
		transition_factory)

func wait(cancel: Cancel = null) -> Variant:
	return await _completion.wait(cancel)

#-------------------------------------------------------------------------------

var _completion: Task

func _init(completion: Task) -> void:
	assert(completion != null)

	_completion = completion
