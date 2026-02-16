<<<<<<< Updated upstream
=======
## Motion expression.
##
## These motion expressions are used through [Motion].
>>>>>>> Stashed changes
@abstract
class_name MotionExpression extends Awaitable

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
const PROCESS_IDLE := GDUT_MotionTransition.PROCESS_IDLE
=======
## Updated on idle frames.
const PROCESS_IDLE := GDUT_MotionTransition.PROCESS_IDLE
## Updated on physics frames.
>>>>>>> Stashed changes
const PROCESS_PHYSICS := GDUT_MotionTransition.PROCESS_PHYSICS

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

@abstract
<<<<<<< Updated upstream
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

=======
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
>>>>>>> Stashed changes
func then_tween() -> TweenMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

<<<<<<< Updated upstream
	var transition_factory := GDUT_TweenMotionTransitionFactory.new(get_proxy())
=======
	var transition_factory := GDUT_TweenMotionTransitionFactory.new(get_target())
>>>>>>> Stashed changes
	return TweenMotionExpression.new(
		canonical.schedule_transition(transition_factory, true),
		transition_factory)

<<<<<<< Updated upstream
=======
## Sets a Bezier motion to continue from this expression.
>>>>>>> Stashed changes
func then_bezier() -> BezierMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

<<<<<<< Updated upstream
	var transition_factory := GDUT_BezierMotionTransitionFactory.new(get_proxy())
=======
	var transition_factory := GDUT_BezierMotionTransitionFactory.new(get_target())
>>>>>>> Stashed changes
	return BezierMotionExpression.new(
		canonical.schedule_transition(transition_factory, true),
		transition_factory)

<<<<<<< Updated upstream
=======
## Sets a Linear motion to continue from this expression.
>>>>>>> Stashed changes
func then_linear() -> LinearMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

<<<<<<< Updated upstream
	var transition_factory := GDUT_LinearMotionTransitionFactory.new(get_proxy())
=======
	var transition_factory := GDUT_LinearMotionTransitionFactory.new(get_target())
>>>>>>> Stashed changes
	return LinearMotionExpression.new(
		canonical.schedule_transition(transition_factory, true),
		transition_factory)

<<<<<<< Updated upstream
=======
## Sets a Steps motion to continue from this expression.
>>>>>>> Stashed changes
func then_steps() -> StepsMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

<<<<<<< Updated upstream
	var transition_factory := GDUT_StepsMotionTransitionFactory.new(get_proxy())
=======
	var transition_factory := GDUT_StepsMotionTransitionFactory.new(get_target())
>>>>>>> Stashed changes
	return StepsMotionExpression.new(
		canonical.schedule_transition(transition_factory, true),
		transition_factory)

<<<<<<< Updated upstream
=======
## Sets an Irregular motion to continue from this expression.
>>>>>>> Stashed changes
func then_irregular() -> IrregularMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

<<<<<<< Updated upstream
	var transition_factory := GDUT_IrregularMotionTransitionFactory.new(get_proxy())
=======
	var transition_factory := GDUT_IrregularMotionTransitionFactory.new(get_target())
>>>>>>> Stashed changes
	return IrregularMotionExpression.new(
		canonical.schedule_transition(transition_factory, true),
		transition_factory)

<<<<<<< Updated upstream
=======
## Sets a Spring motion to continue from this expression.
>>>>>>> Stashed changes
func then_spring() -> SpringMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

<<<<<<< Updated upstream
	var transition_factory := GDUT_SpringMotionTransitionFactory.new(get_proxy())
=======
	var transition_factory := GDUT_SpringMotionTransitionFactory.new(get_target())
>>>>>>> Stashed changes
	return SpringMotionExpression.new(
		canonical.schedule_transition(transition_factory, true),
		transition_factory)

<<<<<<< Updated upstream
=======
## Sets a Glide motion to continue from this expression.
>>>>>>> Stashed changes
func then_glide() -> GlideMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

<<<<<<< Updated upstream
	var transition_factory := GDUT_GlideMotionTransitionFactory.new(get_proxy())
=======
	var transition_factory := GDUT_GlideMotionTransitionFactory.new(get_target())
>>>>>>> Stashed changes
	return GlideMotionExpression.new(
		canonical.schedule_transition(transition_factory, true),
		transition_factory)

<<<<<<< Updated upstream
=======
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
>>>>>>> Stashed changes
func wait(cancel: Cancel = null) -> Variant:
	return await _completion.wait(cancel)

#-------------------------------------------------------------------------------

var _completion: Task

func _init(completion: Task) -> void:
	assert(completion != null)

	_completion = completion
