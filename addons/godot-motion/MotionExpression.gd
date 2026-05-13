## Abstract base class for all [MotionExpression] types.
##
## MotionExpression provides a fluent interface for
## configuring and awaiting [MotionTransition].
@abstract
class_name MotionExpression extends Awaitable

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

## Updates the transition during the idle process step.
const PROCESS_IDLE := MotionTransition.PROCESS_IDLE

## Updates the transition during the physics process step.
const PROCESS_PHYSICS := MotionTransition.PROCESS_PHYSICS

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

## Returns the [MotionTarget] associated with this expression.
@abstract
func get_target() -> MotionTarget

## Applies a [MotionPreset] configuration to this expression.
@abstract
func preset(preset_name: StringName) -> MotionExpression

## Sets the process mode used to update the transition.
@abstract
func process(value: int) -> MotionExpression

## Configures the transition to update during idle processing.
func process_idle() -> MotionExpression:
	return process(PROCESS_IDLE)

## Configures the transition to update during physics processing.
func process_physics() -> MotionExpression:
	return process(PROCESS_PHYSICS)

## Waits for the transition to finish.[br]
## [b]Note:[/b] Returns the number of seconds exceeded beyond the
## transition completion time.
## [codeblock]
## var excess := await Motion.tween($Button, ^"modulate:a").to(0.0).wait()
## # Carry over the excess time accumulated between process frames.
## await Motion.tween($Button, ^"modulate:a", TYPE_FLOAT, excess).to(1.0).wait()
## [/codeblock]
@abstract
func wait(cancel: Cancel = null) -> Variant
