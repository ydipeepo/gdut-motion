## Provides a collection of helper methods for creating and
## scheduling motion transitions.
##
## Motion acts as the main entry point for creating [MotionExpression]s
## such as decay, easing, spring, tween, and other transition types.
## Each transition targets a [MotionTarget], which wraps a property or
## method that will be animated over time.
## Transitions are automatically scheduled and started through the
## active motion processor and return [MotionExpression] objects derived from
## [Awaitable] for further configuration and chaining.
class_name Motion

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

## Schedules a [MotionTransitionFactory] for execution.
## Returns a [Task] that represents the scheduled transition.
static func schedule_transition_factory(
	transition_factory: MotionTransitionFactory,
	transition_skip_time := 0.0) -> Task:

	assert(is_instance_valid(transition_factory))

	const AUTOLOAD_CLASS := preload("uid://p04dph4xrfh3")

	if not AUTOLOAD_CLASS.has_current():
		AUTOLOAD_CLASS.print_error(&"ADDON_NOT_READY")
		return Task.canceled()

	return AUTOLOAD_CLASS \
		.get_current() \
		.schedule_transition_factory(
			transition_factory,
			transition_skip_time)

#region Base transitions

## Schedules a decay transition using a [MotionTarget].
static func decay_target(
	target: MotionTarget,
	transition_skip_time := 0.0) -> DecayMotionExpression:

	if is_instance_valid(target) and target.is_valid():
		var transition_factory := preload("uid://4jaswbuq2e7w").new(target)
		var completion := schedule_transition_factory(
			transition_factory,
			transition_skip_time)
		if not completion.is_canceled():
			return DecayMotionExpression.new(
				completion,
				transition_factory)
	return null

