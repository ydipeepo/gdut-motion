## Motion expression.
##
## These motion expressions are used through [Motion].
@abstract
class_name MotionExpression extends Awaitable

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

## Updated on idle frames.
const PROCESS_IDLE := GDUT_MotionTransition.PROCESS_IDLE
## Updated on physics frames.
const PROCESS_PHYSICS := GDUT_MotionTransition.PROCESS_PHYSICS

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

@abstract
func get_target() -> GDUT_MotionTarget

## Loads a preset.
@abstract
func preset(value: StringName) -> MotionExpression

## Sets the update timing.
@abstract
func process(value: int) -> MotionExpression

## Sets the update timing to [constant PROCESS_IDLE].
func process_idle() -> MotionExpression:
	return process(PROCESS_IDLE)

## Sets the update timing to [constant PROCESS_PHYSICS].
func process_physics() -> MotionExpression:
	return process(PROCESS_PHYSICS)

## Sets the delay.
@abstract
func delay(value: float) -> MotionExpression

## Sets a Tween motion to continue from this expression.
func then_tween() -> TweenMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var transition_factory := GDUT_TweenMotionTransitionFactory.new(get_target())
	return TweenMotionExpression.new(
		canonical.schedule_transition(transition_factory, true),
		transition_factory)

## Sets a Bezier motion to continue from this expression.
func then_bezier() -> BezierMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var transition_factory := GDUT_BezierMotionTransitionFactory.new(get_target())
	return BezierMotionExpression.new(
		canonical.schedule_transition(transition_factory, true),
		transition_factory)

## Sets a Linear motion to continue from this expression.
func then_linear() -> LinearMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var transition_factory := GDUT_LinearMotionTransitionFactory.new(get_target())
	return LinearMotionExpression.new(
		canonical.schedule_transition(transition_factory, true),
		transition_factory)

## Sets a Steps motion to continue from this expression.
func then_steps() -> StepsMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var transition_factory := GDUT_StepsMotionTransitionFactory.new(get_target())
	return StepsMotionExpression.new(
		canonical.schedule_transition(transition_factory, true),
		transition_factory)

## Sets an Irregular motion to continue from this expression.
func then_irregular() -> IrregularMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var transition_factory := GDUT_IrregularMotionTransitionFactory.new(get_target())
	return IrregularMotionExpression.new(
		canonical.schedule_transition(transition_factory, true),
		transition_factory)

## Sets a Spring motion to continue from this expression.
func then_spring() -> SpringMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var transition_factory := GDUT_SpringMotionTransitionFactory.new(get_target())
	return SpringMotionExpression.new(
		canonical.schedule_transition(transition_factory, true),
		transition_factory)

## Sets a Glide motion to continue from this expression.
func then_glide() -> GlideMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var transition_factory := GDUT_GlideMotionTransitionFactory.new(get_target())
	return GlideMotionExpression.new(
		canonical.schedule_transition(transition_factory, true),
		transition_factory)

## Waits until this motion is complete.[br]
## [br]
## Use this when you want to wait for the motion to finish.
## [codeblock]
## await Motion \
##     .tween(self, "position:x") \
##     .to(500.0) \
##     .wait()
## print("Done")
## [/codeblock]
func wait(cancel: Cancel = null) -> Variant:
	return await _completion.wait(cancel)

#-------------------------------------------------------------------------------

var _completion: Task

func _init(completion: Task) -> void:
	assert(completion != null)

	_completion = completion
