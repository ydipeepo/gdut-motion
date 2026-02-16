## Tween motion expression.
class_name TweenMotionExpression extends MotionExpression

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

## Ease-in. Starts slow and accelerates towards the end. Same as [constant Tween.EASE_IN].
const EASE_IN := GDUT_TweenMotionTransition.EASE_IN
## Ease-out. Accelerates at the start and decelerates towards the end. Same as [constant Tween.EASE_OUT].
const EASE_OUT := GDUT_TweenMotionTransition.EASE_OUT
## Ease-in-out. Starts slow, accelerates in the middle, and decelerates at the end. Same as [constant Tween.EASE_IN_OUT].
const EASE_IN_OUT := GDUT_TweenMotionTransition.EASE_IN_OUT
## Ease-out-in. Accelerates at the start, decelerates in the middle, and accelerates at the end. Same as [constant Tween.EASE_OUT_IN].
const EASE_OUT_IN := GDUT_TweenMotionTransition.EASE_OUT_IN

## Linear interpolation. Values change at a constant speed. Same as [constant Tween.TRANS_LINEAR].
const TRANS_LINEAR := GDUT_TweenMotionTransition.TRANS_LINEAR
## Sine interpolation. Smooth acceleration and deceleration. Same as [constant Tween.TRANS_SINE].
const TRANS_SINE := GDUT_TweenMotionTransition.TRANS_SINE
## Quintic interpolation. Stronger acceleration/deceleration than quartic. Same as [constant Tween.TRANS_QUINT].
const TRANS_QUINT := GDUT_TweenMotionTransition.TRANS_QUINT
## Quartic interpolation. Smoother and stronger acceleration/deceleration than cubic. Same as [constant Tween.TRANS_QUART].
const TRANS_QUART := GDUT_TweenMotionTransition.TRANS_QUART
## Quadratic interpolation. Starts slowly and ends with acceleration. Same as [constant Tween.TRANS_QUAD].
const TRANS_QUAD := GDUT_TweenMotionTransition.TRANS_QUAD
## Exponential interpolation. Starts slowly and changes rapidly at the end. Same as [constant Tween.TRANS_EXPO].
const TRANS_EXPO := GDUT_TweenMotionTransition.TRANS_EXPO
## Elastic interpolation. Approaches the target value with a wobbling motion. Same as [constant Tween.TRANS_ELASTIC].
const TRANS_ELASTIC := GDUT_TweenMotionTransition.TRANS_ELASTIC
## Cubic interpolation. Smoother and more natural acceleration/deceleration than quadratic. Same as [constant Tween.TRANS_CUBIC].
const TRANS_CUBIC := GDUT_TweenMotionTransition.TRANS_CUBIC
## Circular interpolation. Smooth movement like drawing a circle. Same as [constant Tween.TRANS_CIRC].
const TRANS_CIRC := GDUT_TweenMotionTransition.TRANS_CIRC
## Bounce interpolation. Values change as if bouncing. Same as [constant Tween.TRANS_BOUNCE].
const TRANS_BOUNCE := GDUT_TweenMotionTransition.TRANS_BOUNCE
## Back interpolation. Overshoots slightly before reaching the target value. Same as [constant Tween.TRANS_BACK].
const TRANS_BACK := GDUT_TweenMotionTransition.TRANS_BACK
## Spring interpolation. Converges to the target value while oscillating. Same as [constant Tween.TRANS_SPRING].
const TRANS_SPRING := GDUT_TweenMotionTransition.TRANS_SPRING

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target() -> GDUT_MotionTarget:
	return _transition_factory.get_target()

## Loads a preset.
func preset(value: StringName) -> TweenMotionExpression:
	_transition_factory.load_preset(value)
	return self

## Sets the easing direction.
func ease(value: int) -> TweenMotionExpression:
	_transition_factory.set_ease(value)
	return self

## Sets the easing direction to [constant EASE_IN].
func ease_in() -> TweenMotionExpression:
	return self.ease(EASE_IN)

## Sets the easing direction to [constant EASE_OUT].
func ease_out() -> TweenMotionExpression:
	return self.ease(EASE_OUT)

## Sets the easing direction to [constant EASE_IN_OUT].
func ease_in_out() -> TweenMotionExpression:
	return self.ease(EASE_IN_OUT)

## Sets the easing direction to [constant EASE_OUT_IN].
func ease_out_in() -> TweenMotionExpression:
	return self.ease(EASE_OUT_IN)

## Sets the interpolation method.
func trans(value: int) -> TweenMotionExpression:
	_transition_factory.set_trans(value)
	return self

## Sets the interpolation method to [constant TRANS_LINEAR].
func trans_linear() -> TweenMotionExpression:
	return trans(TRANS_LINEAR)

## Sets the interpolation method to [constant TRANS_SINE].
func trans_sine() -> TweenMotionExpression:
	return trans(TRANS_SINE)

## Sets the interpolation method to [constant TRANS_QUINT].
func trans_quint() -> TweenMotionExpression:
	return trans(TRANS_QUINT)

## Sets the interpolation method to [constant TRANS_QUART].
func trans_quart() -> TweenMotionExpression:
	return trans(TRANS_QUART)

## Sets the interpolation method to [constant TRANS_QUAD].
func trans_quad() -> TweenMotionExpression:
	return trans(TRANS_QUAD)

## Sets the interpolation method to [constant TRANS_EXPO].
func trans_expo() -> TweenMotionExpression:
	return trans(TRANS_EXPO)

## Sets the interpolation method to [constant TRANS_ELASTIC].
func trans_elastic() -> TweenMotionExpression:
	return trans(TRANS_ELASTIC)

## Sets the interpolation method to [constant TRANS_CUBIC].
func trans_cubic() -> TweenMotionExpression:
	return trans(TRANS_CUBIC)

## Sets the interpolation method to [constant TRANS_CIRC].
func trans_circ() -> TweenMotionExpression:
	return trans(TRANS_CIRC)

## Sets the interpolation method to [constant TRANS_BOUNCE].
func trans_bounce() -> TweenMotionExpression:
	return trans(TRANS_BOUNCE)

## Sets the interpolation method to [constant TRANS_BACK].
func trans_back() -> TweenMotionExpression:
	return trans(TRANS_BACK)

## Sets the interpolation method to [constant TRANS_SPRING].
func trans_spring() -> TweenMotionExpression:
	return trans(TRANS_SPRING)

## Sets the duration.
func duration(value: float) -> TweenMotionExpression:
	_transition_factory.set_duration(value)
	return self

## Sets the initial position. If omitted, the current position is used.
func from(value: Variant) -> TweenMotionExpression:
	_transition_factory.set_initial_position(value)
	return self

## Sets the final position.
func to(value: Variant) -> TweenMotionExpression:
	_transition_factory.set_final_position(value)
	return self

## Sets the update timing.
func process(value: int) -> TweenMotionExpression:
	_transition_factory.set_process(value)
	return self

## Sets the update timing to [constant MotionExpression.PROCESS_IDLE].
func process_idle() -> TweenMotionExpression:
	return super()

## Sets the update timing to [constant MotionExpression.PROCESS_PHYSICS].
func process_physics() -> TweenMotionExpression:
	return super()

## Sets the delay.
func delay(value: float) -> TweenMotionExpression:
	_transition_factory.set_delay(value)
	return self

#-------------------------------------------------------------------------------

var _transition_factory: GDUT_TweenMotionTransitionFactory

func _init(
	completion: Task,
	transition_factory: GDUT_TweenMotionTransitionFactory) -> void:

	super(completion)

	assert(transition_factory != null)

	_transition_factory = transition_factory