## Schedules a decay transition targeting an object's property.
## [codeblock]
## Motion.tween($Sprite2D, ^"position:x").duration(1.0).to(100.0)
## await Task.delay(0.2)
## # It maintains the velocity and comes to a slow stop.
## Motion.decay($Sprite2D, ^"position:x").power(0.1).time_constant(0.1)
## [/codeblock]
static func decay(
	target_object: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> DecayMotionExpression:

	var target := MotionTarget.create_property(
		target_object,
		target_property_path,
		target_value_type_hint)
	return decay_target(
		target,
		transition_skip_time)

## Schedules a decay transition targeting a method name.
static func decay_method_name(
	target_object: Object,
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> DecayMotionExpression:

	var target := MotionTarget.create_method_name(
		target_object,
		target_method_name,
		target_value_type_hint)
	return decay_target(
		target,
		transition_skip_time)

## Schedules a decay transition targeting a [Callable] method.
static func decay_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> DecayMotionExpression:

	var target := MotionTarget.create_method(
		target_method,
		target_value_type_hint)
	return decay_target(
		target,
		transition_skip_time)

## Schedules an easing transition using a [MotionTarget].
static func easing_target(
	target: MotionTarget,
	transition_skip_time := 0.0) -> EasingMotionExpression:

	if is_instance_valid(target) and target.is_valid():
		var transition_factory := preload("uid://cvoofu1h8pec1").new(target)
		var completion := schedule_transition_factory(
			transition_factory,
			transition_skip_time)
		if not completion.is_canceled():
			return EasingMotionExpression.new(
				completion,
				transition_factory)
	return null

## Schedules an easing transition targeting an object's property.
static func easing(
	target_object: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> EasingMotionExpression:

	var target := MotionTarget.create_property(
		target_object,
		target_property_path,
		target_value_type_hint)
	return easing_target(
		target,
		transition_skip_time)

## Schedules an easing transition targeting a method name.
static func easing_method_name(
	target_object: Object,
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> EasingMotionExpression:

	var target := MotionTarget.create_method_name(
		target_object,
		target_method_name,
		target_value_type_hint)
	return easing_target(
		target,
		transition_skip_time)

## Schedules an easing transition targeting a [Callable] method.
static func easing_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> EasingMotionExpression:

	var target := MotionTarget.create_method(
		target_method,
		target_value_type_hint)
	return easing_target(
		target,
		transition_skip_time)

## Schedules a spring transition using a [MotionTarget].
static func spring_target(
	target: MotionTarget,
	transition_skip_time := 0.0) -> SpringMotionExpression:

	if is_instance_valid(target) and target.is_valid():
		var transition_factory := preload("uid://cu530wnsnvp3d").new(target)
		var completion := schedule_transition_factory(
			transition_factory,
			transition_skip_time)
		if not completion.is_canceled():
			return SpringMotionExpression.new(
				completion,
				transition_factory)
	return null

## Schedules a spring transition targeting an object's property.
## [codeblock]
## for i in 10:
##     # It maintains the previous speed and continues the spring motion.
##     Motion.spring($Sprite2D, ^"position").to(Vector2(randf(), randf()) * 100.0)
##     await Task.delay(0.25)
## [/codeblock]
static func spring(
	target_object: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> SpringMotionExpression:

	var target := MotionTarget.create_property(
		target_object,
		target_property_path,
		target_value_type_hint)
	return spring_target(
		target,
		transition_skip_time)

## Schedules a spring transition targeting a method name.
static func spring_method_name(
	target_object: Object,
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> SpringMotionExpression:

	var target := MotionTarget.create_method_name(
		target_object,
		target_method_name,
		target_value_type_hint)
	return spring_target(
		target,
		transition_skip_time)

## Schedules a spring transition targeting a [Callable] method.
static func spring_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> SpringMotionExpression:

	var target := MotionTarget.create_method(
		target_method,
		target_value_type_hint)
	return spring_target(
		target,
		transition_skip_time)

#endregion

#region Derived transitions

## Schedules a back transition using a [MotionTarget].
static func back_target(
	target: MotionTarget,
	transition_skip_time := 0.0) -> BackMotionExpression:

	if is_instance_valid(target) and target.is_valid():
		var transition_factory := preload("uid://bjpg1boh2yayy").new(target)
		var completion := schedule_transition_factory(
			transition_factory,
			transition_skip_time)
		if not completion.is_canceled():
			return BackMotionExpression.new(
				completion,
				transition_factory)
	return null

## Schedules a back transition targeting an object's property.
static func back(
	target_object: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> BackMotionExpression:

	var target := MotionTarget.create_property(
		target_object,
		target_property_path,
		target_value_type_hint)
	return back_target(
		target,
		transition_skip_time)

## Schedules a back transition targeting a method name.
static func back_method_name(
	target_object: Object,
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> BackMotionExpression:

	var target := MotionTarget.create_method_name(
		target_object,
		target_method_name,
		target_value_type_hint)
	return back_target(
		target,
		transition_skip_time)

## Schedules a back transition targeting a [Callable] method.
static func back_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> BackMotionExpression:

	var target := MotionTarget.create_method(
		target_method,
		target_value_type_hint)
	return back_target(
		target,
		transition_skip_time)

## Schedules a bezier transition using a [MotionTarget].
static func bezier_target(
	target: MotionTarget,
	transition_skip_time := 0.0) -> BezierMotionExpression:

	if is_instance_valid(target) and target.is_valid():
		var transition_factory := preload("uid://g6bi36a3g1s3").new(target)
		var completion := schedule_transition_factory(
			transition_factory,
			transition_skip_time)
		if not completion.is_canceled():
			return BezierMotionExpression.new(
				completion,
				transition_factory)
	return null

## Schedules a bezier transition targeting an object's property.
static func bezier(
	target_object: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> BezierMotionExpression:

	var target := MotionTarget.create_property(
		target_object,
		target_property_path,
		target_value_type_hint)
	return bezier_target(
		target,
		transition_skip_time)

## Schedules a bezier transition targeting a method name.
static func bezier_method_name(
	target_object: Object,
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> BezierMotionExpression:

	var target := MotionTarget.create_method_name(
		target_object,
		target_method_name,
		target_value_type_hint)
	return bezier_target(
		target,
		transition_skip_time)

## Schedules a bezier transition targeting a [Callable] method.
static func bezier_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> BezierMotionExpression:

	var target := MotionTarget.create_method(
		target_method,
		target_value_type_hint)
	return bezier_target(
		target,
		transition_skip_time)

## Schedules an elastic transition using a [MotionTarget].
static func elastic_target(
	target: MotionTarget,
	transition_skip_time := 0.0) -> ElasticMotionExpression:

	if is_instance_valid(target) and target.is_valid():
		var transition_factory := preload("uid://cyc32wca84jau").new(target)
		var completion := schedule_transition_factory(
			transition_factory,
			transition_skip_time)
		if not completion.is_canceled():
			return ElasticMotionExpression.new(
				completion,
				transition_factory)
	return null

## Schedules an elastic transition targeting an object's property.
static func elastic(
	target_object: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> ElasticMotionExpression:

	var target := MotionTarget.create_property(
		target_object,
		target_property_path,
		target_value_type_hint)
	return elastic_target(
		target,
		transition_skip_time)

## Schedules an elastic transition targeting a method name.
static func elastic_method_name(
	target_object: Object,
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> ElasticMotionExpression:

	var target := MotionTarget.create_method_name(
		target_object,
		target_method_name,
		target_value_type_hint)
	return elastic_target(
		target,
		transition_skip_time)

## Schedules an elastic transition targeting a [Callable] method.
static func elastic_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> ElasticMotionExpression:

	var target := MotionTarget.create_method(
		target_method,
		target_value_type_hint)
	return elastic_target(
		target,
		transition_skip_time)

## Schedules a linear transition using a [MotionTarget].
static func linear_target(
	target: MotionTarget,
	transition_skip_time := 0.0) -> LinearMotionExpression:

	if is_instance_valid(target) and target.is_valid():
		var transition_factory := preload("uid://cbnayo3750njw").new(target)
		var completion := schedule_transition_factory(
			transition_factory,
			transition_skip_time)
		if not completion.is_canceled():
			return LinearMotionExpression.new(
				completion,
				transition_factory)
	return null

## Schedules a linear transition targeting an object's property.
static func linear(
	target_object: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> LinearMotionExpression:

	var target := MotionTarget.create_property(
		target_object,
		target_property_path,
		target_value_type_hint)
	return linear_target(
		target,
		transition_skip_time)

## Schedules a linear transition targeting a method name.
static func linear_method_name(
	target_object: Object,
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> LinearMotionExpression:

	var target := MotionTarget.create_method_name(
		target_object,
		target_method_name,
		target_value_type_hint)
	return linear_target(
		target,
		transition_skip_time)

## Schedules a linear transition targeting a [Callable] method.
static func linear_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> LinearMotionExpression:

	var target := MotionTarget.create_method(
		target_method,
		target_value_type_hint)
	return linear_target(
		target,
		transition_skip_time)

## Schedules a power transition using a [MotionTarget].
static func power_target(
	target: MotionTarget,
	transition_skip_time := 0.0) -> PowerMotionExpression:

	if is_instance_valid(target) and target.is_valid():
		var transition_factory := preload("uid://b418k13gylvdc").new(target)
		var completion := schedule_transition_factory(
			transition_factory,
			transition_skip_time)
		if not completion.is_canceled():
			return PowerMotionExpression.new(
				completion,
				transition_factory)
	return null

## Schedules a power transition targeting an object's property.
static func power(
	target_object: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> PowerMotionExpression:

	var target := MotionTarget.create_property(
		target_object,
		target_property_path,
		target_value_type_hint)
	return power_target(
		target,
		transition_skip_time)

## Schedules a power transition targeting a method name.
static func power_method_name(
	target_object: Object,
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> PowerMotionExpression:

	var target := MotionTarget.create_method_name(
		target_object,
		target_method_name,
		target_value_type_hint)
	return power_target(
		target,
		transition_skip_time)

## Schedules a power transition targeting a [Callable] method.
static func power_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> PowerMotionExpression:

	var target := MotionTarget.create_method(
		target_method,
		target_value_type_hint)
	return power_target(
		target,
		transition_skip_time)

## Schedules a random transition using a [MotionTarget].
static func random_target(
	target: MotionTarget,
	transition_skip_time := 0.0) -> RandomMotionExpression:

	if is_instance_valid(target) and target.is_valid():
		var transition_factory := preload("uid://cp8mkaedusky0").new(target)
		var completion := schedule_transition_factory(
			transition_factory,
			transition_skip_time)
		if not completion.is_canceled():
			return RandomMotionExpression.new(
				completion,
				transition_factory)
	return null

## Schedules a random transition targeting an object's property.
static func random(
	target_object: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> RandomMotionExpression:

	var target := MotionTarget.create_property(
		target_object,
		target_property_path,
		target_value_type_hint)
	return random_target(
		target,
		transition_skip_time)

## Schedules a random transition targeting a method name.
static func random_method_name(
	target_object: Object,
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> RandomMotionExpression:

	var target := MotionTarget.create_method_name(
		target_object,
		target_method_name,
		target_value_type_hint)
	return random_target(
		target,
		transition_skip_time)

## Schedules a random transition targeting a [Callable] method.
static func random_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> RandomMotionExpression:

	var target := MotionTarget.create_method(
		target_method,
		target_value_type_hint)
	return random_target(
		target,
		transition_skip_time)

## Schedules a steps transition using a [MotionTarget].
static func steps_target(
	target: MotionTarget,
	transition_skip_time := 0.0) -> StepsMotionExpression:

	if is_instance_valid(target) and target.is_valid():
		var transition_factory := preload("uid://1qfbdejoesif").new(target)
		var completion := schedule_transition_factory(
			transition_factory,
			transition_skip_time)
		if not completion.is_canceled():
			return StepsMotionExpression.new(
				completion,
				transition_factory)
	return null

## Schedules a steps transition targeting an object's property.
static func steps(
	target_object: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> StepsMotionExpression:

	var target := MotionTarget.create_property(
		target_object,
		target_property_path,
		target_value_type_hint)
	return steps_target(
		target,
		transition_skip_time)

## Schedules a steps transition targeting a method name.
static func steps_method_name(
	target_object: Object,
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> StepsMotionExpression:

	var target := MotionTarget.create_method_name(
		target_object,
		target_method_name,
		target_value_type_hint)
	return steps_target(
		target,
		transition_skip_time)

## Schedules a steps transition targeting a [Callable] method.
static func steps_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> StepsMotionExpression:

	var target := MotionTarget.create_method(
		target_method,
		target_value_type_hint)
	return steps_target(
		target,
		transition_skip_time)

## Schedules a tween transition using a [MotionTarget].
static func tween_target(
	target: MotionTarget,
	transition_skip_time := 0.0) -> TweenMotionExpression:

	if is_instance_valid(target) and target.is_valid():
		var transition_factory := preload("uid://fxlxlw5pced6").new(target)
		var completion := schedule_transition_factory(
			transition_factory,
			transition_skip_time)
		if not completion.is_canceled():
			return TweenMotionExpression.new(
				completion,
				transition_factory)
	return null

## Schedules a tween transition targeting an object's property.
static func tween(
	target_object: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> TweenMotionExpression:

	var target := MotionTarget.create_property(
		target_object,
		target_property_path,
		target_value_type_hint)
	return tween_target(
		target,
		transition_skip_time)

## Schedules a tween transition targeting a method name.
static func tween_method_name(
	target_object: Object,
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> TweenMotionExpression:

	var target := MotionTarget.create_method_name(
		target_object,
		target_method_name,
		target_value_type_hint)
	return tween_target(
		target,
		transition_skip_time)

## Schedules a tween transition targeting a [Callable] method.
static func tween_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL,
	transition_skip_time := 0.0) -> TweenMotionExpression:

	var target := MotionTarget.create_method(
		target_method,
		target_value_type_hint)
	return tween_target(
		target,
		transition_skip_time)

#endregion
